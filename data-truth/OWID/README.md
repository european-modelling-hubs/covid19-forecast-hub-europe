Hospitalisation data
================

The files in this directory are listed below. For more details on these
see also the [data-truth](..) directory.

- `truth-OWID-Incident Hospitalizations.csv`: truth data set as weekly
  data, including data likely to be revised (see `status` column); the
  `date` column corresponds to the last date in each week.
- `truncated-OWID-Incident Hospitalizations.csv`: truth data set as
  weekly data, likely not to be revised substantially; the `date` column
  corresponds to the last date in each week.
- `recommended-cutoffs.csv`: estimated number of weeks to cut off unless
  able to correct for right truncation, as reflected in the `status`
  column of the data files
- `snapshots`: daily snapshots of the weekly raw hospitalisation data.
  Values indicate the number of new hospitalisations on the day
  indicated and the 6 preceding dates according to national definitions.
- `final`: daily snapshots of the final rwa hospitalisation data, where
  final status is assigned 28 days after the event. Values indicate the
  number of new hospitalisations on the day indicated and the 6
  preceding dates according to national definitions.
