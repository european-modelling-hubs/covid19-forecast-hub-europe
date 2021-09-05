"""
1 Model Setup
1.1 Mechanistic model for infections and deaths
The infection model simulates the number of infections in each country over time.
Input data are the timing and type of interventions, population size, and initial cases.
Parameters control the effectiveness of interventions and the rate of disease transmission.
The model for the expected number of deaths applies a fatality rate to the predicted infections.

The infection model performs a convolution of previous daily infections with the serial interval distributution
(the distribution over the number of days between becoming infected and infecting someone else).
At each time step, the number of new infections at time  t ,  nt , is calculated as

∑i=0t−1niμtp(caught from someone infected at i|newly infected at t)
where  μt=Rt  and the conditional probability is stored in conv_serial_interval, defined below.

The model for expected deaths performs a convolution of daily infections and the distribution of days between infection
 and death. That is, expected deaths on day  t  is calculated as

∑i=0t−1nip(death on day t|infection on day i)
where the conditional probability is stored in conv_fatality_rate, defined below.
"""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import collections
from pprint import pprint

import numpy as np
import pandas as pd

import matplotlib.pyplot as plt

# %config InlineBackend.figure_format = 'retina'

import tensorflow.compat.v2 as tf
import tensorflow_probability as tfp
import tensorflow_probability.python.layers as tfl
import tensorflow_probability.python.mcmc as tfm
from tensorflow_probability.python.internal import prefer_static as ps
from tensorflow_probability.python.internal import broadcast_util as bu
import tensorflow_probability.python.bijectors as tfb
import tensorflow_probability.python.distributions as tfd

tf.enable_v2_behavior()

# Globally Enable XLA.
# tf.config.optimizer.set_jit(True)

try:
    physical_devices = tf.config.list_physical_devices('GPU')
    tf.config.experimental.set_memory_growth(physical_devices[0], True)
except:
    # Invalid device or cannot modify virtual devices once initialized.
    pass

DTYPE = np.float32
START_DAYS = 30

unconstraining_bijectors = [
        tfb.Chain([tfb.Scale(tf.constant(1 / 0.03, DTYPE)), tfb.Softplus(),
                   tfb.SinhArcsinh(tailweight=tf.constant(1.85, DTYPE))]),  # tau
        tfb.Chain([tfb.Scale(tf.constant(1 / 0.03, DTYPE)), tfb.Softplus(),
                   tfb.SinhArcsinh(tailweight=tf.constant(1.85, DTYPE))]),  # initial_cases
        tfb.Softplus(),  # psi
        tfb.Softplus(),  # kappa
        tfb.Softplus(),  # mu
        tfb.Chain([tfb.Scale(tf.constant(0.4, DTYPE)), tfb.Softplus(),
                   tfb.SinhArcsinh(skewness=tf.constant(-0.2, DTYPE), tailweight=tf.constant(2., DTYPE))]),  # alpha
        tfb.Softplus(),  # ifr_noise
    ]


def predict_infections(population, initial_cases, mu, alpha_hier,
                       conv_serial_interval, initial_days, total_days):
    """Predict the number of infections by forward-simulation.

  Args:
    intervention_indicators: Binary array of shape
      `[num_countries, total_days, num_interventions]`, in which `1` indicates
      the intervention is active in that country at that time and `0` indicates
      otherwise.
    population: Vector of length `num_countries`. Population of each country.
    initial_cases: Array of shape `[batch_size, num_countries]`. Number of cases
      in each country at the start of the simulation.
    mu: Array of shape `[batch_size, num_countries]`. Initial reproduction rate
      (R_0) by country.
    alpha_hier: Array of shape `[batch_size, num_interventions]` representing
      the effectiveness of interventions.
    conv_serial_interval: Array of shape
      `[total_days - initial_days, total_days]` output from
      `make_conv_serial_interval`. Convolution kernel for serial interval
      distribution.
    initial_days: Integer, number of sequential days to seed infections after
      the 10th death in a country. (N0 in the authors' Stan code.)
    total_days: Integer, number of days of observed data plus days to forecast.
      (N2 in the authors' Stan code.)
  Returns:
    predicted_infections: Array of shape
      `[total_days, batch_size, num_countries]`. (Batched) predicted number of
      infections over time and by country.
  """
    alpha = alpha_hier - tf.cast(np.log(1.05) / 6.0, DTYPE)

    # Multiply the effectiveness of each intervention in each country (alpha)
    # by the indicator variable for whether the intervention was active and sum
    # over interventions, yielding an array of shape
    # [total_days, batch_size, num_countries] that represents the total effectiveness of
    # all interventions in each country on each day (for a batch of data).
    # linear_prediction = tf.einsum(
    #   'ijk,...k->j...i', intervention_indicators, alpha)

    # Adjust the reproduction rate per country downward, according to the
    # effectiveness of the interventions.
    rt = mu  # * tf.exp(-linear_prediction, name='reproduction_rate')

    # Initialize storage array for daily infections and seed it with initial
    # cases.
    daily_infections = tf.TensorArray(
      dtype=DTYPE, size=total_days, element_shape=initial_cases.shape)
    for i in range(initial_days):
        daily_infections = daily_infections.write(i, initial_cases)

    # Initialize cumulative cases.
    init_cumulative_infections = initial_cases * initial_days

    # Simulate forward for total_days days.
    cond = lambda i, *_: i < total_days

    def body(i, prev_daily_infections, prev_cumulative_infections):
        # The probability distribution over days j that someone infected on day i
        # caught the virus from someone infected on day j.
        p_infected_on_day = tf.gather(
            conv_serial_interval, i - initial_days, axis=0)

        # Multiply p_infected_on_day by the number previous infections each day and
        # by mu, and sum to obtain new infections on day i. Mu is adjusted by
        # the fraction of the population already infected, so that the population
        # size is the upper limit on the number of infections.
        prev_daily_infections_array = prev_daily_infections.stack()
        to_sum = prev_daily_infections_array * bu.left_justified_expand_dims_like(
            p_infected_on_day, prev_daily_infections_array)
        convolution = tf.reduce_sum(to_sum, axis=0)
        rt_adj = (
            (population - prev_cumulative_infections) / population
            ) * tf.gather(rt, i)
        new_infections = rt_adj * convolution

        # Update the prediction array and the cumulative number of infections.
        daily_infections = prev_daily_infections.write(i, new_infections)
        cumulative_infections = prev_cumulative_infections + new_infections
        return i + 1, daily_infections, cumulative_infections

    _, daily_infections_final, last_cumm_sum = tf.while_loop(
      cond, body,
      (initial_days, daily_infections, init_cumulative_infections),
      maximum_iterations=(total_days - initial_days))
    return daily_infections_final.stack()


def predict_deaths(predicted_infections, ifr_noise, conv_fatality_rate):
    """Expected number of reported deaths by country, by day.

    Args:
    predicted_infections: Array of shape
      `[total_days, batch_size, num_countries]` output from
      `predict_infections`.
    ifr_noise: Array of shape `[batch_size, num_countries]`. Noise in Infection
      Fatality Rate (IFR).
    conv_fatality_rate: Array of shape
      `[total_days - 1, total_days, num_countries]`. Convolutional kernel for
      calculating fatalities, output from `make_conv_fatality_rate`.
    Returns:
    predicted_deaths: Array of shape `[total_days, batch_size, num_countries]`.
      (Batched) predicted number of deaths over time and by country.
    """
    # Multiply the number of infections on day j by the probability of death
    # on day i given infection on day j, and sum over j. This yields the expected
    result_remainder = tf.einsum(
      'i...j,kij->k...j', predicted_infections, conv_fatality_rate) * ifr_noise

    # Concatenate the result with a vector of zeros so that the first day is
    # included.
    result_temp = 1e-15 * predicted_infections[:1]
    return tf.concat([result_temp, result_remainder], axis=0)


"""
1.2 Prior over parameter values
Here we define the joint prior distribution over the model parameters. 
Many of the parameter values are assumed to be independent, such that the prior can be expressed as:

p(τ,y,ψ,κ,μ,α)=p(τ)p(y|τ)p(ψ)p(κ)p(μ|κ)p(α)p(ϵ) 

in which:

τ  is the shared rate parameter of the Exponential distribution over the number of initial cases per country, 
 y=y1,...ynum_countries .
ψ  is a parameter in the Negative Binomial distribution for number of deaths.
κ  is the shared scale parameter of the HalfNormal distribution over the initial reproduction number in each country, 
 μ=μ1,...,μnum_countries  (indicating the number of additional cases transmitted by each infected person).
α=α1,...,α6  is the effectiveness of each of the six interventions.
ϵ  (called ifr_noise in the code, after the authors' Stan code) is noise in the Infection Fatality Rate (IFR).
We express this model as a TFP JointDistribution, a type of TFP distribution that enables expression of probabilistic
 graphical models.
"""


def make_jd_prior(num_countries):
    return tfd.JointDistributionSequentialAutoBatched([
      # Rate parameter for the distribution of initial cases (tau).
      tfd.Exponential(rate=tf.cast(0.03, DTYPE)),

      # Initial cases for each country.
      lambda tau: tfd.Sample(
          tfd.Exponential(rate=tf.cast(1, DTYPE) / tau),
          sample_shape=num_countries),

      # Parameter in Negative Binomial model for deaths (psi).
      tfd.HalfNormal(scale=tf.cast(5, DTYPE)),

      # Parameter in the distribution over the initial reproduction number, R_0
      # (kappa).
      tfd.HalfNormal(scale=tf.cast(0.5, DTYPE)),

      # Initial reproduction number, R_0, for each country (mu).
      lambda kappa: tfd.Sample(
          tfd.TruncatedNormal(loc=3.28, scale=kappa, low=1e-5, high=1e5),
          sample_shape=num_countries),

      # Impact of interventions (alpha; shared for all countries).
      # tfd.Sample(
      #     tfd.Gamma(tf.cast(0.1667, DTYPE), 1), sample_shape=num_interventions),

      # Multiplicative noise in Infection Fatality Rate.
      # tfd.Sample(
      #     tfd.TruncatedNormal(
      #         loc=tf.cast(1., DTYPE), scale=0.1, low=1e-5, high=1e5), sample_shape=num_countries)
    ])


"""
1.3 Likelihood of observed deaths conditional on parameter values
The likelihood model expresses  p(deaths|τ,y,ψ,κ,μ,α,ϵ) . 
It applies the models for the number of infections and expected deaths conditional on parameters, 
and assumes actual deaths follow a Negative Binomial distribution.
"""


def make_likelihood_fn(deaths, infection_fatality_rate, initial_days, total_days):

    # Create a mask for the initial days of simulated data, as they are not
    # counted in the likelihood.
    observed_deaths = tf.constant(deaths.T[np.newaxis, ...], dtype=DTYPE)
    mask_temp = deaths != -1
    mask_temp[:, :START_DAYS] = False
    observed_deaths_mask = tf.constant(mask_temp.T[np.newaxis, ...])

    conv_serial_interval = make_conv_serial_interval(initial_days, total_days)
    conv_fatality_rate = make_conv_fatality_rate(
      infection_fatality_rate, total_days)

    def likelihood_fn(tau, initial_cases, psi, kappa, mu, alpha_hier, ifr_noise):
        # Run models for infections and expected deaths
        predicted_infections = predict_infections(
            initial_cases, mu, alpha_hier,
            conv_serial_interval, initial_days, total_days)
        e_deaths_all_countries = predict_deaths(
            predicted_infections, ifr_noise, conv_fatality_rate)

        # Construct the Negative Binomial distribution for deaths by country.
        mu_m = tf.transpose(e_deaths_all_countries, [1, 0, 2])
        psi_m = psi[..., tf.newaxis, tf.newaxis]
        probs = tf.clip_by_value(mu_m / (mu_m + psi_m), 1e-9, 1.)
        likelihood_elementwise = tfd.NegativeBinomial(
            total_count=psi_m, probs=probs).log_prob(observed_deaths)
        return tf.reduce_sum(
            tf.where(observed_deaths_mask,
                     likelihood_elementwise,
                     tf.zeros_like(likelihood_elementwise)),
            axis=[-2, -1])

    return likelihood_fn


"""
1.4 Probability of death given infection
This section computes the distribution of deaths on the days following infection.
It assumes the time from infection to death is the sum of two Gamma-variate quantities, 
representing the time from infection to disease onset and the time from onset to death. 
The time-to-death distribution is combined with Infection Fatality Rate data from Verity et al. (2020) to compute
the probability of death on days following infection.
"""


def daily_fatality_probability(infection_fatality_rate, total_days):
    """Computes the probability of death `d` days after infection."""

    # Convert from alternative Gamma parametrization and construct distributions
    # for number of days from infection to onset and onset to death.
    concentration1 = tf.cast((1. / 0.86)**2, DTYPE)
    rate1 = concentration1 / 5.1
    concentration2 = tf.cast((1. / 0.45)**2, DTYPE)
    rate2 = concentration2 / 18.8
    infection_to_onset = tfd.Gamma(concentration=concentration1, rate=rate1)
    onset_to_death = tfd.Gamma(concentration=concentration2, rate=rate2)

    # Create empirical distribution for number of days from infection to death.
    inf_to_death_dist = tfd.Empirical(
      infection_to_onset.sample([5e6]) + onset_to_death.sample([5e6]))

    # Subtract the CDF value at day i from the value at day i + 1 to compute the
    # probability of death on day i given infection on day 0, and given that
    # death (not recovery) is the outcome.
    times = np.arange(total_days + 1., dtype=DTYPE) + 0.5
    cdf = inf_to_death_dist.cdf(times).numpy()
    f_before_ifr = cdf[1:] - cdf[:-1]
    # Explicitly set the zeroth value to the empirical cdf at time 1.5, to include
    # the mass between time 0 and time .5.
    f_before_ifr[0] = cdf[1]

    # Multiply the daily fatality rates conditional on infection and eventual
    # death (f_before_ifr) by the infection fatality rates (probability of death
    # given intection) to obtain the probability of death on day i conditional
    # on infection on day 0.
    return infection_fatality_rate[..., np.newaxis] * f_before_ifr


def make_conv_fatality_rate(infection_fatality_rate, total_days):
    """Computes the probability of death on day `i` given infection on day `j`."""
    p_fatal_all_countries = daily_fatality_probability(
      infection_fatality_rate, total_days)

    # Use the probability of death d days after infection in each country
    # to build an array of shape [total_days - 1, total_days, num_countries],
    # where the element [i, j, c] is the probability of death on day i+1 given
    # infection on day j in country c.
    conv_fatality_rate = np.zeros(
      [total_days - 1, total_days, p_fatal_all_countries.shape[0]])
    for n in range(1, total_days):
        conv_fatality_rate[n - 1, 0:n, :] = (
            p_fatal_all_countries[:, n - 1::-1]).T
    return tf.constant(conv_fatality_rate, dtype=DTYPE)


"""
1.5 Serial Interval
The serial interval is the time between successive cases in a chain of disease transmission, 
and is assumed to be Gamma distributed. We use the serial interval distribution to compute the probability that a 
person infected on day  i  caught the virus from a person previously infected
on day  j  (the conv_serial_interval argument to predict_infections).
"""


def make_conv_serial_interval(initial_days, total_days):
    """Construct the convolutional kernel for infection timing."""

    g = tfd.Gamma(tf.cast(1. / (0.62**2), DTYPE), 1./(6.5*0.62**2))
    g_cdf = g.cdf(np.arange(total_days, dtype=DTYPE))

    # Approximate the probability mass function for the number of days between
    # successive infections.
    serial_interval = g_cdf[1:] - g_cdf[:-1]

    # `conv_serial_interval` is an array of shape
    # [total_days - initial_days, total_days] in which entry [i, j] contains the
    # probability that an individual infected on day i + initial_days caught the
    # virus from someone infected on day j.
    conv_serial_interval = np.zeros([total_days - initial_days, total_days])
    for n in range(initial_days, total_days):
        conv_serial_interval[n - initial_days, 0:n] = serial_interval[n - 1::-1]
    return tf.constant(conv_serial_interval, dtype=DTYPE)


def get_bijectors_from_samples(samples, batch_axes):
    """Fit bijectors to the samples of a distribution.

    This fits a diagonal covariance multivariate Gaussian transformed by the
    `unconstraining_bijectors` to the provided samples. The resultant
    transformation can be used to precondition MCMC and other inference methods.
    """
    state_std = [
      tf.math.reduce_std(bij.inverse(x), axis=batch_axes)
      for x, bij in zip(samples, unconstraining_bijectors)
    ]
    state_mu = [
      tf.math.reduce_mean(bij.inverse(x), axis=batch_axes)
      for x, bij in zip(samples, unconstraining_bijectors)
    ]
    return [tfb.Chain([cb, tfb.Shift(sh), tfb.Scale(sc)])
            for cb, sh, sc in zip(unconstraining_bijectors, state_mu, state_std)]


def generate_init_state_and_bijectors_from_prior(nchain, jd_prior):
    """Creates an initial MCMC state, and bijectors from the prior."""
    prior_samples = jd_prior.sample(4096)

    bijectors = get_bijectors_from_samples(
      prior_samples, batch_axes=0)

    init_state = [
        bij(tf.zeros([nchain] + list(s), DTYPE))
        for s, bij in zip(jd_prior.event_shape, bijectors)
    ]

    return init_state, bijectors


@tf.function(autograph=False, experimental_compile=True)
def sample_hmc(
    init_state,
    step_size,
    target_log_prob_fn,
    num_steps=500,
    burnin=50,
    num_leapfrog_steps=10):

    def trace_fn(_, pkr):
        return {
            'target_log_prob': pkr.inner_results.inner_results.accepted_results.target_log_prob,
            'diverging': ~(pkr.inner_results.inner_results.log_accept_ratio > -1000.),
            'is_accepted': pkr.inner_results.inner_results.is_accepted,
            'step_size': [tf.exp(s) for s in pkr.log_averaging_step],
        }

    hmc = tfm.HamiltonianMonteCarlo(
        target_log_prob_fn,
        step_size=step_size,
        num_leapfrog_steps=num_leapfrog_steps)

    hmc = tfm.TransformedTransitionKernel(
        inner_kernel=hmc,
        bijector=unconstraining_bijectors)

    hmc = tfm.DualAveragingStepSizeAdaptation(
        hmc,
        num_adaptation_steps=int(burnin * 0.8),
        target_accept_prob=0.8,
        decay_rate=0.5)

    # Sampling from the chain.
    return tfm.sample_chain(
        num_results=burnin + num_steps,
        current_state=init_state,
        kernel=hmc,
        trace_fn=trace_fn)


