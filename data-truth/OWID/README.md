Hospitalisation data
================

The files in this directory are listed below. For more details on these
see also the [data-truth](..) directory.

- `truth-OWID-Incident Hospitalizations.csv`: truth data set as a
  mixture of daily and weekly data (see `frequency` column), including
  data likely to be revised (see `status` column)
- `truth-OWID-Weekly Incident Hospitalizations.csv`: truth data set as
  weekly data, including data likely to be revised (see `status` column)
- `truncated-OWID-Incident Hospitalizations.csv`: truth data set as a
  mixture of daily and weekly data (see `frequency` column), likely not
  to be revised substantially
- `truncated-OWID-Weekly Incident Hospitalizations.csv`: truth data set
  as weekly data (see `frequency` column), likely not to be revised
  substantially
- `recommended-cutoffs.csv`: estimated number of weeks to cut off unless
  able to correct for right truncation, as reflected in the `status`
  column of the data files
- `snapshots`: daily snapshots of the raw hospitalisation data
- `final`: daily snapshots of the final data, where final status is
  assigned 28 days after the event.
