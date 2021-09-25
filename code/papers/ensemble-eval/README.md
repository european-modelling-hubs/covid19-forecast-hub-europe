Guide to code
================
25/09/2021

### Generate results

Results text including numbers and figures can be created with

``` r
rmarkdown::render(here::here("code", "papers", "ensemble-eval", "results.Rmd"))
```

### Data access

The raw datasets are 

- evaluation scores: [data/2021-08-23-evaluation-all-ensembles.csv](./data/2021-08-23-evaluation-all-ensembles.csv)
- weights for each ensemble: [data/weights.csv](./data/weights.csv)

To entirely re-create the evaluation scores used here, use:
[R/re-run-eval.R](code/papers/ensemble-eval/R/re-run-eval.R)

``` r
source(here::here("code", "papers", "ensemble-eval", "R", "re-run-eval.R"))
```

#### Additional material
- Run the evaluation process for all ensemble models together with all models in `data-processed`
   - This scores all ensemble types against both each other and all other forecasts. (The evaluation saved above only scores ensemble methods against each other)
   - [R/re-run-eval-against-all.R](R/re-run-eval-against-all.R)
