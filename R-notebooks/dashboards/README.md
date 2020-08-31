# Dashboards for covidcast quality assurance

- use the API to pull signals: https://cmu-delphi.github.io/delphi-epidata/api/covidcast.html
- make plots and tables that describe the data from many angles
- add new dashboards to the make.R

## Todo list

1. facebook
2. hsp (both)
3. combinations
4. cases/deaths

## Plot/table lists

1. number of responses by time (FB)
2. number of counties by time (FB)
3. chloropleth of indicator (FB)
4. correlations (FB) : see https://cmu-delphi.github.io/covidcast/R-notebooks/signal_correlations.html

## Description of [fb-deviations](fb-deviations.html)

* Chloropleths on first two tabs show (clockwise from top left) today's observation, the average of the previous two weeks, the t-stat for today, and the sd over the previous two weeks.

* NA's are removed from previous period.

* t-stat is (today-mean)/sd, each specific to the region.

* Plots are made using the `{covidcast}` package, so NA's should appear as whatever the `plot.covidcast_signal` defaultss to (not sure at the moment)

## Suggestions and thoughts

* Counts over time take a long time to pull from the API. It's fine to update these, but maybe put a bunch of indicators in one dashboard.

* Beside timeseries count plots, suggest one dashboard per indicator.

* Move to "Dashboard" rather than long html doc. In the `.Rmd`, this requires a simple change (see example that reproduces Ryan's fb-dashboard).

* One tab per "view" of the data.

* Try to do all api processing at the top of the `.Rmd` to allow caching if necessary.

* Chloropleths as deviations from previous week or some such. This should show if "today" has dramatic changes. (How far back should we look?)

* How to deal with `issue` vs `time_value`.

* Facebook signal doesn't really cover enough counties to make this relevant on a day-to-day basis.

* Plotting +/- deviations is not entirely trivial using the API plot function. Hack for now, but perhaps request some changes.

* move the make.R to an actual MAKEFILE


