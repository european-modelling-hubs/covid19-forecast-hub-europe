This is an evaluation of forecasts for Covid-19 case and death numbers
in 32 European countries submitted to the [European COVID-19 Forecast
Hub](https://covid19forecasthub.eu/). You can find more information on
the [European Forecast Hub Github
page](https://github.com/epiforecasts/covid19-forecast-hub-europe).

This report is intended as a basic evaluation of forecasts that helps
modellers to better understand their performance. The structure and
visualisations are likely subject to change in the future and we cannot
rule out any mistakes. If you have questions or want to give feedback,
please create an issue on our [github
repository](https://github.com/epiforecasts/covid19-forecast-hub-europe).
Note that all forecast dates have been changed to the corresponding
submission date (every Monday) to allow easier comparison.

------------------------------------------------------------------------

# Forecast accuracy

Here is an overview of different evaluation metrics. See below for a
more detailed explanation of the scoring metrics used. ‘Overall’ shows
scores for all past weeks, ‘latest’ only spans the last 5-6 weeks of
data. ‘Detailed’ represents the full data set that you can download for
your own analysis.

### overall

<div id="htmlwidget-bfde8870ba95f624da24" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-bfde8870ba95f624da24">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiExpert","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha"],[0.61,0.68,0.71,0.73,0.97,1.09,1.99,2.24],[118.15,266.04,276.82,284.97,379.52,429.25,780.95,880.56],[89.9,259.06,269.07,267.21,126.87,424.95,206.25,668.24],[28.25,6.99,7.74,0,252.65,4.3,574.63,211.68],[0,0,0,17.76,0,0,0.07,0.64],[0.02,0.22,0.35,0.01,0.01,0.4,0.05,0.09],[-0.58,-0.3,-0.15,0.55,-0.55,-0.1,-0.4,-0.25],[186.13,66.28,168.08,197.5,696.89,99,1379.25,600]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-2ac25232ae81c7df7794" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-2ac25232ae81c7df7794">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiExpert","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha"],[0.61,0.68,0.71,0.73,0.97,1.09,1.99,2.24],[118.15,266.04,276.82,284.97,379.52,429.25,780.95,880.56],[89.9,259.06,269.07,267.21,126.87,424.95,206.25,668.24],[28.25,6.99,7.74,0,252.65,4.3,574.63,211.68],[0,0,0,17.76,0,0,0.07,0.64],[0.02,0.22,0.35,0.01,0.01,0.4,0.05,0.09],[-0.58,-0.3,-0.15,0.55,-0.55,-0.1,-0.4,-0.25],[186.13,66.28,168.08,197.5,696.89,99,1379.25,600]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-edc52cf522c5cb2c4dd6" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-edc52cf522c5cb2c4dd6">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiExpert","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha"],[0.61,0.66,0.71,0.71,0.98,1.09,2.03,2.28],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[467.67,508.83,542.41,542.66,752.99,835.49,1557.72,1746.36],[364.01,505.01,527.17,527.22,248.63,826.92,408.45,1323],[103.66,3.82,15.25,0,504.36,8.57,1149.27,423.36],[0,0,0,15.43,0,0,0,0],[0.21,0.4,0.31,0.31,-0.21,0.4,-0.3,-0.12],[-0.5,-0.1,-0.2,0.2,-0.8,-0.1,-0.9,-0.7],[725.62,87.95,330.63,347,1385.78,197,2755.5,1189]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-06a5ea431e9a48b5ffcc" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-06a5ea431e9a48b5ffcc">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","RobertWalraven-ESG","USC-SIkJalpha","ILM-EKF","IEM_Health-CovidProject","epiforecasts-EpiNow2"],[0.33,0.47,0.88,0.92,1.15,1.8,1.82,2.13],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[4.17,6.06,11.22,11.78,14.77,23.02,23.25,27.29],[4.04,5.12,10.98,6.48,13.49,22.98,13.1,7.2],[0,0.94,0.24,5.3,0,0.04,10.15,0],[0.13,0,0,0,1.28,0,0,20.09],[0.4,0.22,0.4,-0.04,0.31,0.4,0.05,-0.3],[0.1,-0.3,-0.1,-0.6,0.2,-0.1,-0.5,0.9],[3,8,5.52,21.94,11,1,44.61,48]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-f2a300ea7aa712e61098" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f2a300ea7aa712e61098">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiExpert","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha"],[0.61,0.68,0.71,0.73,0.97,1.09,1.99,2.24],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[118.15,266.04,276.82,284.97,379.52,429.25,780.95,880.56],[89.9,259.06,269.07,267.21,126.87,424.95,206.25,668.24],[28.25,6.99,7.74,0,252.65,4.3,574.63,211.68],[0,0,0,17.76,0,0,0.07,0.64],[0.02,0.22,0.35,0.01,0.01,0.4,0.05,0.09],[-0.58,-0.3,-0.15,0.55,-0.55,-0.1,-0.4,-0.25],[186.13,66.28,168.08,197.5,696.89,99,1379.25,600]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-b7d6ff38e736c9e5c956" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b7d6ff38e736c9e5c956">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["RobertWalraven-ESG","RobertWalraven-ESG","IEM_Health-CovidProject","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiNow2","epiforecasts-EpiExpert","epiforecasts-EpiExpert","ILM-EKF","ILM-EKF","LANL-GrowthRate","LANL-GrowthRate","USC-SIkJalpha","USC-SIkJalpha"],[0.61,0.61,0.68,0.68,0.71,0.71,0.73,0.73,0.97,0.97,1.09,1.09,1.99,1.99,2.24,2.24],["AT","AT","AT","AT","AT","AT","AT","AT","AT","AT","AT","AT","AT","AT","AT","AT"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Austria","Austria","Austria","Austria","Austria","Austria","Austria","Austria","Austria","Austria","Austria","Austria","Austria","Austria","Austria","Austria"],[8809212,8809212,8809212,8809212,8809212,8809212,8809212,8809212,8809212,8809212,8809212,8809212,8809212,8809212,8809212,8809212],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[467.67,11.78,508.83,23.25,542.41,11.22,542.66,27.29,752.99,6.06,835.49,23.02,1557.72,4.17,1746.36,14.77],[364.01,6.48,505.01,13.1,527.17,10.98,527.22,7.2,248.63,5.12,826.92,22.98,408.45,4.04,1323,13.49],[103.66,5.3,3.82,10.15,15.25,0.24,0,0,504.36,0.94,8.57,0.04,1149.27,0,423.36,0],[0,0,0,0,0,0,15.43,20.09,0,0,0,0,0,0.13,0,1.28],[0.21,-0.04,0.4,0.05,0.31,0.4,0.31,-0.3,-0.21,0.22,0.4,0.4,-0.3,0.4,-0.12,0.31],[-0.5,-0.6,-0.1,-0.5,-0.2,-0.1,0.2,0.9,-0.8,-0.3,-0.1,-0.1,-0.9,0.1,-0.7,0.2],[725.62,21.94,87.95,44.61,330.63,5.52,347,48,1385.78,8,197,1,2755.5,3,1189,11]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-0b0e7b29e9193ef543d7" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-0b0e7b29e9193ef543d7">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","epiforecasts-EpiNow2","ILM-EKF","EuroCOVIDhub-ensemble","USC-SIkJalpha","epiforecasts-EpiExpert","IEM_Health-CovidProject","LANL-GrowthRate"],[0.66,0.78,0.91,0.96,0.98,1.09,1.3,1.59],[227.62,547.3,642.7,678.07,689.5,766.3,917.55,1115.87],[167.2,382.28,469.09,427.11,364.1,213.19,640.49,474.13],[60.42,156.76,173.61,250.92,324.82,551.6,277.06,641.74],[0,8.26,0,0.05,0.57,1.51,0,0],[0.35,-0.08,0.27,0.22,0.18,-0.08,0.09,-0.17],[-0.19,0.25,-0.25,-0.2,-0.15,-0.25,-0.45,-0.75],[423.27,926.5,1051,1221.08,1527,1378.06,1577.47,2155.75]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-5f8ff8dd7a676529573d" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-5f8ff8dd7a676529573d">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","epiforecasts-EpiNow2","ILM-EKF","EuroCOVIDhub-ensemble","USC-SIkJalpha","epiforecasts-EpiExpert","IEM_Health-CovidProject","LANL-GrowthRate"],[0.66,0.78,0.91,0.96,0.98,1.09,1.3,1.59],[227.62,547.3,642.7,678.07,689.5,766.3,917.55,1115.87],[167.2,382.28,469.09,427.11,364.1,213.19,640.49,474.13],[60.42,156.76,173.61,250.92,324.82,551.6,277.06,641.74],[0,8.26,0,0.05,0.57,1.51,0,0],[0.35,-0.08,0.27,0.22,0.18,-0.08,0.09,-0.17],[-0.19,0.25,-0.25,-0.2,-0.15,-0.25,-0.45,-0.75],[423.27,926.5,1051,1221.08,1527,1378.06,1577.47,2155.75]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-1c169ef52ab881cb86c8" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1c169ef52ab881cb86c8">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","epiforecasts-EpiNow2","ILM-EKF","EuroCOVIDhub-ensemble","USC-SIkJalpha","epiforecasts-EpiExpert","IEM_Health-CovidProject","LANL-GrowthRate"],[0.66,0.77,0.91,0.97,0.98,1.1,1.31,1.6],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[912.2,1071.02,1261.49,1341.94,1359.14,1521.45,1813.31,2221.06],[653.35,757.5,914.53,840.11,709.49,418.26,1268.53,944.59],[258.85,313.52,346.96,501.83,649.64,1103.19,544.78,1276.47],[0,0,0,0,0,0,0,0],[0.21,0.14,0.14,0.05,0.05,-0.3,0.14,-0.12],[-0.5,-0.4,-0.4,-0.5,-0.5,-0.9,-0.4,-0.7],[1811.96,1811,2096,2439.85,3042,2738.15,3113.19,4292.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-425e1adc251f6bebaa0d" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-425e1adc251f6bebaa0d">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","RobertWalraven-ESG","USC-SIkJalpha","IEM_Health-CovidProject","epiforecasts-EpiNow2","ILM-EKF"],[0.62,0.65,0.82,1.11,1.15,1.26,1.36,1.38],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[10.68,11.15,14.21,19.26,19.86,21.79,23.59,23.91],[3.68,8.12,14.11,19.24,18.71,12.45,7.07,23.64],[7,0,0,0.03,0,9.34,0,0.26],[0,3.02,0.1,0,1.15,0,16.52,0],[-0.21,0.14,0.4,0.4,0.31,0.05,-0.3,0.4],[-0.8,0.4,0.1,-0.1,0.2,-0.5,0.9,-0.1],[19,17.97,2.3,0.63,12,41.76,42,6]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-522267d8b8ef09c52999" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-522267d8b8ef09c52999">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","epiforecasts-EpiNow2","ILM-EKF","EuroCOVIDhub-ensemble","USC-SIkJalpha","epiforecasts-EpiExpert","IEM_Health-CovidProject","LANL-GrowthRate"],[0.66,0.78,0.91,0.96,0.98,1.09,1.3,1.59],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[227.62,547.3,642.7,678.07,689.5,766.3,917.55,1115.87],[167.2,382.28,469.09,427.11,364.1,213.19,640.49,474.13],[60.42,156.76,173.61,250.92,324.82,551.6,277.06,641.74],[0,8.26,0,0.05,0.57,1.51,0,0],[0.35,-0.08,0.27,0.22,0.18,-0.08,0.09,-0.17],[-0.19,0.25,-0.25,-0.2,-0.15,-0.25,-0.45,-0.75],[423.27,926.5,1051,1221.08,1527,1378.06,1577.47,2155.75]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-8af1469f8bd1a24e4253" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-8af1469f8bd1a24e4253">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["RobertWalraven-ESG","RobertWalraven-ESG","epiforecasts-EpiNow2","epiforecasts-EpiNow2","ILM-EKF","ILM-EKF","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","USC-SIkJalpha","USC-SIkJalpha","epiforecasts-EpiExpert","epiforecasts-EpiExpert","IEM_Health-CovidProject","IEM_Health-CovidProject","LANL-GrowthRate","LANL-GrowthRate"],[0.66,0.66,0.78,0.78,0.91,0.91,0.96,0.96,0.98,0.98,1.09,1.09,1.3,1.3,1.59,1.59],["BE","BE","BE","BE","BE","BE","BE","BE","BE","BE","BE","BE","BE","BE","BE","BE"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Belgium","Belgium","Belgium","Belgium","Belgium","Belgium","Belgium","Belgium","Belgium","Belgium","Belgium","Belgium","Belgium","Belgium","Belgium","Belgium"],[11372068,11372068,11372068,11372068,11372068,11372068,11372068,11372068,11372068,11372068,11372068,11372068,11372068,11372068,11372068,11372068],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[912.2,19.26,1071.02,23.59,1261.49,23.91,1341.94,14.21,1359.14,19.86,1521.45,11.15,1813.31,21.79,2221.06,10.68],[653.35,19.24,757.5,7.07,914.53,23.64,840.11,14.11,709.49,18.71,418.26,8.12,1268.53,12.45,944.59,3.68],[258.85,0.03,313.52,0,346.96,0.26,501.83,0,649.64,0,1103.19,0,544.78,9.34,1276.47,7],[0,0,0,16.52,0,0,0,0.1,0,1.15,0,3.02,0,0,0,0],[0.21,0.4,0.14,-0.3,0.14,0.4,0.05,0.4,0.05,0.31,-0.3,0.14,0.14,0.05,-0.12,-0.21],[-0.5,-0.1,-0.4,0.9,-0.4,-0.1,-0.5,0.1,-0.5,0.2,-0.9,0.4,-0.4,-0.5,-0.7,-0.8],[1811.96,0.63,1811,42,2096,6,2439.85,2.3,3042,12,2738.15,17.97,3113.19,41.76,4292.5,19]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-07975557cb46ce3a8163" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-07975557cb46ce3a8163">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["ILM-EKF","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","LANL-GrowthRate","epiforecasts-EpiExpert","IEM_Health-CovidProject","RobertWalraven-ESG","USC-SIkJalpha"],[0.48,0.5,0.65,0.73,0.96,1.48,1.61,3.83],[513.86,543.86,699.75,788.39,1035.39,1597.86,913.95,4125.63],[441.29,513.02,439.76,724.53,180.86,632.46,78.97,388.57],[72.57,12.69,259.99,63.87,854.53,965.4,834.98,3737.07],[0,18.15,0,0,0,0,0,0],[0.22,0.09,-0.08,-0.04,-0.3,-0.25,-0.58,-0.56],[-0.3,-0.25,-0.65,-0.58,-0.88,-0.82,-1,-1],[653,391,1269.35,558.25,1670.81,3028.52,1272.46,4520.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-161df9f30ff6c563d4da" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-161df9f30ff6c563d4da">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["ILM-EKF","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","LANL-GrowthRate","epiforecasts-EpiExpert","IEM_Health-CovidProject","RobertWalraven-ESG","USC-SIkJalpha"],[0.48,0.5,0.65,0.73,0.96,1.48,1.61,3.83],[513.86,543.86,699.75,788.39,1035.39,1597.86,913.95,4125.63],[441.29,513.02,439.76,724.53,180.86,632.46,78.97,388.57],[72.57,12.69,259.99,63.87,854.53,965.4,834.98,3737.07],[0,18.15,0,0,0,0,0,0],[0.22,0.09,-0.08,-0.04,-0.3,-0.25,-0.58,-0.56],[-0.3,-0.25,-0.65,-0.58,-0.88,-0.82,-1,-1],[653,391,1269.35,558.25,1670.81,3028.52,1272.46,4520.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-a94e4bdc28dc6414ef1b" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-a94e4bdc28dc6414ef1b">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["ILM-EKF","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","LANL-GrowthRate","epiforecasts-EpiExpert","IEM_Health-CovidProject","RobertWalraven-ESG","USC-SIkJalpha"],[0.47,0.51,0.63,0.73,0.98,1.45,1.6,3.95],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[962.29,1040.3,1298.66,1495.46,1998.31,2969.55,3281.8,8088.52],[829.9,1004,850.04,1436.64,339.4,1225.71,301.96,760.29],[132.39,0,448.62,58.81,1658.91,1743.84,2979.84,7328.23],[0,36.3,0,0,0,0,0,0],[0.22,0.31,0.05,0.31,-0.39,-0.12,-0.64,-0.56],[-0.3,0.2,-0.5,-0.2,-0.95,-0.7,-1,-1],[1211,693,2353.3,990.5,3207.24,5680.96,4690.09,8808]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-32f47f8b0516718bd5c8" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-32f47f8b0516718bd5c8">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiNow2","ILM-EKF","epiforecasts-EpiExpert","LANL-GrowthRate","EuroCOVIDhub-ensemble","USC-SIkJalpha","RobertWalraven-ESG","IEM_Health-CovidProject"],[0.46,0.63,0.7,0.79,0.97,1.57,1.87,2.19],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[47.41,65.43,72.47,81.33,100.84,162.75,193.3,226.17],[22.03,52.69,22.32,12.41,29.48,16.84,11.1,39.21],[25.38,12.74,50.15,68.92,71.36,145.9,182.19,186.95],[0,0,0,0,0,0,0,0],[-0.12,0.22,-0.21,-0.39,-0.21,-0.56,-0.56,-0.39],[-0.7,-0.3,-0.8,-0.95,-0.8,-1,-1,-0.95],[89,95,134.38,126,185.4,233,232.31,376.09]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-b30c56313deb16034885" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b30c56313deb16034885">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["ILM-EKF","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","LANL-GrowthRate","epiforecasts-EpiExpert","IEM_Health-CovidProject","RobertWalraven-ESG","USC-SIkJalpha"],[0.48,0.5,0.65,0.73,0.96,1.48,1.61,3.83],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[513.86,543.86,699.75,788.39,1035.39,1597.86,913.95,4125.63],[441.29,513.02,439.76,724.53,180.86,632.46,78.97,388.57],[72.57,12.69,259.99,63.87,854.53,965.4,834.98,3737.07],[0,18.15,0,0,0,0,0,0],[0.22,0.09,-0.08,-0.04,-0.3,-0.25,-0.58,-0.56],[-0.3,-0.25,-0.65,-0.58,-0.88,-0.82,-1,-1],[653,391,1269.35,558.25,1670.81,3028.52,1272.46,4520.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-37f0d602919b0e7d10ca" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-37f0d602919b0e7d10ca">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["ILM-EKF","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","LANL-GrowthRate","LANL-GrowthRate","epiforecasts-EpiExpert","epiforecasts-EpiExpert","IEM_Health-CovidProject","IEM_Health-CovidProject","RobertWalraven-ESG","RobertWalraven-ESG","USC-SIkJalpha","USC-SIkJalpha"],[0.48,0.48,0.5,0.5,0.65,0.65,0.73,0.73,0.96,0.96,1.48,1.48,1.61,1.61,3.83,3.83],["BG","BG","BG","BG","BG","BG","BG","BG","BG","BG","BG","BG","BG","BG","BG","BG"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria","Bulgaria"],[7075991,7075991,7075991,7075991,7075991,7075991,7075991,7075991,7075991,7075991,7075991,7075991,7075991,7075991,7075991,7075991],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[962.29,65.43,1040.3,47.41,1298.66,100.84,1495.46,81.33,1998.31,72.47,2969.55,226.17,3281.8,193.3,8088.52,162.75],[829.9,52.69,1004,22.03,850.04,29.48,1436.64,12.41,339.4,22.32,1225.71,39.21,301.96,11.1,760.29,16.84],[132.39,12.74,0,25.38,448.62,71.36,58.81,68.92,1658.91,50.15,1743.84,186.95,2979.84,182.19,7328.23,145.9],[0,0,36.3,0,0,0,0,0,0,0,0,0,0,0,0,0],[0.22,0.22,0.31,-0.12,0.05,-0.21,0.31,-0.39,-0.39,-0.21,-0.12,-0.39,-0.64,-0.56,-0.56,-0.56],[-0.3,-0.3,0.2,-0.7,-0.5,-0.8,-0.2,-0.95,-0.95,-0.8,-0.7,-0.95,-1,-1,-1,-1],[1211,95,693,89,2353.3,185.4,990.5,126,3207.24,134.38,5680.96,376.09,4690.09,232.31,8808,233]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-fefd2841acae8c4af53e" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-fefd2841acae8c4af53e">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","LANL-GrowthRate","RobertWalraven-ESG","USC-SIkJalpha","ILM-EKF","IEM_Health-CovidProject"],[0.48,0.57,0.88,1.04,1.09,1.2,1.45,2.12],[124.14,146.32,226.88,269.55,142.57,309.01,376.11,548.51],[106.59,142.08,127.08,146.87,94.64,269.96,112.07,149.3],[17.55,0,99.8,122.68,47.93,39.06,264.04,399.21],[0,4.24,0,0,0,0,0,0],[0.05,0.27,0.05,-0.17,-0.38,0.27,0.01,-0.21],[-0.5,0.25,-0.5,-0.72,-0.88,-0.25,-0.55,-0.8],[154.92,83.5,439.39,507.25,259.22,270.5,688,989.63]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-74565bc6a72964bbbb7e" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-74565bc6a72964bbbb7e">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","LANL-GrowthRate","RobertWalraven-ESG","USC-SIkJalpha","ILM-EKF","IEM_Health-CovidProject"],[0.48,0.57,0.88,1.04,1.09,1.2,1.45,2.12],[124.14,146.32,226.88,269.55,142.57,309.01,376.11,548.51],[106.59,142.08,127.08,146.87,94.64,269.96,112.07,149.3],[17.55,0,99.8,122.68,47.93,39.06,264.04,399.21],[0,4.24,0,0,0,0,0,0],[0.05,0.27,0.05,-0.17,-0.38,0.27,0.01,-0.21],[-0.5,0.25,-0.5,-0.72,-0.88,-0.25,-0.55,-0.8],[154.92,83.5,439.39,507.25,259.22,270.5,688,989.63]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-b1e6b7f05f3e27232e78" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b1e6b7f05f3e27232e78">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","LANL-GrowthRate","RobertWalraven-ESG","USC-SIkJalpha","ILM-EKF","IEM_Health-CovidProject"],[0.48,0.57,0.88,1.02,1.08,1.21,1.46,2.14],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[242.54,285.37,445.26,516.64,543.9,610.98,738.42,1081.44],[210.7,278.59,248.5,291.66,398.4,533.59,212.07,292.62],[31.84,0,196.75,224.98,145.5,77.38,526.35,788.82],[0,6.78,0,0,0,0,0,0],[0.22,0.4,0.05,0.05,0.21,0.22,-0.21,-0.3],[-0.3,0.1,-0.5,-0.5,-0.5,-0.3,-0.8,-0.9],[298.84,156,862.62,981.5,1018.53,535,1354,1948.58]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-01a909e59ef9e3d384b1" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-01a909e59ef9e3d384b1">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","USC-SIkJalpha","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","ILM-EKF","IEM_Health-CovidProject","RobertWalraven-ESG","LANL-GrowthRate"],[0.51,0.63,0.65,0.76,1.23,1.39,1.83,2.01],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[5.74,7.05,7.26,8.51,13.81,15.58,20.43,22.46],[2.47,6.32,5.57,5.66,12.07,5.98,2.19,2.07],[3.27,0.73,0,2.85,1.74,9.6,18.24,20.39],[0,0,1.7,0,0,0,0,0],[-0.12,0.31,0.14,0.05,0.22,-0.12,-0.56,-0.39],[-0.7,-0.2,0.4,-0.5,-0.3,-0.7,-1,-0.95],[11,6,11,16.17,22,30.68,28.13,33]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-b2f6085100520b87cf5e" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b2f6085100520b87cf5e">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","LANL-GrowthRate","RobertWalraven-ESG","USC-SIkJalpha","ILM-EKF","IEM_Health-CovidProject"],[0.48,0.57,0.88,1.04,1.09,1.2,1.45,2.12],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[124.14,146.32,226.88,269.55,142.57,309.01,376.11,548.51],[106.59,142.08,127.08,146.87,94.64,269.96,112.07,149.3],[17.55,0,99.8,122.68,47.93,39.06,264.04,399.21],[0,4.24,0,0,0,0,0,0],[0.05,0.27,0.05,-0.17,-0.38,0.27,0.01,-0.21],[-0.5,0.25,-0.5,-0.72,-0.88,-0.25,-0.55,-0.8],[154.92,83.5,439.39,507.25,259.22,270.5,688,989.63]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-198d4fc3ebdfd1583b1c" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-198d4fc3ebdfd1583b1c">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","epiforecasts-EpiNow2","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","LANL-GrowthRate","LANL-GrowthRate","RobertWalraven-ESG","RobertWalraven-ESG","USC-SIkJalpha","USC-SIkJalpha","ILM-EKF","ILM-EKF","IEM_Health-CovidProject","IEM_Health-CovidProject"],[0.48,0.48,0.57,0.57,0.88,0.88,1.04,1.04,1.09,1.09,1.2,1.2,1.45,1.45,2.12,2.12],["HR","HR","HR","HR","HR","HR","HR","HR","HR","HR","HR","HR","HR","HR","HR","HR"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Croatia","Croatia","Croatia","Croatia","Croatia","Croatia","Croatia","Croatia","Croatia","Croatia","Croatia","Croatia","Croatia","Croatia","Croatia","Croatia"],[4125700,4125700,4125700,4125700,4125700,4125700,4125700,4125700,4125700,4125700,4125700,4125700,4125700,4125700,4125700,4125700],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[242.54,5.74,285.37,7.26,445.26,8.51,516.64,22.46,543.9,20.43,610.98,7.05,738.42,13.81,1081.44,15.58],[210.7,2.47,278.59,5.57,248.5,5.66,291.66,2.07,398.4,2.19,533.59,6.32,212.07,12.07,292.62,5.98],[31.84,3.27,0,0,196.75,2.85,224.98,20.39,145.5,18.24,77.38,0.73,526.35,1.74,788.82,9.6],[0,0,6.78,1.7,0,0,0,0,0,0,0,0,0,0,0,0],[0.22,-0.12,0.4,0.14,0.05,0.05,0.05,-0.39,0.21,-0.56,0.22,0.31,-0.21,0.22,-0.3,-0.12],[-0.3,-0.7,0.1,0.4,-0.5,-0.5,-0.5,-0.95,-0.5,-1,-0.3,-0.2,-0.8,-0.3,-0.9,-0.7],[298.84,11,156,11,862.62,16.17,981.5,33,1018.53,28.13,535,6,1354,22,1948.58,30.68]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-981bf23ff81f6b48cb1d" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-981bf23ff81f6b48cb1d">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","RobertWalraven-ESG","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","USC-SIkJalpha","IEM_Health-CovidProject","ILM-EKF"],[0.44,0.49,0.51,0.63,1.63,1.73,1.94,2.62],[73.14,38.54,84.89,105.36,270.73,287.1,322.92,434.65],[29.05,17.34,81.01,86.53,180.94,273.62,28.43,56.04],[44.09,21.21,2.15,18.83,0,13.48,294.48,378.61],[0,0,1.73,0,89.78,0,0,0],[-0.04,-0.05,-0.08,0.14,0.22,0.14,-0.3,-0.17],[-0.6,-0.65,-0.45,-0.4,0.3,-0.4,-0.8,-0.69],[136.5,88.55,42.3,150.12,457,106.5,424.77,668]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-aafe5e529c260ec40f84" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-aafe5e529c260ec40f84">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","RobertWalraven-ESG","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","USC-SIkJalpha","IEM_Health-CovidProject","ILM-EKF"],[0.44,0.49,0.51,0.63,1.63,1.73,1.94,2.62],[73.14,38.54,84.89,105.36,270.73,287.1,322.92,434.65],[29.05,17.34,81.01,86.53,180.94,273.62,28.43,56.04],[44.09,21.21,2.15,18.83,0,13.48,294.48,378.61],[0,0,1.73,0,89.78,0,0,0],[-0.04,-0.05,-0.08,0.14,0.22,0.14,-0.3,-0.17],[-0.6,-0.65,-0.45,-0.4,0.3,-0.4,-0.8,-0.69],[136.5,88.55,42.3,150.12,457,106.5,424.77,668]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-891dec4082e3add6c335" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-891dec4082e3add6c335">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","RobertWalraven-ESG","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","USC-SIkJalpha","IEM_Health-CovidProject","ILM-EKF"],[0.44,0.49,0.5,0.63,1.64,1.74,1.95,2.63],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[144.29,161.4,165.37,209.14,540.36,571.61,643.89,866.48],[57.46,72.14,161.91,172.35,360.83,546.6,56.13,111.09],[86.83,89.25,0,36.79,0,25.02,587.76,755.39],[0,0,3.46,0,179.52,0,0,0],[-0.12,-0.07,0.4,0.22,0.05,0.31,-0.56,-0.47],[-0.7,-0.8,0.1,-0.3,0.5,-0.2,-1,-0.98],[268,372.39,79.6,297,913,208,845.55,1330]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-c75efdd372c7e78058cd" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-c75efdd372c7e78058cd">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiNow2","RobertWalraven-ESG","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","LANL-GrowthRate","USC-SIkJalpha","ILM-EKF","epiforecasts-EpiExpert"],[0.55,0.58,0.79,0.98,1,1.3,1.42,2.21],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[1.1,1.15,1.58,1.94,1.98,2.59,2.82,4.4],[1.06,0.66,0.71,0.74,0.63,0.65,1,0.11],[0,0.5,0.87,1.2,1.35,1.94,1.83,4.29],[0.04,0,0,0,0,0,0,0],[0.4,-0.04,0.05,-0.04,0.05,-0.04,0.14,-0.56],[0.1,-0.6,-0.5,-0.6,-0.5,-0.6,-0.4,-1],[1,2.16,3.23,3.99,5,5,6,5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-f4761916d42f5717bb3a" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f4761916d42f5717bb3a">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","RobertWalraven-ESG","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","USC-SIkJalpha","IEM_Health-CovidProject","ILM-EKF"],[0.44,0.49,0.51,0.63,1.63,1.73,1.94,2.62],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[73.14,38.54,84.89,105.36,270.73,287.1,322.92,434.65],[29.05,17.34,81.01,86.53,180.94,273.62,28.43,56.04],[44.09,21.21,2.15,18.83,0,13.48,294.48,378.61],[0,0,1.73,0,89.78,0,0,0],[-0.04,-0.05,-0.08,0.14,0.22,0.14,-0.3,-0.17],[-0.6,-0.65,-0.45,-0.4,0.3,-0.4,-0.8,-0.69],[136.5,88.55,42.3,150.12,457,106.5,424.77,668]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-c9b239a39388725ed1b2" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-c9b239a39388725ed1b2">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["LANL-GrowthRate","LANL-GrowthRate","RobertWalraven-ESG","RobertWalraven-ESG","epiforecasts-EpiExpert","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiNow2","USC-SIkJalpha","USC-SIkJalpha","IEM_Health-CovidProject","IEM_Health-CovidProject","ILM-EKF","ILM-EKF"],[0.44,0.44,0.49,0.49,0.51,0.51,0.63,0.63,1.63,1.63,1.73,1.73,1.94,1.94,2.62,2.62],["CY","CY","CY","CY","CY","CY","CY","CY","CY","CY","CY","CY","CY","CY","CY","CY"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus","Cyprus"],[1179551,1179551,1179551,1179551,1179551,1179551,1179551,1179551,1179551,1179551,1179551,1179551,1179551,1179551,1179551,1179551],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[144.29,1.98,161.4,1.15,165.37,4.4,209.14,1.58,540.36,1.1,571.61,2.59,643.89,1.94,866.48,2.82],[57.46,0.63,72.14,0.66,161.91,0.11,172.35,0.71,360.83,1.06,546.6,0.65,56.13,0.74,111.09,1],[86.83,1.35,89.25,0.5,0,4.29,36.79,0.87,0,0,25.02,1.94,587.76,1.2,755.39,1.83],[0,0,0,0,3.46,0,0,0,179.52,0.04,0,0,0,0,0,0],[-0.12,0.05,-0.07,-0.04,0.4,-0.56,0.22,0.05,0.05,0.4,0.31,-0.04,-0.56,-0.04,-0.47,0.14],[-0.7,-0.5,-0.8,-0.6,0.1,-1,-0.3,-0.5,0.5,0.1,-0.2,-0.6,-1,-0.6,-0.98,-0.4],[268,5,372.39,2.16,79.6,5,297,3.23,913,1,208,5,845.55,3.99,1330,6]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-9a370fcd3bb68fef97df" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-9a370fcd3bb68fef97df">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["epiforecasts-EpiExpert","LANL-GrowthRate","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","USC-SIkJalpha","epiforecasts-EpiNow2","ILM-EKF","MUNI_DMS-SEIAR"],[0.53,0.87,0.94,0.94,1.01,1.13,1.13,1.36,1.4],[1934.75,3150.96,1613.74,3399.35,3683.68,4107.96,4121.35,4931.76,5083.06],[849.67,2542.76,724.6,3052.16,2246.56,3210.5,2455.5,2012.72,2877.74],[5.26,608.21,33.82,12.26,0.17,0.33,0,0.43,0],[1079.82,0,855.32,334.93,1436.95,897.13,1665.86,2918.61,2205.33],[0.01,0.05,-0.31,0.18,0.22,0.27,0.05,0.09,-0.12],[0.15,-0.5,-0.54,-0.05,0.2,0.15,0.5,0.35,0.7],[3588.31,4679.75,3692.93,3800.48,6627.37,5260,7559.75,8989,9422.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-26d422c0955dac0d0311" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-26d422c0955dac0d0311">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["epiforecasts-EpiExpert","LANL-GrowthRate","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","USC-SIkJalpha","epiforecasts-EpiNow2","ILM-EKF","MUNI_DMS-SEIAR"],[0.53,0.87,0.94,0.94,1.01,1.13,1.13,1.36,1.4],[1934.75,3150.96,1613.74,3399.35,3683.68,4107.96,4121.35,4931.76,5083.06],[849.67,2542.76,724.6,3052.16,2246.56,3210.5,2455.5,2012.72,2877.74],[5.26,608.21,33.82,12.26,0.17,0.33,0,0.43,0],[1079.82,0,855.32,334.93,1436.95,897.13,1665.86,2918.61,2205.33],[0.01,0.05,-0.31,0.18,0.22,0.27,0.05,0.09,-0.12],[0.15,-0.5,-0.54,-0.05,0.2,0.15,0.5,0.35,0.7],[3588.31,4679.75,3692.93,3800.48,6627.37,5260,7559.75,8989,9422.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-9d5d7b37ee73c867f8be" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-9d5d7b37ee73c867f8be">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","RobertWalraven-ESG","EuroCOVIDhub-ensemble","USC-SIkJalpha","epiforecasts-EpiNow2","ILM-EKF","MUNI_DMS-SEIAR"],[0.53,0.86,0.93,0.94,1.02,1.13,1.14,1.36,1.4],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[3831.24,6205.12,6714.19,6740.12,7324.55,8131.72,8211.5,9760.79,10049.58],[1671.59,5048.09,6044.34,3074.47,4450.65,6337.45,4890.76,3923.57,5719.98],[0,1157.03,0,0,0,0,0,0,0],[2159.65,0,669.85,3665.65,2873.9,1794.27,3320.74,5837.22,4329.61],[-0.12,0.22,0.22,-0.07,0.05,0.14,0.05,-0.21,-0.04],[0.7,-0.3,0.3,0.8,0.5,0.4,0.5,0.8,0.6],[7113.28,9170.5,7457.17,15547.78,13246.8,10505,15065,17958,18635]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-e970f8146a923bf15361" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e970f8146a923bf15361">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["epiforecasts-EpiNow2","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","RobertWalraven-ESG","USC-SIkJalpha","IEM_Health-CovidProject","LANL-GrowthRate","ILM-EKF","MUNI_DMS-SEIAR"],[0.48,0.58,0.65,0.82,1.28,1.29,1.48,1.57,1.78],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[31.2,38.27,42.81,53.54,84.2,84.52,96.8,102.73,116.54],[20.23,27.75,42.46,9.43,83.55,59.99,37.43,101.86,35.49],[0,10.52,0.34,44.12,0.65,24.52,59.38,0.87,0],[10.98,0,0,0,0,0,0,0,81.04],[0.05,0.14,0.4,-0.39,0.4,0.14,-0.12,0.4,-0.21],[0.5,-0.4,-0.1,-0.95,-0.1,-0.4,-0.7,-0.1,0.8],[54.5,63.34,7.93,84.93,15,143.78,189,20,210]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-f8fe71c6f50316f6a7f0" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f8fe71c6f50316f6a7f0">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["epiforecasts-EpiExpert","LANL-GrowthRate","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","USC-SIkJalpha","epiforecasts-EpiNow2","ILM-EKF","MUNI_DMS-SEIAR"],[0.53,0.87,0.94,0.94,1.01,1.13,1.13,1.36,1.4],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[1934.75,3150.96,1613.74,3399.35,3683.68,4107.96,4121.35,4931.76,5083.06],[849.67,2542.76,724.6,3052.16,2246.56,3210.5,2455.5,2012.72,2877.74],[5.26,608.21,33.82,12.26,0.17,0.33,0,0.43,0],[1079.82,0,855.32,334.93,1436.95,897.13,1665.86,2918.61,2205.33],[0.01,0.05,-0.31,0.18,0.22,0.27,0.05,0.09,-0.12],[0.15,-0.5,-0.54,-0.05,0.2,0.15,0.5,0.35,0.7],[3588.31,4679.75,3692.93,3800.48,6627.37,5260,7559.75,8989,9422.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-7b72c93b1ffe6f23e9d8" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-7b72c93b1ffe6f23e9d8">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","LANL-GrowthRate","LANL-GrowthRate","RobertWalraven-ESG","RobertWalraven-ESG","IEM_Health-CovidProject","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","USC-SIkJalpha","USC-SIkJalpha","epiforecasts-EpiNow2","epiforecasts-EpiNow2","ILM-EKF","ILM-EKF","MUNI_DMS-SEIAR","MUNI_DMS-SEIAR"],[0.53,0.53,0.87,0.87,0.94,0.94,0.94,0.94,1.01,1.01,1.13,1.13,1.13,1.13,1.36,1.36,1.4,1.4],["CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ","CZ"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia","Czechia"],[10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323,10591323],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[3831.24,38.27,6205.12,96.8,6740.12,53.54,6714.19,84.52,7324.55,42.81,8131.72,84.2,8211.5,31.2,9760.79,102.73,10049.58,116.54],[1671.59,27.75,5048.09,37.43,3074.47,9.43,6044.34,59.99,4450.65,42.46,6337.45,83.55,4890.76,20.23,3923.57,101.86,5719.98,35.49],[0,10.52,1157.03,59.38,0,44.12,0,24.52,0,0.34,0,0.65,0,0,0,0.87,0,0],[2159.65,0,0,0,3665.65,0,669.85,0,2873.9,0,1794.27,0,3320.74,10.98,5837.22,0,4329.61,81.04],[-0.12,0.14,0.22,-0.12,-0.07,-0.39,0.22,0.14,0.05,0.4,0.14,0.4,0.05,0.05,-0.21,0.4,-0.04,-0.21],[0.7,-0.4,-0.3,-0.7,0.8,-0.95,0.3,-0.4,0.5,-0.1,0.4,-0.1,0.5,0.5,0.8,-0.1,0.6,0.8],[7113.28,63.34,9170.5,189,15547.78,84.93,7457.17,143.78,13246.8,7.93,10505,15,15065,54.5,17958,20,18635,210]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-a654a5f204ecfa7b4572" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-a654a5f204ecfa7b4572">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["USC-SIkJalpha","ILM-EKF","RobertWalraven-ESG","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","epiforecasts-EpiNow2"],[0.71,0.87,0.97,1.05,1.06,1.09,1.13,1.22],[511.76,632.15,330.51,758.51,766.85,787.07,818.53,885.2],[225.92,117.19,39.68,72.49,42.78,44.39,66.5,63.55],[285.29,514.85,289.44,685.21,722.7,742.62,752.03,816.74],[0.55,0.11,1.4,0.81,1.38,0.07,0,4.91],[-0.17,-0.08,-0.18,-0.3,-0.52,-0.12,-0.08,-0.52],[-0.35,-0.32,0.23,-0.2,-0.01,-0.4,-0.55,-0.01],[846,1050,510.43,1030.54,932.74,952.5,1035.4,1104]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-3ffb4192daabbc9e72db" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-3ffb4192daabbc9e72db">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["USC-SIkJalpha","ILM-EKF","RobertWalraven-ESG","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","epiforecasts-EpiNow2"],[0.71,0.87,0.97,1.05,1.06,1.09,1.13,1.22],[511.76,632.15,330.51,758.51,766.85,787.07,818.53,885.2],[225.92,117.19,39.68,72.49,42.78,44.39,66.5,63.55],[285.29,514.85,289.44,685.21,722.7,742.62,752.03,816.74],[0.55,0.11,1.4,0.81,1.38,0.07,0,4.91],[-0.17,-0.08,-0.18,-0.3,-0.52,-0.12,-0.08,-0.52],[-0.35,-0.32,0.23,-0.2,-0.01,-0.4,-0.55,-0.01],[846,1050,510.43,1030.54,932.74,952.5,1035.4,1104]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-0d3c2271713a849462d5" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-0d3c2271713a849462d5">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["USC-SIkJalpha","ILM-EKF","RobertWalraven-ESG","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","epiforecasts-EpiNow2"],[0.71,0.87,0.97,1.05,1.06,1.09,1.13,1.22],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[1019.26,1259.2,1403.33,1512.88,1530.41,1573.18,1634.97,1757.6],[448.69,229.5,162.89,142.45,85.02,87.95,130.93,124.12],[570.57,1029.7,1240.44,1370.43,1445.4,1485.23,1504.04,1633.48],[0,0,0,0,0,0,0,0],[-0.56,-0.39,-0.64,-0.56,-0.56,-0.56,-0.56,-0.56],[-1,-0.95,-1,-1,-1,-1,-1,-1],[1683,2099,2163.04,2054.51,1860.57,1904,2070.29,2188]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-cd9c2256bade64a22756" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-cd9c2256bade64a22756">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","IEM_Health-CovidProject","epiforecasts-EpiExpert","RobertWalraven-ESG","EuroCOVIDhub-ensemble","USC-SIkJalpha","ILM-EKF","epiforecasts-EpiNow2"],[0.26,0.58,0.91,1.1,1.14,1.17,1.4,3.52],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[0.96,2.09,3.3,4,4.14,4.25,5.11,12.8],[0.83,2.07,0.54,2.18,2.53,3.14,4.89,2.97],[0,0.02,0,0,0,0,0,0],[0.13,0,2.76,1.82,1.61,1.1,0.22,9.83],[0.31,0.4,-0.47,-0.04,-0.04,0.22,0.22,-0.47],[0.2,-0.1,0.98,0.6,0.6,0.3,0.3,0.98],[1,0.51,4.93,7.46,6.57,9,1,20]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-2e9d02e9fcbb73d99c1c" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-2e9d02e9fcbb73d99c1c">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["USC-SIkJalpha","ILM-EKF","RobertWalraven-ESG","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","epiforecasts-EpiNow2"],[0.71,0.87,0.97,1.05,1.06,1.09,1.13,1.22],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[511.76,632.15,330.51,758.51,766.85,787.07,818.53,885.2],[225.92,117.19,39.68,72.49,42.78,44.39,66.5,63.55],[285.29,514.85,289.44,685.21,722.7,742.62,752.03,816.74],[0.55,0.11,1.4,0.81,1.38,0.07,0,4.91],[-0.17,-0.08,-0.18,-0.3,-0.52,-0.12,-0.08,-0.52],[-0.35,-0.32,0.23,-0.2,-0.01,-0.4,-0.55,-0.01],[846,1050,510.43,1030.54,932.74,952.5,1035.4,1104]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-5e8f91c24e7d2801edee" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-5e8f91c24e7d2801edee">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["USC-SIkJalpha","USC-SIkJalpha","ILM-EKF","ILM-EKF","RobertWalraven-ESG","RobertWalraven-ESG","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","epiforecasts-EpiExpert","LANL-GrowthRate","LANL-GrowthRate","IEM_Health-CovidProject","IEM_Health-CovidProject","epiforecasts-EpiNow2","epiforecasts-EpiNow2"],[0.71,0.71,0.87,0.87,0.97,0.97,1.05,1.05,1.06,1.06,1.09,1.09,1.13,1.13,1.22,1.22],["DK","DK","DK","DK","DK","DK","DK","DK","DK","DK","DK","DK","DK","DK","DK","DK"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Denmark","Denmark","Denmark","Denmark","Denmark","Denmark","Denmark","Denmark","Denmark","Denmark","Denmark","Denmark","Denmark","Denmark","Denmark","Denmark"],[5769603,5769603,5769603,5769603,5769603,5769603,5769603,5769603,5769603,5769603,5769603,5769603,5769603,5769603,5769603,5769603],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[1019.26,4.25,1259.2,5.11,1403.33,4,1512.88,4.14,1530.41,3.3,1573.18,0.96,1634.97,2.09,1757.6,12.8],[448.69,3.14,229.5,4.89,162.89,2.18,142.45,2.53,85.02,0.54,87.95,0.83,130.93,2.07,124.12,2.97],[570.57,0,1029.7,0,1240.44,0,1370.43,0,1445.4,0,1485.23,0,1504.04,0.02,1633.48,0],[0,1.1,0,0.22,0,1.82,0,1.61,0,2.76,0,0.13,0,0,0,9.83],[-0.56,0.22,-0.39,0.22,-0.64,-0.04,-0.56,-0.04,-0.56,-0.47,-0.56,0.31,-0.56,0.4,-0.56,-0.47],[-1,0.3,-0.95,0.3,-1,0.6,-1,0.6,-1,0.98,-1,0.2,-1,-0.1,-1,0.98],[1683,9,2099,1,2163.04,7.46,2054.51,6.57,1860.57,4.93,1904,1,2070.29,0.51,2188,20]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-bf9e187f95fcafeb7c5c" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-bf9e187f95fcafeb7c5c">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","RobertWalraven-ESG","LANL-GrowthRate","EuroCOVIDhub-ensemble","ILM-EKF","IEM_Health-CovidProject","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.37,0.55,0.68,0.95,0.95,1.24,2.29,2.81],[112.81,80.1,206.02,288.2,290.14,376.34,696.24,856.75],[94.36,38.22,163.48,175.51,257.38,148.96,203.16,284.65],[18.45,0,0,0,0.07,0.97,0,572.1],[0,41.88,42.54,112.69,32.7,226.41,493.08,0],[0.27,-0.11,-0.04,0.22,0.31,0.01,-0.25,-0.12],[-0.25,0.72,0.6,0.3,0.1,0.15,0.85,-0.7],[152.37,183.87,293.25,519.27,325.5,724.55,1191.75,1928.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-64f6c504cf80ce8dd819" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-64f6c504cf80ce8dd819">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","RobertWalraven-ESG","LANL-GrowthRate","EuroCOVIDhub-ensemble","ILM-EKF","IEM_Health-CovidProject","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.37,0.55,0.68,0.95,0.95,1.24,2.29,2.81],[112.81,80.1,206.02,288.2,290.14,376.34,696.24,856.75],[94.36,38.22,163.48,175.51,257.38,148.96,203.16,284.65],[18.45,0,0,0,0.07,0.97,0,572.1],[0,41.88,42.54,112.69,32.7,226.41,493.08,0],[0.27,-0.11,-0.04,0.22,0.31,0.01,-0.25,-0.12],[-0.25,0.72,0.6,0.3,0.1,0.15,0.85,-0.7],[152.37,183.87,293.25,519.27,325.5,724.55,1191.75,1928.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-fb6541e29d6733b361c7" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-fb6541e29d6733b361c7">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","RobertWalraven-ESG","LANL-GrowthRate","ILM-EKF","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.37,0.56,0.67,0.94,0.95,1.24,2.3,2.84],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[222.31,335.29,401.17,567.86,571.33,746.08,1381.78,1708.58],[185.59,160.5,324.31,502.47,346,293.25,402.35,566.2],[36.71,0,0,0,0,0,0,1142.38],[0,174.79,76.87,65.39,225.33,452.82,979.43,0],[0.22,-0.07,0.22,0.22,0.05,-0.12,-0.3,-0.21],[-0.3,0.8,0.3,0.3,0.5,0.7,0.9,-0.8],[302.01,772.98,569.5,648,1037.27,1438.07,2365,3850]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-f9f9129e991ed491461c" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f9f9129e991ed491461c">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","epiforecasts-EpiExpert","USC-SIkJalpha","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","epiforecasts-EpiNow2","LANL-GrowthRate","ILM-EKF"],[0.4,0.54,0.81,0.83,1.08,1.75,1.78,2.04],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[2.44,3.32,4.92,5.07,6.6,10.7,10.87,12.42],[1.01,3.13,3.1,5.02,4.66,3.98,2.65,12.29],[0,0.19,1.82,0,1.93,0,0,0.13],[1.43,0,0,0.05,0,6.72,8.22,0],[-0.12,0.31,-0.04,0.4,0.14,-0.21,-0.3,0.4],[0.7,-0.2,-0.6,0.1,-0.4,0.8,0.9,-0.1],[4.57,2.73,7,1.26,11.04,18.5,17,3]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-136853716e6fb7170497" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-136853716e6fb7170497">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","RobertWalraven-ESG","LANL-GrowthRate","EuroCOVIDhub-ensemble","ILM-EKF","IEM_Health-CovidProject","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.37,0.55,0.68,0.95,0.95,1.24,2.29,2.81],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[112.81,80.1,206.02,288.2,290.14,376.34,696.24,856.75],[94.36,38.22,163.48,175.51,257.38,148.96,203.16,284.65],[18.45,0,0,0,0.07,0.97,0,572.1],[0,41.88,42.54,112.69,32.7,226.41,493.08,0],[0.27,-0.11,-0.04,0.22,0.31,0.01,-0.25,-0.12],[-0.25,0.72,0.6,0.3,0.1,0.15,0.85,-0.7],[152.37,183.87,293.25,519.27,325.5,724.55,1191.75,1928.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-d3fb09d3b02c609caa01" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d3fb09d3b02c609caa01">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","RobertWalraven-ESG","RobertWalraven-ESG","LANL-GrowthRate","LANL-GrowthRate","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","ILM-EKF","ILM-EKF","IEM_Health-CovidProject","IEM_Health-CovidProject","epiforecasts-EpiNow2","epiforecasts-EpiNow2","USC-SIkJalpha","USC-SIkJalpha"],[0.37,0.37,0.55,0.55,0.68,0.68,0.95,0.95,0.95,0.95,1.24,1.24,2.29,2.29,2.81,2.81],["EE","EE","EE","EE","EE","EE","EE","EE","EE","EE","EE","EE","EE","EE","EE","EE"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Estonia","Estonia","Estonia","Estonia","Estonia","Estonia","Estonia","Estonia","Estonia","Estonia","Estonia","Estonia","Estonia","Estonia","Estonia","Estonia"],[1315480,1315480,1315480,1315480,1315480,1315480,1315480,1315480,1315480,1315480,1315480,1315480,1315480,1315480,1315480,1315480],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[222.31,3.32,335.29,2.44,401.17,10.87,571.33,5.07,567.86,12.42,746.08,6.6,1381.78,10.7,1708.58,4.92],[185.59,3.13,160.5,1.01,324.31,2.65,346,5.02,502.47,12.29,293.25,4.66,402.35,3.98,566.2,3.1],[36.71,0.19,0,0,0,0,0,0,0,0.13,0,1.93,0,0,1142.38,1.82],[0,0,174.79,1.43,76.87,8.22,225.33,0.05,65.39,0,452.82,0,979.43,6.72,0,0],[0.22,0.31,-0.07,-0.12,0.22,-0.3,0.05,0.4,0.22,0.4,-0.12,0.14,-0.3,-0.21,-0.21,-0.04],[-0.3,-0.2,0.8,0.7,0.3,0.9,0.5,0.1,0.3,-0.1,0.7,-0.4,0.9,0.8,-0.8,-0.6],[302.01,2.73,772.98,4.57,569.5,17,1037.27,1.26,648,3,1438.07,11.04,2365,18.5,3850,7]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-d016f45625377722e544" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d016f45625377722e544">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","USC-SIkJalpha","ILM-EKF","RobertWalraven-ESG","epiforecasts-EpiNow2"],[0.53,0.79,0.92,0.97,1.15,1.16,1.3,1.54],[87.3,128.79,149.56,158.64,187.74,188.68,100.38,250.83],[61.23,76.25,102.28,98.74,181.97,144.14,23.73,87.28],[0,0,0.9,0,0,0.11,0.03,0],[26.08,52.53,46.37,59.9,5.77,44.43,76.63,163.54],[-0.17,-0.04,0.05,0.22,0.38,0.27,0.22,-0.12],[0.69,0.6,0,0.3,0.1,0.15,0.14,0.7],[142.76,235.5,261.63,284.74,47,288.5,194.58,459.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-6eed19ee71f0176a8f00" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-6eed19ee71f0176a8f00">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","USC-SIkJalpha","ILM-EKF","RobertWalraven-ESG","epiforecasts-EpiNow2"],[0.53,0.79,0.92,0.97,1.15,1.16,1.3,1.54],[87.3,128.79,149.56,158.64,187.74,188.68,100.38,250.83],[61.23,76.25,102.28,98.74,181.97,144.14,23.73,87.28],[0,0,0.9,0,0,0.11,0.03,0],[26.08,52.53,46.37,59.9,5.77,44.43,76.63,163.54],[-0.17,-0.04,0.05,0.22,0.38,0.27,0.22,-0.12],[0.69,0.6,0,0.3,0.1,0.15,0.14,0.7],[142.76,235.5,261.63,284.74,47,288.5,194.58,459.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-18527d3277be08925ccf" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-18527d3277be08925ccf">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","USC-SIkJalpha","RobertWalraven-ESG","epiforecasts-EpiNow2"],[0.52,0.79,0.92,0.98,1.15,1.16,1.31,1.55],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[167.92,254.17,295.16,314.6,371.82,374.22,422.27,497.87],[121.2,151.1,202.41,194.84,282.95,362.68,93.86,172.47],[0,0,0,0,0,0,0,0],[46.72,103.07,92.75,119.77,88.87,11.54,328.41,325.39],[0.14,0.05,0.05,0.05,0.14,0.31,-0.36,-0.21],[0.4,0.5,0.5,0.5,0.4,0.2,0.95,0.8],[275.26,465,515.69,568.7,572,94,831.46,912]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-55f19671c7bbf2323ebe" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-55f19671c7bbf2323ebe">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["USC-SIkJalpha","RobertWalraven-ESG","EuroCOVIDhub-ensemble","LANL-GrowthRate","epiforecasts-EpiNow2","IEM_Health-CovidProject","ILM-EKF","epiforecasts-EpiExpert"],[0.38,0.72,0.8,1.02,1.13,1.18,1.66,2],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[1.27,2.42,2.68,3.41,3.79,3.95,5.54,6.69],[1.27,2.38,2.64,1.41,2.09,2.14,5.33,1.25],[0,0.03,0,0,0,1.81,0.22,0],[0,0,0.03,2,1.7,0,0,5.43],[0.44,0.4,0.4,-0.12,-0.04,0.05,0.4,-0.47],[0,-0.1,0.1,0.7,0.6,-0.5,-0.1,0.98],[0,0.75,0.78,6,7,7.57,5,10.26]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-bb7c9076bed241c10af2" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-bb7c9076bed241c10af2">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","USC-SIkJalpha","ILM-EKF","RobertWalraven-ESG","epiforecasts-EpiNow2"],[0.53,0.79,0.92,0.97,1.15,1.16,1.3,1.54],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[87.3,128.79,149.56,158.64,187.74,188.68,100.38,250.83],[61.23,76.25,102.28,98.74,181.97,144.14,23.73,87.28],[0,0,0.9,0,0,0.11,0.03,0],[26.08,52.53,46.37,59.9,5.77,44.43,76.63,163.54],[-0.17,-0.04,0.05,0.22,0.38,0.27,0.22,-0.12],[0.69,0.6,0,0.3,0.1,0.15,0.14,0.7],[142.76,235.5,261.63,284.74,47,288.5,194.58,459.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-353a98877bbd22816723" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-353a98877bbd22816723">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","LANL-GrowthRate","LANL-GrowthRate","IEM_Health-CovidProject","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","USC-SIkJalpha","USC-SIkJalpha","ILM-EKF","ILM-EKF","RobertWalraven-ESG","RobertWalraven-ESG","epiforecasts-EpiNow2","epiforecasts-EpiNow2"],[0.53,0.53,0.79,0.79,0.92,0.92,0.97,0.97,1.15,1.15,1.16,1.16,1.3,1.3,1.54,1.54],["FI","FI","FI","FI","FI","FI","FI","FI","FI","FI","FI","FI","FI","FI","FI","FI"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Finland","Finland","Finland","Finland","Finland","Finland","Finland","Finland","Finland","Finland","Finland","Finland","Finland","Finland","Finland","Finland"],[5511303,5511303,5511303,5511303,5511303,5511303,5511303,5511303,5511303,5511303,5511303,5511303,5511303,5511303,5511303,5511303],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[167.92,6.69,254.17,3.41,295.16,3.95,314.6,2.68,374.22,1.27,371.82,5.54,422.27,2.42,497.87,3.79],[121.2,1.25,151.1,1.41,202.41,2.14,194.84,2.64,362.68,1.27,282.95,5.33,93.86,2.38,172.47,2.09],[0,0,0,0,0,1.81,0,0,0,0,0,0.22,0,0.03,0,0],[46.72,5.43,103.07,2,92.75,0,119.77,0.03,11.54,0,88.87,0,328.41,0,325.39,1.7],[0.14,-0.47,0.05,-0.12,0.05,0.05,0.05,0.4,0.31,0.44,0.14,0.4,-0.36,0.4,-0.21,-0.04],[0.4,0.98,0.5,0.7,0.5,-0.5,0.5,0.1,0.2,0,0.4,-0.1,0.95,-0.1,0.8,0.6],[275.26,10.26,465,6,515.69,7.57,568.7,0.78,94,0,572,5,831.46,0.75,912,7]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-ffe87125d216ea31d502" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-ffe87125d216ea31d502">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["RobertWalraven-ESG","USC-SIkJalpha","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","UNIPV-BayesINGARCHX","ILM-EKF","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject"],[0.54,0.58,0.85,0.87,1.01,1.03,1.1,1.9,1.98],[1201.98,2676.61,3879.08,4031.05,9034.76,4732.52,5064.99,8692.55,9094.17],[921,2484.54,3111.52,2402.05,1813.78,2721.13,1447.04,5647.47,8033.54],[280.98,43.48,742.65,1423.91,0,1977.37,3503.17,3017.34,1058.74],[0,148.59,24.92,205.09,7220.98,34.02,114.78,27.74,1.89],[0.29,-0.08,0.14,-0.25,-0.56,0.05,-0.39,-0.12,0.31],[-0.27,0.45,0.1,0.25,1,0,0.1,0.2,-0.1],[1996.35,1275.5,5767.88,7188.5,14031,8872,9102.5,16036.75,10738.1]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-c73c27925f17955089c5" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-c73c27925f17955089c5">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["RobertWalraven-ESG","USC-SIkJalpha","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","UNIPV-BayesINGARCHX","ILM-EKF","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject"],[0.54,0.58,0.85,0.87,1.01,1.03,1.1,1.9,1.98],[1201.98,2676.61,3879.08,4031.05,9034.76,4732.52,5064.99,8692.55,9094.17],[921,2484.54,3111.52,2402.05,1813.78,2721.13,1447.04,5647.47,8033.54],[280.98,43.48,742.65,1423.91,0,1977.37,3503.17,3017.34,1058.74],[0,148.59,24.92,205.09,7220.98,34.02,114.78,27.74,1.89],[0.29,-0.08,0.14,-0.25,-0.56,0.05,-0.39,-0.12,0.31],[-0.27,0.45,0.1,0.25,1,0,0.1,0.2,-0.1],[1996.35,1275.5,5767.88,7188.5,14031,8872,9102.5,16036.75,10738.1]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-162c6bf8bd1540a9f95a" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-162c6bf8bd1540a9f95a">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["RobertWalraven-ESG","USC-SIkJalpha","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","UNIPV-BayesINGARCHX","ILM-EKF","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject"],[0.54,0.56,0.85,0.85,1.01,1.04,1.11,1.94,2.01],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[4843.34,4982.43,7611.48,7614.16,9034.76,9273.53,9875.1,17306.02,17974.83],[3658.72,4895.47,6126.19,4766.33,1813.78,5318.79,2868.77,11271.34,15857.35],[1184.62,86.96,1485.29,2847.83,0,3954.74,7006.34,6034.69,2117.49],[0,0,0,0,7220.98,0,0,0,0],[0.21,0.4,0.22,0.05,-0.56,0.05,-0.21,0.05,0.22],[-0.5,-0.1,-0.3,-0.5,1,-0.5,-0.8,-0.5,-0.3],[8292.37,2000,11283.94,13794,14031,17413,17866,31935.5,21389.39]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-0952003d9049b18261ad" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-0952003d9049b18261ad">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","RobertWalraven-ESG","EuroCOVIDhub-ensemble","ILM-EKF","IEM_Health-CovidProject","epiforecasts-EpiExpert","USC-SIkJalpha","epiforecasts-EpiNow2"],[0.41,0.49,0.76,1,1.11,1.32,1.93,2.33],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[79.07,93.74,146.67,191.51,213.5,254.87,370.79,447.95],[23.59,87.78,96.84,123.47,209.73,25.31,73.61,37.77],[0,5.96,0,0,0,0,0,0],[55.48,0,49.83,68.04,3.77,229.57,297.17,410.18],[-0.3,0.31,0.05,0.05,0.4,-0.56,-0.56,-0.56],[0.9,-0.2,0.5,0.5,0.1,1,1,1],[138,80.17,251.82,331,86.8,339,551,583]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-64611890b9da08e91e70" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-64611890b9da08e91e70">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["RobertWalraven-ESG","USC-SIkJalpha","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","UNIPV-BayesINGARCHX","ILM-EKF","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject"],[0.54,0.58,0.85,0.87,1.01,1.03,1.1,1.9,1.98],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[1201.98,2676.61,3879.08,4031.05,9034.76,4732.52,5064.99,8692.55,9094.17],[921,2484.54,3111.52,2402.05,1813.78,2721.13,1447.04,5647.47,8033.54],[280.98,43.48,742.65,1423.91,0,1977.37,3503.17,3017.34,1058.74],[0,148.59,24.92,205.09,7220.98,34.02,114.78,27.74,1.89],[0.29,-0.08,0.14,-0.25,-0.56,0.05,-0.39,-0.12,0.31],[-0.27,0.45,0.1,0.25,1,0,0.1,0.2,-0.1],[1996.35,1275.5,5767.88,7188.5,14031,8872,9102.5,16036.75,10738.1]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-db0bdc6bea63565acbd7" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-db0bdc6bea63565acbd7">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"],["RobertWalraven-ESG","RobertWalraven-ESG","USC-SIkJalpha","USC-SIkJalpha","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiNow2","UNIPV-BayesINGARCHX","ILM-EKF","ILM-EKF","epiforecasts-EpiExpert","epiforecasts-EpiExpert","LANL-GrowthRate","LANL-GrowthRate","IEM_Health-CovidProject","IEM_Health-CovidProject"],[0.54,0.54,0.58,0.58,0.85,0.85,0.87,0.87,1.01,1.03,1.03,1.1,1.1,1.9,1.9,1.98,1.98],["FR","FR","FR","FR","FR","FR","FR","FR","FR","FR","FR","FR","FR","FR","FR","FR","FR"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["France","France","France","France","France","France","France","France","France","France","France","France","France","France","France","France","France"],[67118648,67118648,67118648,67118648,67118648,67118648,67118648,67118648,67118648,67118648,67118648,67118648,67118648,67118648,67118648,67118648,67118648],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[4843.34,93.74,4982.43,370.79,7611.48,146.67,7614.16,447.95,9034.76,9273.53,191.51,9875.1,254.87,17306.02,79.07,17974.83,213.5],[3658.72,87.78,4895.47,73.61,6126.19,96.84,4766.33,37.77,1813.78,5318.79,123.47,2868.77,25.31,11271.34,23.59,15857.35,209.73],[1184.62,5.96,86.96,0,1485.29,0,2847.83,0,0,3954.74,0,7006.34,0,6034.69,0,2117.49,0],[0,0,0,297.17,0,49.83,0,410.18,7220.98,0,68.04,0,229.57,0,55.48,0,3.77],[0.21,0.31,0.4,-0.56,0.22,0.05,0.05,-0.56,-0.56,0.05,0.05,-0.21,-0.56,0.05,-0.3,0.22,0.4],[-0.5,-0.2,-0.1,1,-0.3,0.5,-0.5,1,1,-0.5,0.5,-0.8,1,-0.5,0.9,-0.3,0.1],[8292.37,80.17,2000,551,11283.94,251.82,13794,583,14031,17413,331,17866,339,31935.5,138,21389.39,86.8]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-4369c07136b6397e8cea" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-4369c07136b6397e8cea">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"],["Priesemann-bayes","Karlen-pypm","itwm-dSEIR","ILM-EKF","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","FIAS_FZJ-Epi1Ger","UNIPV-BayesINGARCHX","LANL-GrowthRate","RobertWalraven-ESG","USC-SIkJalpha","UVA-Ensemble","epiforecasts-EpiNow2","IEM_Health-CovidProject","MIT_CovidAnalytics-DELPHI"],[0.59,0.62,0.67,0.76,0.8,0.86,0.91,1.01,1.07,1.08,1.32,1.32,1.38,1.53,1.99],[3356.83,1826.29,1976.4,2253.59,2344.28,2539.68,2716.99,5769.57,3128.71,1582.54,3886.52,7535.91,4070.95,4502.72,5850.83],[3251.71,1602.23,875.47,1544.05,1241.49,603.84,680.56,1017.49,1546.31,791.27,3114.66,1143.86,1682.36,1807.66,1763.57],[105.12,0,1086.6,666.22,1081.37,1876.11,1803.85,0,1564.37,791.27,727.11,6392.05,2227.57,2695.06,4062.9],[0,224.06,14.33,43.33,21.42,59.73,232.59,4752.08,18.02,0,44.75,0,161.02,0,24.35],[0.31,0.14,0.01,0.05,0.01,-0.34,-0.43,-0.56,-0.04,-0.11,0.09,-0.64,-0.21,0.14,-0.08],[-0.2,0.4,-0.15,0.1,-0.05,0.03,0.05,1,-0,-0.72,-0.05,-1,0.17,-0.4,-0.25],[2063.7,2156.75,3706.26,3929.5,4454.74,4389.36,4658.46,8468,6064.5,3585.77,4552.5,12869.29,7922.5,8493.55,10432.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-ef16795317803dde16c8" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-ef16795317803dde16c8">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"],["Priesemann-bayes","Karlen-pypm","itwm-dSEIR","ILM-EKF","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","FIAS_FZJ-Epi1Ger","UNIPV-BayesINGARCHX","LANL-GrowthRate","RobertWalraven-ESG","USC-SIkJalpha","UVA-Ensemble","epiforecasts-EpiNow2","IEM_Health-CovidProject","MIT_CovidAnalytics-DELPHI"],[0.59,0.62,0.67,0.76,0.8,0.86,0.91,1.01,1.07,1.08,1.32,1.32,1.38,1.53,1.99],[3356.83,1826.29,1976.4,2253.59,2344.28,2539.68,2716.99,5769.57,3128.71,1582.54,3886.52,7535.91,4070.95,4502.72,5850.83],[3251.71,1602.23,875.47,1544.05,1241.49,603.84,680.56,1017.49,1546.31,791.27,3114.66,1143.86,1682.36,1807.66,1763.57],[105.12,0,1086.6,666.22,1081.37,1876.11,1803.85,0,1564.37,791.27,727.11,6392.05,2227.57,2695.06,4062.9],[0,224.06,14.33,43.33,21.42,59.73,232.59,4752.08,18.02,0,44.75,0,161.02,0,24.35],[0.31,0.14,0.01,0.05,0.01,-0.34,-0.43,-0.56,-0.04,-0.11,0.09,-0.64,-0.21,0.14,-0.08],[-0.2,0.4,-0.15,0.1,-0.05,0.03,0.05,1,-0,-0.72,-0.05,-1,0.17,-0.4,-0.25],[2063.7,2156.75,3706.26,3929.5,4454.74,4389.36,4658.46,8468,6064.5,3585.77,4552.5,12869.29,7922.5,8493.55,10432.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-884da2682c9b441bf579" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-884da2682c9b441bf579">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"],["Priesemann-bayes","Karlen-pypm","itwm-dSEIR","ILM-EKF","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","FIAS_FZJ-Epi1Ger","UNIPV-BayesINGARCHX","LANL-GrowthRate","RobertWalraven-ESG","UVA-Ensemble","USC-SIkJalpha","epiforecasts-EpiNow2","IEM_Health-CovidProject","MIT_CovidAnalytics-DELPHI"],[0.59,0.62,0.68,0.76,0.8,0.87,0.87,1.01,1.09,1.09,1.32,1.33,1.35,1.55,2.02],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[3356.83,3505.88,3851.56,4304.18,4547.39,4922.32,4948.01,5769.57,6178.64,6181.83,7535.91,7580.57,7709.66,8793.94,11505.66],[3251.71,3104.55,1678.36,2971.75,2384.65,1170.09,1340.31,1017.49,3049.89,3140.91,1143.86,6126.34,3254.52,3408.94,3379.85],[105.12,0,2173.2,1332.43,2162.74,3752.23,3607.7,0,3128.75,3040.92,6392.05,1454.23,4455.13,5385,8125.81],[0,401.33,0,0,0,0,0,4752.08,0,0,0,0,0,0,0],[0.31,0.22,-0.12,0.14,-0.04,-0.3,-0.3,-0.56,-0.04,-0.07,-0.64,0.05,-0.04,-0.12,-0.3],[-0.2,0.3,-0.7,-0.4,-0.6,-0.9,-0.9,1,-0.6,-0.8,-1,-0.5,-0.6,-0.7,-0.9],[2063.7,4057,7243.97,7492,8669.65,8518.03,8754.92,8468,11990,14241.25,12869.29,8586,15134,16869.47,20554]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-c010f484a80521c8ccb5" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-c010f484a80521c8ccb5">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12"],["LANL-GrowthRate","itwm-dSEIR","EuroCOVIDhub-ensemble","Karlen-pypm","epiforecasts-EpiExpert","RobertWalraven-ESG","USC-SIkJalpha","MIT_CovidAnalytics-DELPHI","ILM-EKF","IEM_Health-CovidProject","epiforecasts-EpiNow2","FIAS_FZJ-Epi1Ger"],[0.43,0.55,0.76,0.79,0.85,0.99,1.04,1.06,1.1,1.14,2.34,2.63],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[78.78,101.24,141.18,146.7,157.05,182.75,192.48,195.99,203,211.49,432.24,485.98],[42.73,72.58,98.33,99.91,37.59,76.16,102.97,147.29,116.35,206.37,110.19,20.8],[0,0,0,0,0,106.59,0,0,0,5.11,0,0],[36.04,28.66,42.84,46.8,119.46,0,89.5,48.71,86.65,0,322.04,465.18],[-0.04,0.14,0.05,0.05,-0.39,-0.12,0.14,0.14,-0.04,0.4,-0.39,-0.56],[0.6,0.4,0.5,0.5,0.95,-0.7,0.4,0.4,0.6,-0.1,0.95,1],[139,168.55,239.83,256.5,260.7,342.8,519,311,367,117.62,711,562]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-d85c839223fc213f0f3b" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d85c839223fc213f0f3b">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"],["Priesemann-bayes","Karlen-pypm","itwm-dSEIR","ILM-EKF","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","FIAS_FZJ-Epi1Ger","UNIPV-BayesINGARCHX","LANL-GrowthRate","RobertWalraven-ESG","USC-SIkJalpha","UVA-Ensemble","epiforecasts-EpiNow2","IEM_Health-CovidProject","MIT_CovidAnalytics-DELPHI"],[0.59,0.62,0.67,0.76,0.8,0.86,0.91,1.01,1.07,1.08,1.32,1.32,1.38,1.53,1.99],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[3356.83,1826.29,1976.4,2253.59,2344.28,2539.68,2716.99,5769.57,3128.71,1582.54,3886.52,7535.91,4070.95,4502.72,5850.83],[3251.71,1602.23,875.47,1544.05,1241.49,603.84,680.56,1017.49,1546.31,791.27,3114.66,1143.86,1682.36,1807.66,1763.57],[105.12,0,1086.6,666.22,1081.37,1876.11,1803.85,0,1564.37,791.27,727.11,6392.05,2227.57,2695.06,4062.9],[0,224.06,14.33,43.33,21.42,59.73,232.59,4752.08,18.02,0,44.75,0,161.02,0,24.35],[0.31,0.14,0.01,0.05,0.01,-0.34,-0.43,-0.56,-0.04,-0.11,0.09,-0.64,-0.21,0.14,-0.08],[-0.2,0.4,-0.15,0.1,-0.05,0.03,0.05,1,-0,-0.72,-0.05,-1,0.17,-0.4,-0.25],[2063.7,2156.75,3706.26,3929.5,4454.74,4389.36,4658.46,8468,6064.5,3585.77,4552.5,12869.29,7922.5,8493.55,10432.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-b276899fcbfe9c8c3f9a" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b276899fcbfe9c8c3f9a">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27"],["Priesemann-bayes","Karlen-pypm","Karlen-pypm","itwm-dSEIR","itwm-dSEIR","ILM-EKF","ILM-EKF","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","epiforecasts-EpiExpert","FIAS_FZJ-Epi1Ger","FIAS_FZJ-Epi1Ger","UNIPV-BayesINGARCHX","LANL-GrowthRate","LANL-GrowthRate","RobertWalraven-ESG","RobertWalraven-ESG","USC-SIkJalpha","USC-SIkJalpha","UVA-Ensemble","epiforecasts-EpiNow2","epiforecasts-EpiNow2","IEM_Health-CovidProject","IEM_Health-CovidProject","MIT_CovidAnalytics-DELPHI","MIT_CovidAnalytics-DELPHI"],[0.59,0.62,0.62,0.67,0.67,0.76,0.76,0.8,0.8,0.86,0.86,0.91,0.91,1.01,1.07,1.07,1.08,1.08,1.32,1.32,1.32,1.38,1.38,1.53,1.53,1.99,1.99],["DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE","DE"],["inc case","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany","Germany"],[82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000,82695000],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[3356.83,3505.88,146.7,3851.56,101.24,4304.18,203,4547.39,141.18,4922.32,157.05,4948.01,485.98,5769.57,6178.64,78.78,6181.83,182.75,7580.57,192.48,7535.91,7709.66,432.24,8793.94,211.49,11505.66,195.99],[3251.71,3104.55,99.91,1678.36,72.58,2971.75,116.35,2384.65,98.33,1170.09,37.59,1340.31,20.8,1017.49,3049.89,42.73,3140.91,76.16,6126.34,102.97,1143.86,3254.52,110.19,3408.94,206.37,3379.85,147.29],[105.12,0,0,2173.2,0,1332.43,0,2162.74,0,3752.23,0,3607.7,0,0,3128.75,0,3040.92,106.59,1454.23,0,6392.05,4455.13,0,5385,5.11,8125.81,0],[0,401.33,46.8,0,28.66,0,86.65,0,42.84,0,119.46,0,465.18,4752.08,0,36.04,0,0,0,89.5,0,0,322.04,0,0,0,48.71],[0.31,0.22,0.05,-0.12,0.14,0.14,-0.04,-0.04,0.05,-0.3,-0.39,-0.3,-0.56,-0.56,-0.04,-0.04,-0.07,-0.12,0.05,0.14,-0.64,-0.04,-0.39,-0.12,0.4,-0.3,0.14],[-0.2,0.3,0.5,-0.7,0.4,-0.4,0.6,-0.6,0.5,-0.9,0.95,-0.9,1,1,-0.6,0.6,-0.8,-0.7,-0.5,0.4,-1,-0.6,0.95,-0.7,-0.1,-0.9,0.4],[2063.7,4057,256.5,7243.97,168.55,7492,367,8669.65,239.83,8518.03,260.7,8754.92,562,8468,11990,139,14241.25,342.8,8586,519,12869.29,15134,711,16869.47,117.62,20554,311]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-499f573aa476de9d8677" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-499f573aa476de9d8677">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","RobertWalraven-ESG","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.51,0.61,0.81,0.82,0.85,0.93,1.6,3.79],[275.78,183.63,437.48,441.66,457.41,503.05,859.98,2043.55],[227.44,57.75,385.34,427.86,373.85,400.79,443.82,950.12],[18.21,125.87,2.78,13.81,8.17,4.72,3.68,1093.43],[30.12,0,49.36,0,75.39,97.54,412.48,0],[-0.08,-0.45,0.05,0.14,0.05,0.14,-0.04,0.01],[-0.32,-0.95,-0.2,-0.4,-0.2,0,-0,-0.55],[329.51,376.31,509.5,175.84,624.62,739,1551,4171]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-506e6d44a7e7f20b0475" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-506e6d44a7e7f20b0475">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","RobertWalraven-ESG","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.51,0.61,0.81,0.82,0.85,0.93,1.6,3.79],[275.78,183.63,437.48,441.66,457.41,503.05,859.98,2043.55],[227.44,57.75,385.34,427.86,373.85,400.79,443.82,950.12],[18.21,125.87,2.78,13.81,8.17,4.72,3.68,1093.43],[30.12,0,49.36,0,75.39,97.54,412.48,0],[-0.08,-0.45,0.05,0.14,0.05,0.14,-0.04,0.01],[-0.32,-0.95,-0.2,-0.4,-0.2,0,-0,-0.55],[329.51,376.31,509.5,175.84,624.62,739,1551,4171]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-cc9b18ccb6576abee0eb" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-cc9b18ccb6576abee0eb">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","RobertWalraven-ESG","IEM_Health-CovidProject","LANL-GrowthRate","EuroCOVIDhub-ensemble","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.49,0.58,0.83,0.84,0.85,0.93,1.64,3.9],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[508.35,602.27,856.34,865.98,885.82,964.18,1704.2,4046.31],[448.1,237.1,843.29,767.27,735.05,769.09,879.24,1875.32],[0,365.17,13.05,0,0,0,0,2170.99],[60.25,0,0,98.71,150.78,195.09,824.96,0],[0.22,-0.07,0.4,0.22,0.22,0.14,-0.04,-0.04],[0.3,-0.8,-0.1,0.3,0.3,0.4,0.6,-0.6],[590.8,1391.48,300.08,1003,1192.41,1411,3072,8255]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-b94d81b592176feddd47" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b94d81b592176feddd47">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiNow2","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","USC-SIkJalpha","ILM-EKF","epiforecasts-EpiExpert","RobertWalraven-ESG"],[0.31,0.55,0.94,1.01,1.42,1.46,1.51,1.96],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[8.98,15.76,26.99,29,40.78,41.92,43.21,56.21],[3.41,8.4,12.42,12.66,24.92,32.49,6.79,3.17],[5.57,7.36,14.56,16.34,15.86,9.43,36.42,53.04],[0,0,0,0,0,0,0,0],[-0.12,-0.04,-0.12,-0.12,0.05,0.14,-0.39,-0.56],[-0.7,-0.6,-0.7,-0.7,-0.5,-0.4,-0.95,-1],[16,30,51.59,56.84,87,67,68.22,67.35]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-1e25737685a16e4ee54d" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1e25737685a16e4ee54d">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","RobertWalraven-ESG","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.51,0.61,0.81,0.82,0.85,0.93,1.6,3.79],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[275.78,183.63,437.48,441.66,457.41,503.05,859.98,2043.55],[227.44,57.75,385.34,427.86,373.85,400.79,443.82,950.12],[18.21,125.87,2.78,13.81,8.17,4.72,3.68,1093.43],[30.12,0,49.36,0,75.39,97.54,412.48,0],[-0.08,-0.45,0.05,0.14,0.05,0.14,-0.04,0.01],[-0.32,-0.95,-0.2,-0.4,-0.2,0,-0,-0.55],[329.51,376.31,509.5,175.84,624.62,739,1551,4171]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-0efa6647c045683df131" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-0efa6647c045683df131">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","RobertWalraven-ESG","RobertWalraven-ESG","LANL-GrowthRate","LANL-GrowthRate","IEM_Health-CovidProject","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","ILM-EKF","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiNow2","USC-SIkJalpha","USC-SIkJalpha"],[0.51,0.51,0.61,0.61,0.81,0.81,0.82,0.82,0.85,0.85,0.93,0.93,1.6,1.6,3.79,3.79],["GR","GR","GR","GR","GR","GR","GR","GR","GR","GR","GR","GR","GR","GR","GR","GR"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Greece","Greece","Greece","Greece","Greece","Greece","Greece","Greece","Greece","Greece","Greece","Greece","Greece","Greece","Greece","Greece"],[10760421,10760421,10760421,10760421,10760421,10760421,10760421,10760421,10760421,10760421,10760421,10760421,10760421,10760421,10760421,10760421],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[508.35,43.21,602.27,56.21,865.98,8.98,856.34,26.99,885.82,29,964.18,41.92,1704.2,15.76,4046.31,40.78],[448.1,6.79,237.1,3.17,767.27,3.41,843.29,12.42,735.05,12.66,769.09,32.49,879.24,8.4,1875.32,24.92],[0,36.42,365.17,53.04,0,5.57,13.05,14.56,0,16.34,0,9.43,0,7.36,2170.99,15.86],[60.25,0,0,0,98.71,0,0,0,150.78,0,195.09,0,824.96,0,0,0],[0.22,-0.39,-0.07,-0.56,0.22,-0.12,0.4,-0.12,0.22,-0.12,0.14,0.14,-0.04,-0.04,-0.04,0.05],[0.3,-0.95,-0.8,-1,0.3,-0.7,-0.1,-0.7,0.3,-0.7,0.4,-0.4,0.6,-0.6,-0.6,-0.5],[590.8,68.22,1391.48,67.35,1003,16,300.08,51.59,1192.41,56.84,1411,67,3072,30,8255,87]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-29ee618d096485b2ab92" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-29ee618d096485b2ab92">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","LANL-GrowthRate","RobertWalraven-ESG","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.53,0.62,0.71,0.79,0.87,1.22,1.38,3.71],[708.18,820.6,489.28,1051.72,1151.83,1613.25,1832.96,4926.18],[682.6,816.81,128.22,1037.85,665.63,1107.3,1713.16,2380.85],[25.58,0.78,361.06,0,486.2,0,0,2544.33],[0,3.01,0,13.87,0,505.96,119.8,1],[0.22,0.35,-0.51,0.35,0.01,0.05,-0.04,0.05],[-0.3,-0.05,-0.99,0.15,-0.55,0.5,0.54,-0.3],[392.79,82.25,987.2,302.58,2158.52,2742,1093,10898.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-f1d234ac0a0203f1c564" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f1d234ac0a0203f1c564">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","LANL-GrowthRate","RobertWalraven-ESG","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.53,0.62,0.71,0.79,0.87,1.22,1.38,3.71],[708.18,820.6,489.28,1051.72,1151.83,1613.25,1832.96,4926.18],[682.6,816.81,128.22,1037.85,665.63,1107.3,1713.16,2380.85],[25.58,0.78,361.06,0,486.2,0,0,2544.33],[0,3.01,0,13.87,0,505.96,119.8,1],[0.22,0.35,-0.51,0.35,0.01,0.05,-0.04,0.05],[-0.3,-0.05,-0.99,0.15,-0.55,0.5,0.54,-0.3],[392.79,82.25,987.2,302.58,2158.52,2742,1093,10898.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-0452cb83ac92705e9afd" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-0452cb83ac92705e9afd">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","LANL-GrowthRate","RobertWalraven-ESG","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.53,0.63,0.69,0.8,0.88,1.2,1.35,3.8],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[1351.67,1614.54,1772.93,2062.06,2268.28,3091.77,3480.75,9774.78],[1322.47,1608.52,530.78,2037.45,1312.87,2118.86,3397.62,4686.13],[29.19,0,1242.16,0,955.41,0,0,5088.65],[0,6.02,0,24.62,0,972.91,83.13,0],[0.4,0.4,-0.36,0.4,0.05,0.05,0.4,-0.21],[-0.1,0.1,-0.95,0.1,-0.5,0.5,0.1,-0.8],[671.45,138.5,3840.99,566.15,4250.06,5263,1912,21766]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-b43f663a6314cb42462e" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b43f663a6314cb42462e">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","USC-SIkJalpha","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2"],[0.39,0.52,0.6,0.95,1.13,1.44,1.97,2.71],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[26.66,35.38,41.38,64.69,77.57,98.61,134.74,185.16],[25.1,18.4,38.26,42.72,75.57,5.71,95.74,28.69],[1.57,16.99,0,21.97,0,92.9,0,0],[0,0,3.13,0,2,0,39,156.47],[0.31,-0.04,0.31,0.05,0.31,-0.56,0.05,-0.47],[-0.2,-0.6,0.2,-0.5,0.2,-1,0.5,0.98],[26,66.98,39.01,114.13,31,118.66,221,274]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-87a0b8ca36ea2c129d2e" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-87a0b8ca36ea2c129d2e">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","LANL-GrowthRate","RobertWalraven-ESG","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.53,0.62,0.71,0.79,0.87,1.22,1.38,3.71],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[708.18,820.6,489.28,1051.72,1151.83,1613.25,1832.96,4926.18],[682.6,816.81,128.22,1037.85,665.63,1107.3,1713.16,2380.85],[25.58,0.78,361.06,0,486.2,0,0,2544.33],[0,3.01,0,13.87,0,505.96,119.8,1],[0.22,0.35,-0.51,0.35,0.01,0.05,-0.04,0.05],[-0.3,-0.05,-0.99,0.15,-0.55,0.5,0.54,-0.3],[392.79,82.25,987.2,302.58,2158.52,2742,1093,10898.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-daa292cefcf31ab9150b" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-daa292cefcf31ab9150b">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["IEM_Health-CovidProject","IEM_Health-CovidProject","LANL-GrowthRate","LANL-GrowthRate","RobertWalraven-ESG","RobertWalraven-ESG","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","epiforecasts-EpiExpert","ILM-EKF","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiNow2","USC-SIkJalpha","USC-SIkJalpha"],[0.53,0.53,0.62,0.62,0.71,0.71,0.79,0.79,0.87,0.87,1.22,1.22,1.38,1.38,3.71,3.71],["HU","HU","HU","HU","HU","HU","HU","HU","HU","HU","HU","HU","HU","HU","HU","HU"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Hungary","Hungary","Hungary","Hungary","Hungary","Hungary","Hungary","Hungary","Hungary","Hungary","Hungary","Hungary","Hungary","Hungary","Hungary","Hungary"],[9781127,9781127,9781127,9781127,9781127,9781127,9781127,9781127,9781127,9781127,9781127,9781127,9781127,9781127,9781127,9781127],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[1351.67,64.69,1614.54,26.66,1772.93,98.61,2062.06,41.38,2268.28,35.38,3091.77,134.74,3480.75,185.16,9774.78,77.57],[1322.47,42.72,1608.52,25.1,530.78,5.71,2037.45,38.26,1312.87,18.4,2118.86,95.74,3397.62,28.69,4686.13,75.57],[29.19,21.97,0,1.57,1242.16,92.9,0,0,955.41,16.99,0,0,0,0,5088.65,0],[0,0,6.02,0,0,0,24.62,3.13,0,0,972.91,39,83.13,156.47,0,2],[0.4,0.05,0.4,0.31,-0.36,-0.56,0.4,0.31,0.05,-0.04,0.05,0.05,0.4,-0.47,-0.21,0.31],[-0.1,-0.5,0.1,-0.2,-0.95,-1,0.1,0.2,-0.5,-0.6,0.5,0.5,0.1,0.98,-0.8,0.2],[671.45,114.13,138.5,26,3840.99,118.66,566.15,39.01,4250.06,66.98,5263,221,1912,274,21766,31]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-229edeeb8152951cd715" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-229edeeb8152951cd715">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiExpert","USC-SIkJalpha","EuroCOVIDhub-ensemble","RobertWalraven-ESG","epiforecasts-EpiNow2","ILM-EKF","IEM_Health-CovidProject"],[0.46,0.48,0.96,1.09,1.14,1.42,1.43,1.89],[0.96,1,2.03,2.3,1.21,2.98,3.01,3.97],[0.63,0.92,0.26,0.67,1.08,0.37,0.81,0.55],[0.33,0.09,1.77,1.61,0,2.61,2.2,3.31],[0,0,0,0.02,0.13,0,0,0.11],[0.29,0.38,-0.06,-0.34,0.35,0.03,0.2,-0.47],[-0.2,-0.1,-0.5,0.15,0.19,-0.48,-0.3,0.03],[1.5,1,3,4.6,0.93,5,6.5,5.95]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-bc08ff1bb800222f57a5" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-bc08ff1bb800222f57a5">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiExpert","USC-SIkJalpha","EuroCOVIDhub-ensemble","RobertWalraven-ESG","epiforecasts-EpiNow2","ILM-EKF","IEM_Health-CovidProject"],[0.46,0.48,0.96,1.09,1.14,1.42,1.43,1.89],[0.96,1,2.03,2.3,1.21,2.98,3.01,3.97],[0.63,0.92,0.26,0.67,1.08,0.37,0.81,0.55],[0.33,0.09,1.77,1.61,0,2.61,2.2,3.31],[0,0,0,0.02,0.13,0,0,0.11],[0.29,0.38,-0.06,-0.34,0.35,0.03,0.2,-0.47],[-0.2,-0.1,-0.5,0.15,0.19,-0.48,-0.3,0.03],[1.5,1,3,4.6,0.93,5,6.5,5.95]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-5e532de109f06f6c25a0" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-5e532de109f06f6c25a0">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiExpert","USC-SIkJalpha","EuroCOVIDhub-ensemble","RobertWalraven-ESG","epiforecasts-EpiNow2","ILM-EKF","IEM_Health-CovidProject"],[0.46,0.49,0.99,1.08,1.13,1.45,1.46,1.76],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[1.89,2.01,4.05,4.43,4.63,5.94,6.02,7.23],[1.24,1.84,0.52,1.2,4.08,0.73,1.63,0.61],[0.65,0.17,3.53,3.23,0,5.22,4.39,6.62],[0,0,0,0,0.55,0,0,0],[0.14,0.31,-0.56,-0.12,0.21,-0.39,-0.04,-0.39],[-0.4,-0.2,-1,-0.7,0.5,-0.95,-0.6,-0.95],[3,2,6,9.05,3.85,10,13,11.18]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-987516836dc764314b96" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-987516836dc764314b96">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["ILM-EKF","USC-SIkJalpha","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","LANL-GrowthRate","RobertWalraven-ESG","epiforecasts-EpiNow2"],[0,0,0,null,null,null,null,null],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[0,0,0,0.18,0.72,0.03,0.17,0.02],[0,0,0,0.14,0.5,0.03,0.17,0.02],[0,0,0,0,0,0,0,0],[0,0,0,0.04,0.22,0,0,0],[0.44,0.44,0.44,-0.56,-0.56,0.44,0.4,0.44],[0,0,0,1,1,0,0.1,0],[0,0,0,0.15,0.73,0,0.04,0]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-e7bde2b3cf200f338ed2" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e7bde2b3cf200f338ed2">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiExpert","USC-SIkJalpha","EuroCOVIDhub-ensemble","RobertWalraven-ESG","epiforecasts-EpiNow2","ILM-EKF","IEM_Health-CovidProject"],[0.46,0.48,0.96,1.09,1.14,1.42,1.43,1.89],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[0.96,1,2.03,2.3,1.21,2.98,3.01,3.97],[0.63,0.92,0.26,0.67,1.08,0.37,0.81,0.55],[0.33,0.09,1.77,1.61,0,2.61,2.2,3.31],[0,0,0,0.02,0.13,0,0,0.11],[0.29,0.38,-0.06,-0.34,0.35,0.03,0.2,-0.47],[-0.2,-0.1,-0.5,0.15,0.19,-0.48,-0.3,0.03],[1.5,1,3,4.6,0.93,5,6.5,5.95]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-ec24ac553f034cd928ce" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-ec24ac553f034cd928ce">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["LANL-GrowthRate","LANL-GrowthRate","epiforecasts-EpiExpert","epiforecasts-EpiExpert","USC-SIkJalpha","USC-SIkJalpha","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","RobertWalraven-ESG","RobertWalraven-ESG","epiforecasts-EpiNow2","epiforecasts-EpiNow2","ILM-EKF","ILM-EKF","IEM_Health-CovidProject","IEM_Health-CovidProject"],[0.46,0.46,0.48,0.48,0.96,0.96,1.09,1.09,1.14,1.14,1.42,1.42,1.43,1.43,1.89,1.89],["IS","IS","IS","IS","IS","IS","IS","IS","IS","IS","IS","IS","IS","IS","IS","IS"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Iceland","Iceland","Iceland","Iceland","Iceland","Iceland","Iceland","Iceland","Iceland","Iceland","Iceland","Iceland","Iceland","Iceland","Iceland","Iceland"],[341284,341284,341284,341284,341284,341284,341284,341284,341284,341284,341284,341284,341284,341284,341284,341284],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[1.89,0.03,2.01,0,4.05,0,4.43,0.18,4.63,0.17,5.94,0.02,6.02,0,7.23,0.72],[1.24,0.03,1.84,0,0.52,0,1.2,0.14,4.08,0.17,0.73,0.02,1.63,0,0.61,0.5],[0.65,0,0.17,0,3.53,0,3.23,0,0,0,5.22,0,4.39,0,6.62,0],[0,0,0,0,0,0,0,0.04,0.55,0,0,0,0,0,0,0.22],[0.14,0.44,0.31,0.44,-0.56,0.44,-0.12,-0.56,0.21,0.4,-0.39,0.44,-0.04,0.44,-0.39,-0.56],[-0.4,0,-0.2,0,-1,0,-0.7,1,0.5,0.1,-0.95,0,-0.6,0,-0.95,1],[3,0,2,0,6,0,9.05,0.15,3.85,0.04,10,0,13,0,11.18,0.73]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-d9a0b974a4d0a8f02b0e" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d9a0b974a4d0a8f02b0e">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","USC-SIkJalpha","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","epiforecasts-EpiNow2","RobertWalraven-ESG"],[0.46,0.56,0.87,0.95,1,1.23,1.83,2.1],[64.11,77.59,120.74,132.79,138.56,171.69,254.39,142.21],[53.14,76.3,67.27,120.76,108.57,143.61,118.56,131.75],[9.62,1.29,53.48,12.03,29.99,28.09,135.65,10.46],[1.36,0,0,0,0,0,0.17,0],[-0.08,0.35,-0.12,0.31,0.18,0.18,0.14,0.09],[-0.39,-0.15,-0.7,-0.2,-0.35,-0.35,-0.2,-0.5],[47.43,24.5,228,133.87,214.33,235,507,67.14]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-2ad4501b76592bf4fd19" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-2ad4501b76592bf4fd19">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","USC-SIkJalpha","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","epiforecasts-EpiNow2","RobertWalraven-ESG"],[0.46,0.56,0.87,0.95,1,1.23,1.83,2.1],[64.11,77.59,120.74,132.79,138.56,171.69,254.39,142.21],[53.14,76.3,67.27,120.76,108.57,143.61,118.56,131.75],[9.62,1.29,53.48,12.03,29.99,28.09,135.65,10.46],[1.36,0,0,0,0,0,0.17,0],[-0.08,0.35,-0.12,0.31,0.18,0.18,0.14,0.09],[-0.39,-0.15,-0.7,-0.2,-0.35,-0.35,-0.2,-0.5],[47.43,24.5,228,133.87,214.33,235,507,67.14]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-b968d5882b305da2ebf2" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b968d5882b305da2ebf2">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","USC-SIkJalpha","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","epiforecasts-EpiNow2","RobertWalraven-ESG"],[0.41,0.57,0.88,0.93,1.01,1.24,1.91,2.2],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[106.04,148.48,230.2,244.37,264.82,325.36,500.05,574.97],[103.32,146.65,130.41,220.49,206.64,273.75,228.74,542.66],[0,1.83,99.78,23.88,58.18,51.61,271.3,32.32],[2.72,0,0,0,0,0,0,0],[0.31,0.4,-0.04,0.22,0.14,0.22,-0.04,0.21],[0.2,-0.1,-0.6,-0.3,-0.4,-0.3,-0.6,-0.5],[61,42,437,263.63,412.31,439,1008,226.22]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-49b84a1f3740bfc58773" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-49b84a1f3740bfc58773">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["USC-SIkJalpha","epiforecasts-EpiNow2","RobertWalraven-ESG","LANL-GrowthRate","EuroCOVIDhub-ensemble","ILM-EKF","IEM_Health-CovidProject","epiforecasts-EpiExpert"],[0.52,0.68,0.82,0.88,0.96,1.41,1.66,1.73],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[6.7,8.73,10.5,11.29,12.3,18.03,21.21,22.18],[5.96,8.38,6.7,4.12,10.51,13.46,21.03,2.95],[0.75,0,3.81,7.17,1.8,4.57,0.18,19.23],[0,0.35,0,0,0,0,0,0],[0.31,0.31,0.05,-0.21,0.22,0.14,0.4,-0.47],[-0.2,0.2,-0.5,-0.8,-0.3,-0.4,-0.1,-0.98],[7,6,18.72,19,16.34,31,4.11,33.86]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-cfafc43aa328ae939ee3" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-cfafc43aa328ae939ee3">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","USC-SIkJalpha","LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","epiforecasts-EpiNow2","RobertWalraven-ESG"],[0.46,0.56,0.87,0.95,1,1.23,1.83,2.1],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[64.11,77.59,120.74,132.79,138.56,171.69,254.39,142.21],[53.14,76.3,67.27,120.76,108.57,143.61,118.56,131.75],[9.62,1.29,53.48,12.03,29.99,28.09,135.65,10.46],[1.36,0,0,0,0,0,0.17,0],[-0.08,0.35,-0.12,0.31,0.18,0.18,0.14,0.09],[-0.39,-0.15,-0.7,-0.2,-0.35,-0.35,-0.2,-0.5],[47.43,24.5,228,133.87,214.33,235,507,67.14]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-23b1bef82c1b461c11a7" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-23b1bef82c1b461c11a7">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","USC-SIkJalpha","USC-SIkJalpha","LANL-GrowthRate","LANL-GrowthRate","IEM_Health-CovidProject","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","ILM-EKF","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiNow2","RobertWalraven-ESG","RobertWalraven-ESG"],[0.46,0.46,0.56,0.56,0.87,0.87,0.95,0.95,1,1,1.23,1.23,1.83,1.83,2.1,2.1],["IE","IE","IE","IE","IE","IE","IE","IE","IE","IE","IE","IE","IE","IE","IE","IE"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Ireland","Ireland","Ireland","Ireland","Ireland","Ireland","Ireland","Ireland","Ireland","Ireland","Ireland","Ireland","Ireland","Ireland","Ireland","Ireland"],[4813608,4813608,4813608,4813608,4813608,4813608,4813608,4813608,4813608,4813608,4813608,4813608,4813608,4813608,4813608,4813608],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[106.04,22.18,148.48,6.7,230.2,11.29,244.37,21.21,264.82,12.3,325.36,18.03,500.05,8.73,574.97,10.5],[103.32,2.95,146.65,5.96,130.41,4.12,220.49,21.03,206.64,10.51,273.75,13.46,228.74,8.38,542.66,6.7],[0,19.23,1.83,0.75,99.78,7.17,23.88,0.18,58.18,1.8,51.61,4.57,271.3,0,32.32,3.81],[2.72,0,0,0,0,0,0,0,0,0,0,0,0,0.35,0,0],[0.31,-0.47,0.4,0.31,-0.04,-0.21,0.22,0.4,0.14,0.22,0.22,0.14,-0.04,0.31,0.21,0.05],[0.2,-0.98,-0.1,-0.2,-0.6,-0.8,-0.3,-0.1,-0.4,-0.3,-0.3,-0.4,-0.6,0.2,-0.5,-0.5],[61,33.86,42,7,437,19,263.63,4.11,412.31,16.34,439,31,1008,6,226.22,18.72]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-e6148b091755336faa9f" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e6148b091755336faa9f">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["RobertWalraven-ESG","LANL-GrowthRate","UNIPV-BayesINGARCHX","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","epiforecasts-EpiNow2","ILM-EKF","USC-SIkJalpha"],[0.59,0.67,0.72,0.74,0.96,1.03,1.39,1.45,2.34],[1082.81,2288.81,4806.3,2558.39,3292,3519.87,4765.67,4974.17,8019.88],[790.96,2238.59,447.38,2250.64,2413.48,2165.29,3194.41,4220.7,7780.55],[169.95,22.43,0,85.7,13.22,12.5,0,0,239.33],[121.89,27.78,4358.92,222.04,865.29,1342.08,1571.25,753.48,0],[-0.38,0.05,-0.56,0.09,0.14,0.05,0.14,0.27,0.14],[-0.65,-0.4,1,-0.25,0,0,0.4,0.25,-0.4],[1115.59,689,5959,2921.35,5418.63,6299.43,8512.25,6399,2260.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-f29e0b90af41fc1f68b0" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f29e0b90af41fc1f68b0">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["RobertWalraven-ESG","LANL-GrowthRate","UNIPV-BayesINGARCHX","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","epiforecasts-EpiNow2","ILM-EKF","USC-SIkJalpha"],[0.59,0.67,0.72,0.74,0.96,1.03,1.39,1.45,2.34],[1082.81,2288.81,4806.3,2558.39,3292,3519.87,4765.67,4974.17,8019.88],[790.96,2238.59,447.38,2250.64,2413.48,2165.29,3194.41,4220.7,7780.55],[169.95,22.43,0,85.7,13.22,12.5,0,0,239.33],[121.89,27.78,4358.92,222.04,865.29,1342.08,1571.25,753.48,0],[-0.38,0.05,-0.56,0.09,0.14,0.05,0.14,0.27,0.14],[-0.65,-0.4,1,-0.25,0,0,0.4,0.25,-0.4],[1115.59,689,5959,2921.35,5418.63,6299.43,8512.25,6399,2260.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-b2bef019b481827cd85a" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b2bef019b481827cd85a">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["RobertWalraven-ESG","LANL-GrowthRate","UNIPV-BayesINGARCHX","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","epiforecasts-EpiNow2","ILM-EKF","USC-SIkJalpha"],[0.57,0.68,0.72,0.72,0.97,1.04,1.42,1.47,2.36],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[3824.48,4517.9,4806.3,4827.79,6482.86,6978.32,9467.47,9802.54,15774.4],[3302.1,4462.34,447.38,4383.7,4752.27,4294.16,6336.82,8300.76,15384.62],[0,0,0,0,0,0,0,0,389.78],[522.39,55.57,4358.92,444.08,1730.59,2684.16,3130.65,1501.78,0],[0.21,0.4,-0.56,0.31,0.14,0.05,0.05,0.22,0.31],[0.5,0.1,1,0.2,0.4,0.5,0.5,0.3,-0.2],[3656.71,1278,5959,5300.56,10674.5,12485.3,16931,12707,4103]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-cad1fc8f8afe5d2f2817" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-cad1fc8f8afe5d2f2817">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiExpert","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","ILM-EKF","RobertWalraven-ESG","USC-SIkJalpha","IEM_Health-CovidProject"],[0.47,0.49,0.5,0.8,1.15,1.96,2.1,2.28],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[59.72,61.43,63.86,101.13,145.81,248.38,265.36,288.99],[14.85,36.42,52,74.68,140.64,26.71,176.48,117.58],[44.87,25.01,0,26.44,0,221.68,88.88,171.41],[0,0,11.85,0,5.17,0,0,0],[-0.3,0.05,0.22,0.14,0.31,-0.56,-0.04,-0.12],[-0.9,-0.5,0.3,-0.4,0.2,-1,-0.6,-0.7],[100,113.57,93.5,162.76,91,342.21,418,542.13]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-ec75586691b0cc8b03e6" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-ec75586691b0cc8b03e6">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["RobertWalraven-ESG","LANL-GrowthRate","UNIPV-BayesINGARCHX","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","epiforecasts-EpiNow2","ILM-EKF","USC-SIkJalpha"],[0.59,0.67,0.72,0.74,0.96,1.03,1.39,1.45,2.34],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[1082.81,2288.81,4806.3,2558.39,3292,3519.87,4765.67,4974.17,8019.88],[790.96,2238.59,447.38,2250.64,2413.48,2165.29,3194.41,4220.7,7780.55],[169.95,22.43,0,85.7,13.22,12.5,0,0,239.33],[121.89,27.78,4358.92,222.04,865.29,1342.08,1571.25,753.48,0],[-0.38,0.05,-0.56,0.09,0.14,0.05,0.14,0.27,0.14],[-0.65,-0.4,1,-0.25,0,0,0.4,0.25,-0.4],[1115.59,689,5959,2921.35,5418.63,6299.43,8512.25,6399,2260.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-c663262d332a98dc328a" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-c663262d332a98dc328a">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"],["RobertWalraven-ESG","RobertWalraven-ESG","LANL-GrowthRate","LANL-GrowthRate","UNIPV-BayesINGARCHX","IEM_Health-CovidProject","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","epiforecasts-EpiExpert","epiforecasts-EpiNow2","epiforecasts-EpiNow2","ILM-EKF","ILM-EKF","USC-SIkJalpha","USC-SIkJalpha"],[0.59,0.59,0.67,0.67,0.72,0.74,0.74,0.96,0.96,1.03,1.03,1.39,1.39,1.45,1.45,2.34,2.34],["IT","IT","IT","IT","IT","IT","IT","IT","IT","IT","IT","IT","IT","IT","IT","IT","IT"],["inc case","inc death","inc case","inc death","inc case","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Italy","Italy","Italy","Italy","Italy","Italy","Italy","Italy","Italy","Italy","Italy","Italy","Italy","Italy","Italy","Italy","Italy"],[60551416,60551416,60551416,60551416,60551416,60551416,60551416,60551416,60551416,60551416,60551416,60551416,60551416,60551416,60551416,60551416,60551416],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[3824.48,248.38,4517.9,59.72,4806.3,4827.79,288.99,6482.86,101.13,6978.32,61.43,9467.47,63.86,9802.54,145.81,15774.4,265.36],[3302.1,26.71,4462.34,14.85,447.38,4383.7,117.58,4752.27,74.68,4294.16,36.42,6336.82,52,8300.76,140.64,15384.62,176.48],[0,221.68,0,44.87,0,0,171.41,0,26.44,0,25.01,0,0,0,0,389.78,88.88],[522.39,0,55.57,0,4358.92,444.08,0,1730.59,0,2684.16,0,3130.65,11.85,1501.78,5.17,0,0],[0.21,-0.56,0.4,-0.3,-0.56,0.31,-0.12,0.14,0.14,0.05,0.05,0.05,0.22,0.22,0.31,0.31,-0.04],[0.5,-1,0.1,-0.9,1,0.2,-0.7,0.4,-0.4,0.5,-0.5,0.5,0.3,0.3,0.2,-0.2,-0.6],[3656.71,342.21,1278,100,5959,5300.56,542.13,10674.5,162.76,12485.3,113.57,16931,93.5,12707,91,4103,418]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-da250b53aa44f4c0caf2" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-da250b53aa44f4c0caf2">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","LANL-GrowthRate","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","ILM-EKF","IEM_Health-CovidProject","RobertWalraven-ESG","USC-SIkJalpha"],[0.64,0.77,0.78,0.97,1,1.05,1.22,2.07],[125.52,150.8,152.37,189.99,195.41,204,114.74,403.34],[46.79,148.64,107.22,59.12,125.54,198.5,21.16,20.43],[0.14,0.87,0.29,0,0.61,0.38,3.73,0],[78.59,1.29,44.87,130.87,69.26,5.12,89.85,382.92],[0.01,0.22,0.14,-0.04,0.18,0.31,-0.31,-0.12],[0.25,-0.2,0.1,0.6,0.15,0,-0.38,0.6],[228.06,33.75,254.82,337,338,118.99,209.3,453.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-72dd2f14e7325a1474aa" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-72dd2f14e7325a1474aa">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","LANL-GrowthRate","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","ILM-EKF","IEM_Health-CovidProject","RobertWalraven-ESG","USC-SIkJalpha"],[0.64,0.77,0.78,0.97,1,1.05,1.22,2.07],[125.52,150.8,152.37,189.99,195.41,204,114.74,403.34],[46.79,148.64,107.22,59.12,125.54,198.5,21.16,20.43],[0.14,0.87,0.29,0,0.61,0.38,3.73,0],[78.59,1.29,44.87,130.87,69.26,5.12,89.85,382.92],[0.01,0.22,0.14,-0.04,0.18,0.31,-0.31,-0.12],[0.25,-0.2,0.1,0.6,0.15,0,-0.38,0.6],[228.06,33.75,254.82,337,338,118.99,209.3,453.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-9e66063bc7a889282e4a" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-9e66063bc7a889282e4a">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","LANL-GrowthRate","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","ILM-EKF","IEM_Health-CovidProject","RobertWalraven-ESG","USC-SIkJalpha"],[0.65,0.77,0.78,0.98,0.99,1.04,1.22,2.09],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[249.45,297.48,298.86,375.52,378.7,399.07,467.74,802.7],[92.26,294.9,209.13,114.56,240.18,388.83,82.65,37.07],[0,0,0,0,0,0,0,0],[157.18,2.59,89.74,260.96,138.52,10.24,385.09,765.63],[-0.21,0.4,0.05,-0.3,0.05,0.31,-0.64,-0.56],[0.8,0.1,0.5,0.9,0.5,0.2,1,1],[453.93,59.5,503.11,668,662,228.88,853.21,905]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-1dbcbe327683615308a0" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1dbcbe327683615308a0">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","USC-SIkJalpha","LANL-GrowthRate","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","RobertWalraven-ESG","IEM_Health-CovidProject","ILM-EKF"],[0.31,0.77,0.79,0.86,1.13,1.4,1.71,2.33],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[1.59,3.99,4.12,4.46,5.88,7.31,8.93,12.12],[1.32,3.79,2.38,3.68,5.3,2.44,8.17,10.9],[0.27,0,1.74,0,0.57,4.86,0.76,1.22],[0,0.21,0,0.78,0,0,0,0],[0.22,0.31,0.05,0.22,0.22,-0.21,0.31,0.31],[-0.3,0.2,-0.5,0.3,-0.3,-0.8,-0.2,-0.2],[2.2,2,8,6,6.53,13.33,9.1,14]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-55a7d72181d10ce06532" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-55a7d72181d10ce06532">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","LANL-GrowthRate","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","ILM-EKF","IEM_Health-CovidProject","RobertWalraven-ESG","USC-SIkJalpha"],[0.64,0.77,0.78,0.97,1,1.05,1.22,2.07],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[125.52,150.8,152.37,189.99,195.41,204,114.74,403.34],[46.79,148.64,107.22,59.12,125.54,198.5,21.16,20.43],[0.14,0.87,0.29,0,0.61,0.38,3.73,0],[78.59,1.29,44.87,130.87,69.26,5.12,89.85,382.92],[0.01,0.22,0.14,-0.04,0.18,0.31,-0.31,-0.12],[0.25,-0.2,0.1,0.6,0.15,0,-0.38,0.6],[228.06,33.75,254.82,337,338,118.99,209.3,453.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-fa4820794bfe9ec41da3" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-fa4820794bfe9ec41da3">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","LANL-GrowthRate","LANL-GrowthRate","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiNow2","ILM-EKF","ILM-EKF","IEM_Health-CovidProject","IEM_Health-CovidProject","RobertWalraven-ESG","RobertWalraven-ESG","USC-SIkJalpha","USC-SIkJalpha"],[0.64,0.64,0.77,0.77,0.78,0.78,0.97,0.97,1,1,1.05,1.05,1.22,1.22,2.07,2.07],["LV","LV","LV","LV","LV","LV","LV","LV","LV","LV","LV","LV","LV","LV","LV","LV"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Latvia","Latvia","Latvia","Latvia","Latvia","Latvia","Latvia","Latvia","Latvia","Latvia","Latvia","Latvia","Latvia","Latvia","Latvia","Latvia"],[1940740,1940740,1940740,1940740,1940740,1940740,1940740,1940740,1940740,1940740,1940740,1940740,1940740,1940740,1940740,1940740],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[249.45,1.59,297.48,4.12,298.86,5.88,375.52,4.46,378.7,12.12,399.07,8.93,467.74,7.31,802.7,3.99],[92.26,1.32,294.9,2.38,209.13,5.3,114.56,3.68,240.18,10.9,388.83,8.17,82.65,2.44,37.07,3.79],[0,0.27,0,1.74,0,0.57,0,0,0,1.22,0,0.76,0,4.86,0,0],[157.18,0,2.59,0,89.74,0,260.96,0.78,138.52,0,10.24,0,385.09,0,765.63,0.21],[-0.21,0.22,0.4,0.05,0.05,0.22,-0.3,0.22,0.05,0.31,0.31,0.31,-0.64,-0.21,-0.56,0.31],[0.8,-0.3,0.1,-0.5,0.5,-0.3,0.9,0.3,0.5,-0.2,0.2,-0.2,1,-0.8,1,0.2],[453.93,2.2,59.5,8,503.11,6.53,668,6,662,14,228.88,9.1,853.21,13.33,905,2]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-a7f040457e6f468c2e01" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-a7f040457e6f468c2e01">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiExpert","USC-SIkJalpha"],[0.56,0.7,0.77,1.05,1.1,1.32,1.43,1.53],[1.38,1.74,1.92,1.41,2.72,3.27,3.54,3.79],[1.23,1.49,0.94,1.15,1.39,1.72,1.86,1.89],[0.15,0.21,0.98,0.15,1.33,0.02,0.45,0.5],[0,0.05,0,0.11,0,1.52,1.22,1.41],[0.31,0.05,-0.21,0.09,-0.12,0.14,-0.3,-0.56],[-0.2,-0.4,-0.7,-0.27,-0.67,0.3,-0.2,0],[1.5,1.57,3.15,1.5,3.5,5.5,5.5,3.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-77f830550b998e47753c" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-77f830550b998e47753c">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiExpert","USC-SIkJalpha"],[0.56,0.7,0.77,1.05,1.1,1.32,1.43,1.53],[1.38,1.74,1.92,1.41,2.72,3.27,3.54,3.79],[1.23,1.49,0.94,1.15,1.39,1.72,1.86,1.89],[0.15,0.21,0.98,0.15,1.33,0.02,0.45,0.5],[0,0.05,0,0.11,0,1.52,1.22,1.41],[0.31,0.05,-0.21,0.09,-0.12,0.14,-0.3,-0.56],[-0.2,-0.4,-0.7,-0.27,-0.67,0.3,-0.2,0],[1.5,1.57,3.15,1.5,3.5,5.5,5.5,3.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-8c55302371533b3619f1" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-8c55302371533b3619f1">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","RobertWalraven-ESG","epiforecasts-EpiExpert","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.56,0.66,0.7,1.07,1.13,1.44,1.46,1.54],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[2.41,2.83,2.98,4.59,4.84,6.17,6.26,6.59],[2.32,1.87,2.89,2.76,4.35,3.72,3.21,3.77],[0.09,0.96,0,1.83,0,0,0,0],[0,0,0.09,0,0.49,2.45,3.04,2.82],[0.4,0.14,0.4,0.14,0.21,-0.04,-0.12,-0.56],[-0.1,-0.4,0.1,-0.4,0.5,0.6,0.7,1],[2,5.31,2.16,6,3.44,10,10,6]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-6482f3444bd28f48004e" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-6482f3444bd28f48004e">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiNow2","LANL-GrowthRate","RobertWalraven-ESG","EuroCOVIDhub-ensemble","ILM-EKF","epiforecasts-EpiExpert","IEM_Health-CovidProject","USC-SIkJalpha"],[0.48,0.6,0.62,0.86,1.44,1.56,1.7,1.7],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[0.28,0.35,0.37,0.5,0.85,0.92,1,1],[0.24,0.13,0.18,0.09,0.02,0.01,0,0],[0.04,0.22,0.19,0.42,0.83,0.91,1,1],[0,0,0,0,0,0,0,0],[0.4,0.22,0.05,-0.3,-0.39,-0.56,-0.56,-0.56],[-0.1,-0.3,-0.5,-0.9,-0.95,-1,-1,-1],[1,1,0.91,0.98,1,1,1,1]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-b478c72a95246b123123" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b478c72a95246b123123">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiExpert","USC-SIkJalpha"],[0.56,0.7,0.77,1.05,1.1,1.32,1.43,1.53],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[1.38,1.74,1.92,1.41,2.72,3.27,3.54,3.79],[1.23,1.49,0.94,1.15,1.39,1.72,1.86,1.89],[0.15,0.21,0.98,0.15,1.33,0.02,0.45,0.5],[0,0.05,0,0.11,0,1.52,1.22,1.41],[0.31,0.05,-0.21,0.09,-0.12,0.14,-0.3,-0.56],[-0.2,-0.4,-0.7,-0.27,-0.67,0.3,-0.2,0],[1.5,1.57,3.15,1.5,3.5,5.5,5.5,3.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-303a26c456df3323bd22" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-303a26c456df3323bd22">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["LANL-GrowthRate","LANL-GrowthRate","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","IEM_Health-CovidProject","RobertWalraven-ESG","RobertWalraven-ESG","ILM-EKF","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiNow2","epiforecasts-EpiExpert","epiforecasts-EpiExpert","USC-SIkJalpha","USC-SIkJalpha"],[0.56,0.56,0.7,0.7,0.77,0.77,1.05,1.05,1.1,1.1,1.32,1.32,1.43,1.43,1.53,1.53],["LI","LI","LI","LI","LI","LI","LI","LI","LI","LI","LI","LI","LI","LI","LI","LI"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein","Liechtenstein"],[37922,37922,37922,37922,37922,37922,37922,37922,37922,37922,37922,37922,37922,37922,37922,37922],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[2.41,0.35,2.98,0.5,2.83,1,4.84,0.37,4.59,0.85,6.26,0.28,6.17,0.92,6.59,1],[2.32,0.13,2.89,0.09,1.87,0,4.35,0.18,2.76,0.02,3.21,0.24,3.72,0.01,3.77,0],[0.09,0.22,0,0.42,0.96,1,0,0.19,1.83,0.83,0,0.04,0,0.91,0,1],[0,0,0.09,0,0,0,0.49,0,0,0,3.04,0,2.45,0,2.82,0],[0.4,0.22,0.4,-0.3,0.14,-0.56,0.21,0.05,0.14,-0.39,-0.12,0.4,-0.04,-0.56,-0.56,-0.56],[-0.1,-0.3,0.1,-0.9,-0.4,-1,0.5,-0.5,-0.4,-0.95,0.7,-0.1,0.6,-1,1,-1],[2,1,2.16,0.98,5.31,1,3.44,0.91,6,1,10,1,10,1,6,1]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-544d6ed2a845bf73a47b" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-544d6ed2a845bf73a47b">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","USC-SIkJalpha","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","RobertWalraven-ESG","LANL-GrowthRate","ILM-EKF","epiforecasts-EpiExpert"],[0.73,0.75,0.77,0.85,0.92,1.09,1.21,2.31],[177.91,184.48,187.76,208.24,105.94,266.19,297.07,565.51],[162.58,168.19,92.13,117.25,82.99,111.82,132.05,83.77],[15.33,0,0,0,0.08,154.37,0.11,0],[0,16.29,95.63,90.99,22.87,0,164.91,481.74],[0.31,-0.12,-0.21,0.09,0.29,-0.08,0.14,-0.47],[-0.2,0.6,0.8,0.45,-0.04,-0.65,0.3,0.98],[180.52,115.5,347.5,376.96,161.42,526.5,535.5,816.62]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-1005e0a0f4cda2c7ef86" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1005e0a0f4cda2c7ef86">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","USC-SIkJalpha","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","RobertWalraven-ESG","LANL-GrowthRate","ILM-EKF","epiforecasts-EpiExpert"],[0.73,0.75,0.77,0.85,0.92,1.09,1.21,2.31],[177.91,184.48,187.76,208.24,105.94,266.19,297.07,565.51],[162.58,168.19,92.13,117.25,82.99,111.82,132.05,83.77],[15.33,0,0,0,0.08,154.37,0.11,0],[0,16.29,95.63,90.99,22.87,0,164.91,481.74],[0.31,-0.12,-0.21,0.09,0.29,-0.08,0.14,-0.47],[-0.2,0.6,0.8,0.45,-0.04,-0.65,0.3,0.98],[180.52,115.5,347.5,376.96,161.42,526.5,535.5,816.62]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-c324ffd9a0273cfaee20" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-c324ffd9a0273cfaee20">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","USC-SIkJalpha","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","RobertWalraven-ESG","LANL-GrowthRate","ILM-EKF","epiforecasts-EpiExpert"],[0.73,0.75,0.76,0.85,0.93,1.1,1.21,2.31],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[349.03,359.48,362.87,409.76,445.83,529.22,581.93,1110.98],[318.73,332.74,180.78,228.69,347.83,221.82,252.1,162.79],[30.3,0,0,0,0,307.4,0,0],[0,26.74,182.09,181.07,98,0,329.83,948.19],[0.31,0.31,-0.12,-0.04,0.21,-0.12,-0.12,-0.56],[-0.2,0.2,0.7,0.6,0.5,-0.7,0.7,1],[355.52,212,674,745.66,686.03,1048,1066,1600.65]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-a4d8a740cd4ac5197843" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-a4d8a740cd4ac5197843">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","LANL-GrowthRate","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","USC-SIkJalpha","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiExpert"],[0.33,0.42,0.89,0.9,1.26,1.62,1.68,2.65],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[2.49,3.16,6.73,6.79,9.48,12.21,12.65,20.03],[2.38,1.82,5.81,6.44,3.65,11.99,3.48,4.75],[0.11,1.35,0,0.35,0,0.22,0,0],[0,0,0.92,0,5.83,0,9.17,15.28],[0.31,-0.04,0.22,0.31,-0.56,0.4,-0.3,-0.39],[-0.2,-0.6,0.3,-0.2,1,-0.1,0.9,0.95],[1.76,5,8.26,5.52,19,5,21,32.6]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-134865d7cabdb6514d44" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-134865d7cabdb6514d44">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","USC-SIkJalpha","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","RobertWalraven-ESG","LANL-GrowthRate","ILM-EKF","epiforecasts-EpiExpert"],[0.73,0.75,0.77,0.85,0.92,1.09,1.21,2.31],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[177.91,184.48,187.76,208.24,105.94,266.19,297.07,565.51],[162.58,168.19,92.13,117.25,82.99,111.82,132.05,83.77],[15.33,0,0,0,0.08,154.37,0.11,0],[0,16.29,95.63,90.99,22.87,0,164.91,481.74],[0.31,-0.12,-0.21,0.09,0.29,-0.08,0.14,-0.47],[-0.2,0.6,0.8,0.45,-0.04,-0.65,0.3,0.98],[180.52,115.5,347.5,376.96,161.42,526.5,535.5,816.62]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-7b8a157ca55bef24592d" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-7b8a157ca55bef24592d">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["IEM_Health-CovidProject","IEM_Health-CovidProject","USC-SIkJalpha","USC-SIkJalpha","epiforecasts-EpiNow2","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","RobertWalraven-ESG","RobertWalraven-ESG","LANL-GrowthRate","LANL-GrowthRate","ILM-EKF","ILM-EKF","epiforecasts-EpiExpert","epiforecasts-EpiExpert"],[0.73,0.73,0.75,0.75,0.77,0.77,0.85,0.85,0.92,0.92,1.09,1.09,1.21,1.21,2.31,2.31],["LT","LT","LT","LT","LT","LT","LT","LT","LT","LT","LT","LT","LT","LT","LT","LT"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania","Lithuania"],[2827721,2827721,2827721,2827721,2827721,2827721,2827721,2827721,2827721,2827721,2827721,2827721,2827721,2827721,2827721,2827721],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[349.03,6.79,359.48,9.48,362.87,12.65,409.76,6.73,445.83,2.49,529.22,3.16,581.93,12.21,1110.98,20.03],[318.73,6.44,332.74,3.65,180.78,3.48,228.69,5.81,347.83,2.38,221.82,1.82,252.1,11.99,162.79,4.75],[30.3,0.35,0,0,0,0,0,0,0,0.11,307.4,1.35,0,0.22,0,0],[0,0,26.74,5.83,182.09,9.17,181.07,0.92,98,0,0,0,329.83,0,948.19,15.28],[0.31,0.31,0.31,-0.56,-0.12,-0.3,-0.04,0.22,0.21,0.31,-0.12,-0.04,-0.12,0.4,-0.56,-0.39],[-0.2,-0.2,0.2,1,0.7,0.9,0.6,0.3,0.5,-0.2,-0.7,-0.6,0.7,-0.1,1,0.95],[355.52,5.52,212,19,674,21,745.66,8.26,686.03,1.76,1048,5,1066,5,1600.65,32.6]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-01c9e40af0dcd7d2a084" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-01c9e40af0dcd7d2a084">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","epiforecasts-EpiNow2"],[0.35,0.73,0.91,0.93,1.12,1.24,1.44,2.29],[24.7,51.47,63.73,65.15,78.55,87.4,54.97,161],[18.21,41.68,33.55,56.52,46.78,29.21,39.43,58.81],[6.5,4.08,30.18,3.17,31.76,58.19,15.54,2.23],[0,5.71,0,5.46,0,0,0,99.96],[-0.08,-0.04,-0.12,0.05,-0.25,-0.3,-0.38,-0.25],[-0.55,-0.3,-0.7,-0.2,-0.75,-0.8,-0.88,0.05],[17,62.19,121.96,72.5,138.25,143,49.77,279.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-e63aa4d2fff8f0d7f27d" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e63aa4d2fff8f0d7f27d">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","epiforecasts-EpiNow2"],[0.35,0.73,0.91,0.93,1.12,1.24,1.44,2.29],[24.7,51.47,63.73,65.15,78.55,87.4,54.97,161],[18.21,41.68,33.55,56.52,46.78,29.21,39.43,58.81],[6.5,4.08,30.18,3.17,31.76,58.19,15.54,2.23],[0,5.71,0,5.46,0,0,0,99.96],[-0.08,-0.04,-0.12,0.05,-0.25,-0.3,-0.38,-0.25],[-0.55,-0.3,-0.7,-0.2,-0.75,-0.8,-0.88,0.05],[17,62.19,121.96,72.5,138.25,143,49.77,279.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-fded1b06897d95c66b45" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-fded1b06897d95c66b45">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","epiforecasts-EpiNow2"],[0.29,0.74,0.9,0.95,1.14,1.28,1.49,2.49],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[36.9,93.14,114.44,120.41,144.69,162.62,188.62,316.01],[36.03,81.72,65.22,109.5,92.86,57.88,166.24,116.09],[0.87,0,49.22,0,51.83,104.74,22.38,0],[0,11.42,0,10.91,0,0,0,199.91],[0.4,0.22,0.05,0.22,0.05,-0.04,0.21,-0.3],[-0.1,0.3,-0.5,0.3,-0.5,-0.6,-0.5,0.9],[20,107.08,221.68,123,261.5,272,156.69,548]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-b800abf7a0d9a916fc08" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b800abf7a0d9a916fc08">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","ILM-EKF","USC-SIkJalpha","LANL-GrowthRate","epiforecasts-EpiExpert","IEM_Health-CovidProject","RobertWalraven-ESG"],[0.55,0.9,0.9,1.11,1.13,1.14,1.19,1.31],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[5.99,9.8,9.89,12.18,12.41,12.5,13.03,14.29],[1.53,1.63,3.54,0.54,0.71,0.38,1.88,0.84],[4.46,8.16,6.35,11.63,11.69,12.12,11.15,13.45],[0,0,0,0,0,0,0,0],[-0.21,-0.3,-0.12,-0.56,-0.56,-0.56,-0.3,-0.56],[-0.8,-0.9,-0.7,-1,-1,-1,-0.9,-1],[11,17.3,22,14,15,14,22.24,17.23]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-11b9dcb5bff3d8e58cfc" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-11b9dcb5bff3d8e58cfc">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","epiforecasts-EpiNow2"],[0.35,0.73,0.91,0.93,1.12,1.24,1.44,2.29],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[24.7,51.47,63.73,65.15,78.55,87.4,54.97,161],[18.21,41.68,33.55,56.52,46.78,29.21,39.43,58.81],[6.5,4.08,30.18,3.17,31.76,58.19,15.54,2.23],[0,5.71,0,5.46,0,0,0,99.96],[-0.08,-0.04,-0.12,0.05,-0.25,-0.3,-0.38,-0.25],[-0.55,-0.3,-0.7,-0.2,-0.75,-0.8,-0.88,0.05],[17,62.19,121.96,72.5,138.25,143,49.77,279.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-386bdabe2785d6625038" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-386bdabe2785d6625038">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","IEM_Health-CovidProject","ILM-EKF","ILM-EKF","LANL-GrowthRate","LANL-GrowthRate","USC-SIkJalpha","USC-SIkJalpha","RobertWalraven-ESG","RobertWalraven-ESG","epiforecasts-EpiNow2","epiforecasts-EpiNow2"],[0.35,0.35,0.73,0.73,0.91,0.91,0.93,0.93,1.12,1.12,1.24,1.24,1.44,1.44,2.29,2.29],["LU","LU","LU","LU","LU","LU","LU","LU","LU","LU","LU","LU","LU","LU","LU","LU"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg","Luxembourg"],[599449,599449,599449,599449,599449,599449,599449,599449,599449,599449,599449,599449,599449,599449,599449,599449],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[36.9,12.5,93.14,9.8,114.44,13.03,120.41,9.89,144.69,12.41,162.62,12.18,188.62,14.29,316.01,5.99],[36.03,0.38,81.72,1.63,65.22,1.88,109.5,3.54,92.86,0.71,57.88,0.54,166.24,0.84,116.09,1.53],[0.87,12.12,0,8.16,49.22,11.15,0,6.35,51.83,11.69,104.74,11.63,22.38,13.45,0,4.46],[0,0,11.42,0,0,0,10.91,0,0,0,0,0,0,0,199.91,0],[0.4,-0.56,0.22,-0.3,0.05,-0.3,0.22,-0.12,0.05,-0.56,-0.04,-0.56,0.21,-0.56,-0.3,-0.21],[-0.1,-1,0.3,-0.9,-0.5,-0.9,0.3,-0.7,-0.5,-1,-0.6,-1,-0.5,-1,0.9,-0.8],[20,14,107.08,17.3,221.68,22.24,123,22,261.5,15,272,14,156.69,17.23,548,11]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-e6ce3d0d3b8007901cd3" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e6ce3d0d3b8007901cd3">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","USC-SIkJalpha","epiforecasts-EpiExpert","epiforecasts-EpiNow2"],[0.45,0.47,0.55,0.93,1.1,1.24,2.36,2.81],[37.41,19.74,45.84,76.92,90.66,102.15,195.13,232.01],[34.78,13.52,42.85,52.27,64.18,88.4,31.43,71.29],[2.57,1.73,3,0.77,26.48,13.76,0.12,0.02],[0.07,4.49,0,23.88,0,0,163.58,160.7],[0.31,-0.31,0.14,0.05,0.14,-0.04,-0.12,0.05],[0,-0.63,-0.4,0,-0.4,-0.6,0.34,0.4],[35.5,34.67,27.87,128.43,154,77,292.64,378.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-2084dd7325a8a275f113" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-2084dd7325a8a275f113">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","USC-SIkJalpha","epiforecasts-EpiExpert","epiforecasts-EpiNow2"],[0.45,0.47,0.55,0.93,1.1,1.24,2.36,2.81],[37.41,19.74,45.84,76.92,90.66,102.15,195.13,232.01],[34.78,13.52,42.85,52.27,64.18,88.4,31.43,71.29],[2.57,1.73,3,0.77,26.48,13.76,0.12,0.02],[0.07,4.49,0,23.88,0,0,163.58,160.7],[0.31,-0.31,0.14,0.05,0.14,-0.04,-0.12,0.05],[0,-0.63,-0.4,0,-0.4,-0.6,0.34,0.4],[35.5,34.67,27.87,128.43,154,77,292.64,378.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-f0712ae4fe9de4d99351" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f0712ae4fe9de4d99351">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","USC-SIkJalpha","epiforecasts-EpiExpert","epiforecasts-EpiNow2"],[0.46,0.47,0.53,0.93,1.08,1.25,2.41,2.87],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[73.92,75.7,85.28,150.52,174.8,201.7,389.03,462.25],[68.79,56.46,83.42,102.76,124.89,175.47,61.87,140.86],[5.13,0,1.86,0,49.91,26.23,0,0],[0,19.24,0,47.76,0,0,327.17,321.39],[0.31,0.21,0.4,0.05,0.14,0.05,-0.47,-0.3],[-0.2,0.5,-0.1,0.5,-0.4,-0.5,0.98,0.9],[70,134.69,42.67,250.03,294,149,583.48,756]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-25e1902ce6cdc03f677d" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-25e1902ce6cdc03f677d">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiExpert","epiforecasts-EpiNow2","USC-SIkJalpha","RobertWalraven-ESG","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","ILM-EKF"],[0.35,0.48,0.69,1.01,1.05,1.29,2.5,2.54],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[0.89,1.23,1.76,2.61,2.71,3.32,6.41,6.52],[0.76,0.99,1.72,1.32,0.45,1.78,2.27,3.48],[0,0.24,0.04,1.29,2.26,1.54,4.14,3.04],[0.13,0,0,0,0,0,0,0],[0.31,0.22,0.4,-0.12,-0.47,0.05,-0.12,0.14],[0.2,-0.3,-0.1,-0.7,-0.98,-0.5,-0.7,-0.4],[1,1.81,1,5,4.23,6.82,13.07,14]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-caa0915472e71a7803c4" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-caa0915472e71a7803c4">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","ILM-EKF","USC-SIkJalpha","epiforecasts-EpiExpert","epiforecasts-EpiNow2"],[0.45,0.47,0.55,0.93,1.1,1.24,2.36,2.81],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[37.41,19.74,45.84,76.92,90.66,102.15,195.13,232.01],[34.78,13.52,42.85,52.27,64.18,88.4,31.43,71.29],[2.57,1.73,3,0.77,26.48,13.76,0.12,0.02],[0.07,4.49,0,23.88,0,0,163.58,160.7],[0.31,-0.31,0.14,0.05,0.14,-0.04,-0.12,0.05],[0,-0.63,-0.4,0,-0.4,-0.6,0.34,0.4],[35.5,34.67,27.87,128.43,154,77,292.64,378.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-77b08f31545f78f5596a" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-77b08f31545f78f5596a">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["LANL-GrowthRate","LANL-GrowthRate","RobertWalraven-ESG","RobertWalraven-ESG","IEM_Health-CovidProject","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","ILM-EKF","ILM-EKF","USC-SIkJalpha","USC-SIkJalpha","epiforecasts-EpiExpert","epiforecasts-EpiExpert","epiforecasts-EpiNow2","epiforecasts-EpiNow2"],[0.45,0.45,0.47,0.47,0.55,0.55,0.93,0.93,1.1,1.1,1.24,1.24,2.36,2.36,2.81,2.81],["MT","MT","MT","MT","MT","MT","MT","MT","MT","MT","MT","MT","MT","MT","MT","MT"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Malta","Malta","Malta","Malta","Malta","Malta","Malta","Malta","Malta","Malta","Malta","Malta","Malta","Malta","Malta","Malta"],[465292,465292,465292,465292,465292,465292,465292,465292,465292,465292,465292,465292,465292,465292,465292,465292],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[73.92,0.89,75.7,2.71,85.28,6.41,150.52,3.32,174.8,6.52,201.7,2.61,389.03,1.23,462.25,1.76],[68.79,0.76,56.46,0.45,83.42,2.27,102.76,1.78,124.89,3.48,175.47,1.32,61.87,0.99,140.86,1.72],[5.13,0,0,2.26,1.86,4.14,0,1.54,49.91,3.04,26.23,1.29,0,0.24,0,0.04],[0,0.13,19.24,0,0,0,47.76,0,0,0,0,0,327.17,0,321.39,0],[0.31,0.31,0.21,-0.47,0.4,-0.12,0.05,0.05,0.14,0.14,0.05,-0.12,-0.47,0.22,-0.3,0.4],[-0.2,0.2,0.5,-0.98,-0.1,-0.7,0.5,-0.5,-0.4,-0.4,-0.5,-0.7,0.98,-0.3,0.9,-0.1],[70,1,134.69,4.23,42.67,13.07,250.03,6.82,294,14,149,5,583.48,1.81,756,1]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-360476b56de7127ddaa5" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-360476b56de7127ddaa5">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha","LANL-GrowthRate"],[0.53,0.71,0.73,0.83,0.86,1.49,1.54,2.24],[540.27,729.16,741.55,400.32,874.75,1521.85,1568.61,2288.72],[538.76,383.73,546.2,373.02,820.34,446.62,1462.84,503.57],[0,345.43,194.29,26.87,53.52,1054.91,87.15,1781.78],[1.51,0,1.07,0.43,0.89,20.32,18.62,3.37],[0.4,0.05,0.18,0.29,0.31,-0.3,-0.12,-0.12],[0.1,-0.5,-0.05,0.04,0,0.07,0.4,-0.2],[34.69,1381.63,1204.85,193.41,741.5,2757,790.5,3932.25]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-6047e55a3f777e662f39" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-6047e55a3f777e662f39">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha","LANL-GrowthRate"],[0.53,0.71,0.73,0.83,0.86,1.49,1.54,2.24],[540.27,729.16,741.55,400.32,874.75,1521.85,1568.61,2288.72],[538.76,383.73,546.2,373.02,820.34,446.62,1462.84,503.57],[0,345.43,194.29,26.87,53.52,1054.91,87.15,1781.78],[1.51,0,1.07,0.43,0.89,20.32,18.62,3.37],[0.4,0.05,0.18,0.29,0.31,-0.3,-0.12,-0.12],[0.1,-0.5,-0.05,0.04,0,0.07,0.4,-0.2],[34.69,1381.63,1204.85,193.41,741.5,2757,790.5,3932.25]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-7fdc4acaab114480b045" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-7fdc4acaab114480b045">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha","LANL-GrowthRate"],[0.52,0.72,0.73,0.84,0.85,1.48,1.53,2.26],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[1050.81,1449.43,1463.33,1691.9,1715.6,2989.7,3080.12,4560.94],[1047.86,761.11,1074.76,1576.75,1608.56,879.87,2905.82,997.37],[0,688.32,388.57,115.15,107.04,2109.83,174.3,3563.57],[2.95,0,0,0,0,0,0,0],[0.4,-0.04,0.14,0.21,0.31,-0.21,0.31,-0.3],[0.1,-0.6,-0.4,-0.5,-0.2,-0.8,-0.2,-0.9],[67.81,2748.29,2388.41,806.07,1460,5424,1469,7835.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-b6828d1d6072db8f19b9" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-b6828d1d6072db8f19b9">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","epiforecasts-EpiExpert","LANL-GrowthRate","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha"],[0.32,0.4,0.73,0.88,1.32,1.51,2.4,2.54],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[7.24,8.89,16.5,19.78,29.74,33.9,54.01,57.11],[6.67,6.36,9.76,17.64,29.67,32.12,13.38,19.87],[0,2.54,0,0,0,0,0,0],[0.56,0,6.74,2.14,0.07,1.78,40.63,37.23],[0.31,0.14,0.05,0.22,0.4,0.31,-0.39,-0.56],[0.2,-0.4,0.5,0.3,0.1,0.2,0.95,1],[6.95,14.97,29,21.3,1.57,23,90,112]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-a25b9559a221d2c4178b" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-a25b9559a221d2c4178b">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["IEM_Health-CovidProject","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2","USC-SIkJalpha","LANL-GrowthRate"],[0.53,0.71,0.73,0.83,0.86,1.49,1.54,2.24],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[540.27,729.16,741.55,400.32,874.75,1521.85,1568.61,2288.72],[538.76,383.73,546.2,373.02,820.34,446.62,1462.84,503.57],[0,345.43,194.29,26.87,53.52,1054.91,87.15,1781.78],[1.51,0,1.07,0.43,0.89,20.32,18.62,3.37],[0.4,0.05,0.18,0.29,0.31,-0.3,-0.12,-0.12],[0.1,-0.5,-0.05,0.04,0,0.07,0.4,-0.2],[34.69,1381.63,1204.85,193.41,741.5,2757,790.5,3932.25]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-cfcc3df9eaa14ff44350" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-cfcc3df9eaa14ff44350">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["IEM_Health-CovidProject","IEM_Health-CovidProject","epiforecasts-EpiExpert","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","RobertWalraven-ESG","RobertWalraven-ESG","ILM-EKF","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiNow2","USC-SIkJalpha","USC-SIkJalpha","LANL-GrowthRate","LANL-GrowthRate"],[0.53,0.53,0.71,0.71,0.73,0.73,0.83,0.83,0.86,0.86,1.49,1.49,1.54,1.54,2.24,2.24],["NL","NL","NL","NL","NL","NL","NL","NL","NL","NL","NL","NL","NL","NL","NL","NL"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands","Netherlands"],[17132854,17132854,17132854,17132854,17132854,17132854,17132854,17132854,17132854,17132854,17132854,17132854,17132854,17132854,17132854,17132854],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[1050.81,29.74,1449.43,8.89,1463.33,19.78,1691.9,7.24,1715.6,33.9,2989.7,54.01,3080.12,57.11,4560.94,16.5],[1047.86,29.67,761.11,6.36,1074.76,17.64,1576.75,6.67,1608.56,32.12,879.87,13.38,2905.82,19.87,997.37,9.76],[0,0,688.32,2.54,388.57,0,115.15,0,107.04,0,2109.83,0,174.3,0,3563.57,0],[2.95,0.07,0,0,0,2.14,0,0.56,0,1.78,0,40.63,0,37.23,0,6.74],[0.4,0.4,-0.04,0.14,0.14,0.22,0.21,0.31,0.31,0.31,-0.21,-0.39,0.31,-0.56,-0.3,0.05],[0.1,0.1,-0.6,-0.4,-0.4,0.3,-0.5,0.2,-0.2,0.2,-0.8,0.95,-0.2,1,-0.9,0.5],[67.81,1.57,2748.29,14.97,2388.41,21.3,806.07,6.95,1460,23,5424,90,1469,112,7835.5,29]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-e1c0f44ed93ab6f12dcd" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e1c0f44ed93ab6f12dcd">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiNow2","LANL-GrowthRate","epiforecasts-EpiExpert","RobertWalraven-ESG","EuroCOVIDhub-ensemble","USC-SIkJalpha","ILM-EKF","IEM_Health-CovidProject"],[0.46,0.51,0.58,0.99,1.05,1.48,2.11,2.27],[138.21,154.66,175.4,140.56,316.06,446.03,636.89,685.76],[135.71,123.85,83.9,29.14,106.39,326.09,104.76,101.35],[0,30.53,90.5,110.75,209.46,119.87,532.13,584.41],[2.5,0.28,1,0.68,0.21,0.06,0,0],[0.18,0.22,-0.17,-0.05,0.01,0.14,0.03,-0.12],[0.35,0,0.15,0.16,-0.25,-0.2,-0.48,-0.64],[37.5,231.5,336.78,268.82,594.89,622.5,1024,1048.37]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-0ed9f18e0d897ba0e792" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-0ed9f18e0d897ba0e792">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiNow2","LANL-GrowthRate","epiforecasts-EpiExpert","RobertWalraven-ESG","EuroCOVIDhub-ensemble","USC-SIkJalpha","ILM-EKF","IEM_Health-CovidProject"],[0.46,0.51,0.58,0.99,1.05,1.48,2.11,2.27],[138.21,154.66,175.4,140.56,316.06,446.03,636.89,685.76],[135.71,123.85,83.9,29.14,106.39,326.09,104.76,101.35],[0,30.53,90.5,110.75,209.46,119.87,532.13,584.41],[2.5,0.28,1,0.68,0.21,0.06,0,0],[0.18,0.22,-0.17,-0.05,0.01,0.14,0.03,-0.12],[0.35,0,0.15,0.16,-0.25,-0.2,-0.48,-0.64],[37.5,231.5,336.78,268.82,594.89,622.5,1024,1048.37]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-e6a5faebb7ffe2cc82e4" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e6a5faebb7ffe2cc82e4">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiNow2","LANL-GrowthRate","epiforecasts-EpiExpert","RobertWalraven-ESG","EuroCOVIDhub-ensemble","USC-SIkJalpha","ILM-EKF","IEM_Health-CovidProject"],[0.45,0.51,0.58,0.99,1.05,1.48,2.12,2.28],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[272.22,306.72,347.87,593.98,629.75,891.06,1270.31,1369.68],[269.26,245.66,166.86,119.35,210.84,651.32,206.05,201.22],[0,61.06,181.01,474.64,418.92,239.74,1064.26,1168.46],[2.96,0,0,0,0,0,0,0],[0.4,0.22,-0.04,-0.36,-0.21,-0.04,-0.39,-0.47],[0.1,-0.3,-0.6,-0.95,-0.8,-0.6,-0.95,-0.98],[68,460,668.63,1137.12,1187.05,1244,2048,2093.91]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-8470a0e4c055cb6fa48d" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-8470a0e4c055cb6fa48d">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["USC-SIkJalpha","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","RobertWalraven-ESG","LANL-GrowthRate","epiforecasts-EpiExpert","ILM-EKF","epiforecasts-EpiNow2"],[0.41,0.76,0.97,1.05,1.07,1.2,1.43,1.72],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[0.99,1.85,2.38,2.57,2.6,2.93,3.48,4.2],[0.87,1.49,1.95,1.68,2.04,0.93,3.48,2.15],[0,0.36,0,0,0,0,0,0],[0.12,0,0.43,0.89,0.57,1.99,0,2.04],[0.31,0.22,0.22,0.05,0.22,-0.3,0.44,-0.04],[0.2,-0.3,0.3,0.5,0.3,0.9,0,0.6],[1,2.82,2.73,4.55,3,4.93,0,7]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-5f577631d7f1789acc20" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-5f577631d7f1789acc20">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiNow2","LANL-GrowthRate","epiforecasts-EpiExpert","RobertWalraven-ESG","EuroCOVIDhub-ensemble","USC-SIkJalpha","ILM-EKF","IEM_Health-CovidProject"],[0.46,0.51,0.58,0.99,1.05,1.48,2.11,2.27],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[138.21,154.66,175.4,140.56,316.06,446.03,636.89,685.76],[135.71,123.85,83.9,29.14,106.39,326.09,104.76,101.35],[0,30.53,90.5,110.75,209.46,119.87,532.13,584.41],[2.5,0.28,1,0.68,0.21,0.06,0,0],[0.18,0.22,-0.17,-0.05,0.01,0.14,0.03,-0.12],[0.35,0,0.15,0.16,-0.25,-0.2,-0.48,-0.64],[37.5,231.5,336.78,268.82,594.89,622.5,1024,1048.37]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-d7c672be00674d4bcd04" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d7c672be00674d4bcd04">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiNow2","epiforecasts-EpiNow2","LANL-GrowthRate","LANL-GrowthRate","epiforecasts-EpiExpert","epiforecasts-EpiExpert","RobertWalraven-ESG","RobertWalraven-ESG","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","USC-SIkJalpha","USC-SIkJalpha","ILM-EKF","ILM-EKF","IEM_Health-CovidProject","IEM_Health-CovidProject"],[0.46,0.46,0.51,0.51,0.58,0.58,0.99,0.99,1.05,1.05,1.48,1.48,2.11,2.11,2.27,2.27],["NO","NO","NO","NO","NO","NO","NO","NO","NO","NO","NO","NO","NO","NO","NO","NO"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Norway","Norway","Norway","Norway","Norway","Norway","Norway","Norway","Norway","Norway","Norway","Norway","Norway","Norway","Norway","Norway"],[5282223,5282223,5282223,5282223,5282223,5282223,5282223,5282223,5282223,5282223,5282223,5282223,5282223,5282223,5282223,5282223],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[272.22,4.2,306.72,2.6,347.87,2.93,593.98,2.57,629.75,2.38,891.06,0.99,1270.31,3.48,1369.68,1.85],[269.26,2.15,245.66,2.04,166.86,0.93,119.35,1.68,210.84,1.95,651.32,0.87,206.05,3.48,201.22,1.49],[0,0,61.06,0,181.01,0,474.64,0,418.92,0,239.74,0,1064.26,0,1168.46,0.36],[2.96,2.04,0,0.57,0,1.99,0,0.89,0,0.43,0,0.12,0,0,0,0],[0.4,-0.04,0.22,0.22,-0.04,-0.3,-0.36,0.05,-0.21,0.22,-0.04,0.31,-0.39,0.44,-0.47,0.22],[0.1,0.6,-0.3,0.3,-0.6,0.9,-0.95,0.5,-0.8,0.3,-0.6,0.2,-0.95,0,-0.98,-0.3],[68,7,460,3,668.63,4.93,1137.12,4.55,1187.05,2.73,1244,1,2048,0,2093.91,2.82]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-2284acb60e6a107a6cc9" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-2284acb60e6a107a6cc9">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13"],["RobertWalraven-ESG","MOCOS-agent1","ILM-EKF","epiforecasts-EpiNow2","LANL-GrowthRate","IEM_Health-CovidProject","MIMUW-StochSEIR","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","UVA-Ensemble","USC-SIkJalpha","MIT_CovidAnalytics-DELPHI","ICM-agentModel"],[0.42,0.5,0.56,0.57,0.68,1.01,1.04,1.06,1.12,1.18,1.82,2.39,3.42],[964.08,2019.07,2281.04,2300.06,2761.45,4101.38,4196.9,4287.51,4519.46,9226.15,7371.98,9664.71,13822.43],[485.59,1412.86,2152.28,2008.97,2350.43,2129.96,591.05,2407.67,1224.39,3206.94,6414.63,2861.57,6915.27],[478.49,606.21,0,0,411.02,1971.42,3605.85,1879.84,3295.07,6019.21,957.35,6803.13,6907.17],[0,0,128.76,291.09,0,0,0,0,0,0,0,0,0],[-0.45,-0.12,0.35,0.18,0.01,-0.08,-0.52,-0.04,-0.34,-0.36,0.31,-0.3,0.09],[-0.95,-0.7,0.15,0.35,-0.55,-0.65,-0.99,-0.6,-0.92,-0.95,-0.2,-0.9,-0.45],[2001.66,3363.25,1811.5,2707.5,3525,7920.79,6160.5,8154.01,8103.72,21125.94,7044,17298.5,26979.24]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-ae7483e92e6135bc7657" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-ae7483e92e6135bc7657">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13"],["RobertWalraven-ESG","MOCOS-agent1","ILM-EKF","epiforecasts-EpiNow2","LANL-GrowthRate","IEM_Health-CovidProject","MIMUW-StochSEIR","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","UVA-Ensemble","USC-SIkJalpha","MIT_CovidAnalytics-DELPHI","ICM-agentModel"],[0.42,0.5,0.56,0.57,0.68,1.01,1.04,1.06,1.12,1.18,1.82,2.39,3.42],[964.08,2019.07,2281.04,2300.06,2761.45,4101.38,4196.9,4287.51,4519.46,9226.15,7371.98,9664.71,13822.43],[485.59,1412.86,2152.28,2008.97,2350.43,2129.96,591.05,2407.67,1224.39,3206.94,6414.63,2861.57,6915.27],[478.49,606.21,0,0,411.02,1971.42,3605.85,1879.84,3295.07,6019.21,957.35,6803.13,6907.17],[0,0,128.76,291.09,0,0,0,0,0,0,0,0,0],[-0.45,-0.12,0.35,0.18,0.01,-0.08,-0.52,-0.04,-0.34,-0.36,0.31,-0.3,0.09],[-0.95,-0.7,0.15,0.35,-0.55,-0.65,-0.99,-0.6,-0.92,-0.95,-0.2,-0.9,-0.45],[2001.66,3363.25,1811.5,2707.5,3525,7920.79,6160.5,8154.01,8103.72,21125.94,7044,17298.5,26979.24]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-38b19be7362f278507ff" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-38b19be7362f278507ff">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13"],["RobertWalraven-ESG","MOCOS-agent1","ILM-EKF","epiforecasts-EpiNow2","LANL-GrowthRate","IEM_Health-CovidProject","MIMUW-StochSEIR","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","UVA-Ensemble","USC-SIkJalpha","MIT_CovidAnalytics-DELPHI","ICM-agentModel"],[0.4,0.49,0.57,0.58,0.69,0.99,1.04,1.07,1.12,1.18,1.86,2.43,3.48],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[3109.75,3858.76,4440.3,4531.91,5421.53,7786.54,8181.88,8401,8775.96,9226.15,14596.14,19039.17,27303.22],[1963.04,2779.5,4184.09,3968.6,4658.28,4091.92,1178.7,4721.46,2405.17,3206.94,12682.74,5649.75,13526.21],[1146.71,1079.26,0,0,763.26,3694.62,7003.17,3679.53,6370.79,6019.21,1913.4,13389.42,13777.02],[0,0,256.22,563.3,0,0,0,0,0,0,0,0,0],[-0.07,0.05,0.31,0.22,0.22,-0.04,-0.47,-0.04,-0.3,-0.36,0.22,-0.3,-0.04],[-0.8,-0.5,0.2,0.3,-0.3,-0.6,-0.98,-0.6,-0.9,-0.95,-0.3,-0.9,-0.6],[7141.69,6399.5,3593,5306,6863,15013.2,12097,15972.93,15785,21125.94,14058,34096,53541.95]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-2d24f6eb3a3ea93fcc82" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-2d24f6eb3a3ea93fcc82">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12"],["epiforecasts-EpiNow2","LANL-GrowthRate","ILM-EKF","USC-SIkJalpha","EuroCOVIDhub-ensemble","MOCOS-agent1","MIMUW-StochSEIR","epiforecasts-EpiExpert","MIT_CovidAnalytics-DELPHI","RobertWalraven-ESG","ICM-agentModel","IEM_Health-CovidProject"],[0.35,0.52,0.63,0.76,0.9,0.93,1.09,1.36,1.5,1.61,1.76,2.15],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[68.22,101.37,121.77,147.82,174.03,179.39,211.92,262.97,290.25,311.05,341.64,416.22],[49.34,42.58,120.47,146.52,93.89,46.23,3.4,43.61,73.4,35.93,304.33,168],[0,58.79,0,1.3,80.14,133.16,208.52,219.36,216.85,275.12,37.31,248.22],[18.88,0,1.3,0,0,0,0,0,0,0,0,0],[0.14,-0.21,0.4,0.4,-0.04,-0.3,-0.56,-0.39,-0.3,-0.56,0.22,-0.12],[0.4,-0.8,0.1,-0.1,-0.6,-0.9,-1,-0.95,-0.9,-1,-0.3,-0.7],[109,187,30,30,335.09,327,224,422.44,501,437.3,416.52,828.37]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-81cabeff9bc7effa67f7" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-81cabeff9bc7effa67f7">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13"],["RobertWalraven-ESG","MOCOS-agent1","ILM-EKF","epiforecasts-EpiNow2","LANL-GrowthRate","IEM_Health-CovidProject","MIMUW-StochSEIR","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","UVA-Ensemble","USC-SIkJalpha","MIT_CovidAnalytics-DELPHI","ICM-agentModel"],[0.42,0.5,0.56,0.57,0.68,1.01,1.04,1.06,1.12,1.18,1.82,2.39,3.42],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[964.08,2019.07,2281.04,2300.06,2761.45,4101.38,4196.9,4287.51,4519.46,9226.15,7371.98,9664.71,13822.43],[485.59,1412.86,2152.28,2008.97,2350.43,2129.96,591.05,2407.67,1224.39,3206.94,6414.63,2861.57,6915.27],[478.49,606.21,0,0,411.02,1971.42,3605.85,1879.84,3295.07,6019.21,957.35,6803.13,6907.17],[0,0,128.76,291.09,0,0,0,0,0,0,0,0,0],[-0.45,-0.12,0.35,0.18,0.01,-0.08,-0.52,-0.04,-0.34,-0.36,0.31,-0.3,0.09],[-0.95,-0.7,0.15,0.35,-0.55,-0.65,-0.99,-0.6,-0.92,-0.95,-0.2,-0.9,-0.45],[2001.66,3363.25,1811.5,2707.5,3525,7920.79,6160.5,8154.01,8103.72,21125.94,7044,17298.5,26979.24]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-d01f3b09785dad1af161" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d01f3b09785dad1af161">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"],["RobertWalraven-ESG","RobertWalraven-ESG","MOCOS-agent1","MOCOS-agent1","ILM-EKF","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiNow2","LANL-GrowthRate","LANL-GrowthRate","IEM_Health-CovidProject","IEM_Health-CovidProject","MIMUW-StochSEIR","MIMUW-StochSEIR","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","epiforecasts-EpiExpert","UVA-Ensemble","USC-SIkJalpha","USC-SIkJalpha","MIT_CovidAnalytics-DELPHI","MIT_CovidAnalytics-DELPHI","ICM-agentModel","ICM-agentModel"],[0.42,0.42,0.5,0.5,0.56,0.56,0.57,0.57,0.68,0.68,1.01,1.01,1.04,1.04,1.06,1.06,1.12,1.12,1.18,1.82,1.82,2.39,2.39,3.42,3.42],["PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL","PL"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland","Poland"],[37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841,37975841],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[3109.75,311.05,3858.76,179.39,4440.3,121.77,4531.91,68.22,5421.53,101.37,7786.54,416.22,8181.88,211.92,8401,174.03,8775.96,262.97,9226.15,14596.14,147.82,19039.17,290.25,27303.22,341.64],[1963.04,35.93,2779.5,46.23,4184.09,120.47,3968.6,49.34,4658.28,42.58,4091.92,168,1178.7,3.4,4721.46,93.89,2405.17,43.61,3206.94,12682.74,146.52,5649.75,73.4,13526.21,304.33],[1146.71,275.12,1079.26,133.16,0,0,0,0,763.26,58.79,3694.62,248.22,7003.17,208.52,3679.53,80.14,6370.79,219.36,6019.21,1913.4,1.3,13389.42,216.85,13777.02,37.31],[0,0,0,0,256.22,1.3,563.3,18.88,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],[-0.07,-0.56,0.05,-0.3,0.31,0.4,0.22,0.14,0.22,-0.21,-0.04,-0.12,-0.47,-0.56,-0.04,-0.04,-0.3,-0.39,-0.36,0.22,0.4,-0.3,-0.3,-0.04,0.22],[-0.8,-1,-0.5,-0.9,0.2,0.1,0.3,0.4,-0.3,-0.8,-0.6,-0.7,-0.98,-1,-0.6,-0.6,-0.9,-0.95,-0.95,-0.3,-0.1,-0.9,-0.9,-0.6,-0.3],[7141.69,437.3,6399.5,327,3593,30,5306,109,6863,187,15013.2,828.37,12097,224,15972.93,335.09,15785,422.44,21125.94,14058,30,34096,501,53541.95,416.52]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-745fca8c5d9b7ec50e8e" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-745fca8c5d9b7ec50e8e">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2","IEM_Health-CovidProject"],[0.49,0.72,0.88,1.04,1.24,1.24,1.32,1.57],[150.44,221.84,271.84,321.71,188.24,384.31,408.33,486.71],[85.82,202.92,204.38,228.81,135.67,123.53,197.22,405.61],[0,0.03,67.45,0,52.56,260.78,0,0],[64.62,18.89,0,92.9,0,0,211.11,81.11],[-0.12,0.35,-0.08,-0.04,-0.11,-0.08,0.09,-0.04],[0.7,0.05,-0.65,0.6,-0.73,-0.65,0.45,0.6],[271.23,218.73,439.25,452.5,334.95,715,730.5,599.93]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-9ab85638e3726bfbe6f0" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-9ab85638e3726bfbe6f0">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2","IEM_Health-CovidProject"],[0.49,0.72,0.88,1.04,1.24,1.24,1.32,1.57],[150.44,221.84,271.84,321.71,188.24,384.31,408.33,486.71],[85.82,202.92,204.38,228.81,135.67,123.53,197.22,405.61],[0,0.03,67.45,0,52.56,260.78,0,0],[64.62,18.89,0,92.9,0,0,211.11,81.11],[-0.12,0.35,-0.08,-0.04,-0.11,-0.08,0.09,-0.04],[0.7,0.05,-0.65,0.6,-0.73,-0.65,0.45,0.6],[271.23,218.73,439.25,452.5,334.95,715,730.5,599.93]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-77ea7eab5d328e121a8d" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-77ea7eab5d328e121a8d">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","LANL-GrowthRate","USC-SIkJalpha","ILM-EKF","RobertWalraven-ESG","epiforecasts-EpiNow2","IEM_Health-CovidProject"],[0.48,0.72,0.86,1.04,1.23,1.24,1.34,1.57],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[289.65,435.27,515.21,625.28,743.26,749.72,810.16,946.06],[167.63,397.49,403.43,445.93,230.78,559.83,387.99,802.82],[0,0,111.78,0,512.48,189.89,0,0],[122.03,37.77,0,179.35,0,0,422.17,143.24],[-0.04,0.31,0.14,-0.04,-0.21,0.21,-0.21,0.22],[0.6,0.2,-0.4,0.6,-0.8,-0.5,0.8,0.3],[522.13,436.08,826.5,881,1385,1329.23,1460,1150.72]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-d1086b5bd79d301408e0" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-d1086b5bd79d301408e0">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","RobertWalraven-ESG","USC-SIkJalpha","ILM-EKF","IEM_Health-CovidProject","LANL-GrowthRate"],[0.41,0.53,0.71,1.1,1.15,1.61,1.74,1.81],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[6.5,8.41,11.23,17.35,18.14,25.36,27.37,28.47],[6.46,8.35,4.01,6.58,11.69,16.27,8.4,5.34],[0,0.06,0,10.77,0,9.09,0,23.13],[0.04,0,7.22,0,6.45,0,18.97,0],[0.4,0.4,-0.21,-0.21,-0.04,0.05,-0.3,-0.3],[0.1,-0.1,0.8,-0.8,0.6,-0.5,0.9,-0.9],[1,1.38,20.34,32.34,24,45,49.13,52]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-671084200176ee2a8500" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-671084200176ee2a8500">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","ILM-EKF","epiforecasts-EpiNow2","IEM_Health-CovidProject"],[0.49,0.72,0.88,1.04,1.24,1.24,1.32,1.57],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[150.44,221.84,271.84,321.71,188.24,384.31,408.33,486.71],[85.82,202.92,204.38,228.81,135.67,123.53,197.22,405.61],[0,0.03,67.45,0,52.56,260.78,0,0],[64.62,18.89,0,92.9,0,0,211.11,81.11],[-0.12,0.35,-0.08,-0.04,-0.11,-0.08,0.09,-0.04],[0.7,0.05,-0.65,0.6,-0.73,-0.65,0.45,0.6],[271.23,218.73,439.25,452.5,334.95,715,730.5,599.93]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-612d5e7e6351b457a58d" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-612d5e7e6351b457a58d">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","LANL-GrowthRate","LANL-GrowthRate","USC-SIkJalpha","USC-SIkJalpha","RobertWalraven-ESG","RobertWalraven-ESG","ILM-EKF","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiNow2","IEM_Health-CovidProject","IEM_Health-CovidProject"],[0.49,0.49,0.72,0.72,0.88,0.88,1.04,1.04,1.24,1.24,1.24,1.24,1.32,1.32,1.57,1.57],["PT","PT","PT","PT","PT","PT","PT","PT","PT","PT","PT","PT","PT","PT","PT","PT"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Portugal","Portugal","Portugal","Portugal","Portugal","Portugal","Portugal","Portugal","Portugal","Portugal","Portugal","Portugal","Portugal","Portugal","Portugal","Portugal"],[10293718,10293718,10293718,10293718,10293718,10293718,10293718,10293718,10293718,10293718,10293718,10293718,10293718,10293718,10293718,10293718],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[289.65,11.23,435.27,8.41,515.21,28.47,625.28,18.14,749.72,17.35,743.26,25.36,810.16,6.5,946.06,27.37],[167.63,4.01,397.49,8.35,403.43,5.34,445.93,11.69,559.83,6.58,230.78,16.27,387.99,6.46,802.82,8.4],[0,0,0,0.06,111.78,23.13,0,0,189.89,10.77,512.48,9.09,0,0,0,0],[122.03,7.22,37.77,0,0,0,179.35,6.45,0,0,0,0,422.17,0.04,143.24,18.97],[-0.04,-0.21,0.31,0.4,0.14,-0.3,-0.04,-0.04,0.21,-0.21,-0.21,0.05,-0.21,0.4,0.22,-0.3],[0.6,0.8,0.2,-0.1,-0.4,-0.9,0.6,0.6,-0.5,-0.8,-0.8,-0.5,0.8,0.1,0.3,0.9],[522.13,20.34,436.08,1.38,826.5,52,881,24,1329.23,32.34,1385,45,1460,1,1150.72,49.13]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-12d69ef4f36e5afbcfff" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-12d69ef4f36e5afbcfff">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","ILM-EKF","RobertWalraven-ESG","LANL-GrowthRate","epiforecasts-EpiNow2","IEM_Health-CovidProject","USC-SIkJalpha"],[0.76,0.81,0.89,0.91,0.96,0.96,1.07,2.02],[577.06,610.55,673.62,348.28,724.37,728.72,808.63,1525.4],[547.35,333.36,644.64,177.49,517.57,579.14,641.07,1358.13],[29.71,275.25,28.61,170.79,200.6,0,167.56,167.27],[0,1.93,0.37,0,6.2,149.58,0,0],[0.35,0.05,0.35,-0.45,0.01,0.01,0.14,0.31],[-0.15,-0.1,-0.05,-0.95,0.15,0.55,-0.4,-0.2],[444.47,1149.51,470.5,770.77,1215.75,1066.5,1235.57,1326]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-5a49a9c5b7466a9531c6" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-5a49a9c5b7466a9531c6">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","ILM-EKF","RobertWalraven-ESG","LANL-GrowthRate","epiforecasts-EpiNow2","IEM_Health-CovidProject","USC-SIkJalpha"],[0.76,0.81,0.89,0.91,0.96,0.96,1.07,2.02],[577.06,610.55,673.62,348.28,724.37,728.72,808.63,1525.4],[547.35,333.36,644.64,177.49,517.57,579.14,641.07,1358.13],[29.71,275.25,28.61,170.79,200.6,0,167.56,167.27],[0,1.93,0.37,0,6.2,149.58,0,0],[0.35,0.05,0.35,-0.45,0.01,0.01,0.14,0.31],[-0.15,-0.1,-0.05,-0.95,0.15,0.55,-0.4,-0.2],[444.47,1149.51,470.5,770.77,1215.75,1066.5,1235.57,1326]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-feacfa4a12083b4bfd06" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-feacfa4a12083b4bfd06">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","ILM-EKF","RobertWalraven-ESG","epiforecasts-EpiNow2","LANL-GrowthRate","IEM_Health-CovidProject","USC-SIkJalpha"],[0.77,0.82,0.88,0.91,0.96,0.97,1.06,2.05],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[1128.6,1203.4,1291.52,1335.84,1409.42,1427.43,1558.9,3025.13],[1069.61,652.89,1234.3,739.96,1142.85,1026.23,1247.3,2692.1],[58.98,550.51,57.22,595.87,0,401.2,311.6,333.03],[0,0,0,0,266.57,0,0,0],[0.31,-0.04,0.31,-0.07,0.22,0.14,0.22,0.31],[-0.2,-0.6,-0.2,-0.8,0.3,-0.4,-0.3,-0.2],[878.93,2272.38,924,3073.84,2047,2390.5,2361.44,2639]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-879f69e67bdd172f4d93" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-879f69e67bdd172f4d93">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","LANL-GrowthRate","EuroCOVIDhub-ensemble","USC-SIkJalpha","RobertWalraven-ESG","epiforecasts-EpiNow2","ILM-EKF","IEM_Health-CovidProject"],[0.52,0.62,0.75,0.75,1.4,1.41,1.63,1.71],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[17.7,21.31,25.52,25.68,47.71,48.02,55.73,58.36],[13.84,8.92,25.08,24.16,6.3,15.43,54.99,34.84],[0,0,0.44,1.52,41.41,0,0,23.52],[3.86,12.39,0,0,0,32.59,0.74,0],[0.14,-0.12,0.4,0.31,-0.56,-0.21,0.4,0.05],[0.4,0.7,-0.1,-0.2,-1,0.8,0.1,-0.5],[26.63,41,10.02,13,69.84,86,17,109.7]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-17233da9cba02e2dd490" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-17233da9cba02e2dd490">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","ILM-EKF","RobertWalraven-ESG","LANL-GrowthRate","epiforecasts-EpiNow2","IEM_Health-CovidProject","USC-SIkJalpha"],[0.76,0.81,0.89,0.91,0.96,0.96,1.07,2.02],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[577.06,610.55,673.62,348.28,724.37,728.72,808.63,1525.4],[547.35,333.36,644.64,177.49,517.57,579.14,641.07,1358.13],[29.71,275.25,28.61,170.79,200.6,0,167.56,167.27],[0,1.93,0.37,0,6.2,149.58,0,0],[0.35,0.05,0.35,-0.45,0.01,0.01,0.14,0.31],[-0.15,-0.1,-0.05,-0.95,0.15,0.55,-0.4,-0.2],[444.47,1149.51,470.5,770.77,1215.75,1066.5,1235.57,1326]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-91730532e51ac246d379" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-91730532e51ac246d379">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","epiforecasts-EpiExpert","ILM-EKF","ILM-EKF","RobertWalraven-ESG","RobertWalraven-ESG","LANL-GrowthRate","LANL-GrowthRate","epiforecasts-EpiNow2","epiforecasts-EpiNow2","IEM_Health-CovidProject","IEM_Health-CovidProject","USC-SIkJalpha","USC-SIkJalpha"],[0.76,0.76,0.81,0.81,0.89,0.89,0.91,0.91,0.96,0.96,0.96,0.96,1.07,1.07,2.02,2.02],["RO","RO","RO","RO","RO","RO","RO","RO","RO","RO","RO","RO","RO","RO","RO","RO"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Romania","Romania","Romania","Romania","Romania","Romania","Romania","Romania","Romania","Romania","Romania","Romania","Romania","Romania","Romania","Romania"],[19586539,19586539,19586539,19586539,19586539,19586539,19586539,19586539,19586539,19586539,19586539,19586539,19586539,19586539,19586539,19586539],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[1128.6,25.52,1203.4,17.7,1291.52,55.73,1335.84,47.71,1427.43,21.31,1409.42,48.02,1558.9,58.36,3025.13,25.68],[1069.61,25.08,652.89,13.84,1234.3,54.99,739.96,6.3,1026.23,8.92,1142.85,15.43,1247.3,34.84,2692.1,24.16],[58.98,0.44,550.51,0,57.22,0,595.87,41.41,401.2,0,0,0,311.6,23.52,333.03,1.52],[0,0,0,3.86,0,0.74,0,0,0,12.39,266.57,32.59,0,0,0,0],[0.31,0.4,-0.04,0.14,0.31,0.4,-0.07,-0.56,0.14,-0.12,0.22,-0.21,0.22,0.05,0.31,0.31],[-0.2,-0.1,-0.6,0.4,-0.2,0.1,-0.8,-1,-0.4,0.7,0.3,0.8,-0.3,-0.5,-0.2,-0.2],[878.93,10.02,2272.38,26.63,924,17,3073.84,69.84,2390.5,41,2047,86,2361.44,109.7,2639,13]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-f1bb91a7e00d74bbd080" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f1bb91a7e00d74bbd080">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","LANL-GrowthRate","epiforecasts-EpiNow2","IEM_Health-CovidProject","ILM-EKF","USC-SIkJalpha"],[0.53,0.85,0.86,0.91,1.02,1.09,1.25,2.05],[182.27,557.63,563.99,598.91,664.67,712.89,815.24,1341.84],[96.23,99.48,385.65,586.28,326.92,698.86,423.5,279.69],[22.8,4.81,1.13,10.22,0.01,0.59,0.17,0.16],[63.24,453.33,177.21,2.41,337.74,13.43,391.57,1061.99],[-0.25,-0.25,0.18,0.05,0.14,0.35,0.18,-0.12],[-0.5,0.19,0.15,-0.4,0.3,-0.05,0.25,0.4],[401.43,871,973.01,83.5,1220.25,320.01,1461,1630.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-cfa4429ea423cba109f1" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-cfa4429ea423cba109f1">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","LANL-GrowthRate","epiforecasts-EpiNow2","IEM_Health-CovidProject","ILM-EKF","USC-SIkJalpha"],[0.53,0.85,0.86,0.91,1.02,1.09,1.25,2.05],[182.27,557.63,563.99,598.91,664.67,712.89,815.24,1341.84],[96.23,99.48,385.65,586.28,326.92,698.86,423.5,279.69],[22.8,4.81,1.13,10.22,0.01,0.59,0.17,0.16],[63.24,453.33,177.21,2.41,337.74,13.43,391.57,1061.99],[-0.25,-0.25,0.18,0.05,0.14,0.35,0.18,-0.12],[-0.5,0.19,0.15,-0.4,0.3,-0.05,0.25,0.4],[401.43,871,973.01,83.5,1220.25,320.01,1461,1630.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-e05d37a7e38414f00858" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e05d37a7e38414f00858">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","LANL-GrowthRate","epiforecasts-EpiNow2","IEM_Health-CovidProject","ILM-EKF","USC-SIkJalpha"],[0.51,0.86,0.86,0.91,1.03,1.09,1.23,2.09],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[651.74,1095.72,1101.54,1165.75,1315.4,1394.46,1572.9,2668.49],[380.72,189.05,747.11,1160.92,639.92,1367.59,789.77,544.51],[0,0,0,0,0,0,0,0],[271.03,906.67,354.42,4.83,675.48,26.87,783.13,2123.98],[-0.07,-0.47,0.05,0.4,-0.12,0.4,-0.04,-0.56],[0.8,0.98,0.5,0.1,0.7,0.1,0.6,1],[1498.54,1705,1919,111,2440,617.96,2914,3258]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-51ea843cd72ac01b8bc4" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-51ea843cd72ac01b8bc4">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiNow2","USC-SIkJalpha","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","LANL-GrowthRate","RobertWalraven-ESG","ILM-EKF"],[0.52,0.57,0.73,0.99,1.18,1.21,1.48,2.17],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[13.95,15.18,19.53,26.44,31.31,32.08,39.39,57.58],[13.93,14.87,9.91,24.18,30.14,11.64,9.65,57.23],[0.02,0.31,9.62,2.26,1.17,20.43,29.74,0.35],[0,0,0,0,0,0,0,0],[0.4,0.31,-0.04,0.31,0.31,-0.3,-0.3,0.4],[-0.1,-0.2,-0.6,-0.2,-0.2,-0.9,-0.9,-0.1],[0.5,3,37,27.02,22.05,56,67.53,8]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-8cb5d4d46003bc6304b0" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-8cb5d4d46003bc6304b0">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","LANL-GrowthRate","epiforecasts-EpiNow2","IEM_Health-CovidProject","ILM-EKF","USC-SIkJalpha"],[0.53,0.85,0.86,0.91,1.02,1.09,1.25,2.05],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[182.27,557.63,563.99,598.91,664.67,712.89,815.24,1341.84],[96.23,99.48,385.65,586.28,326.92,698.86,423.5,279.69],[22.8,4.81,1.13,10.22,0.01,0.59,0.17,0.16],[63.24,453.33,177.21,2.41,337.74,13.43,391.57,1061.99],[-0.25,-0.25,0.18,0.05,0.14,0.35,0.18,-0.12],[-0.5,0.19,0.15,-0.4,0.3,-0.05,0.25,0.4],[401.43,871,973.01,83.5,1220.25,320.01,1461,1630.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-549f98cc559bb0438cff" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-549f98cc559bb0438cff">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["RobertWalraven-ESG","RobertWalraven-ESG","epiforecasts-EpiExpert","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","LANL-GrowthRate","LANL-GrowthRate","epiforecasts-EpiNow2","epiforecasts-EpiNow2","IEM_Health-CovidProject","IEM_Health-CovidProject","ILM-EKF","ILM-EKF","USC-SIkJalpha","USC-SIkJalpha"],[0.53,0.53,0.85,0.85,0.86,0.86,0.91,0.91,1.02,1.02,1.09,1.09,1.25,1.25,2.05,2.05],["SK","SK","SK","SK","SK","SK","SK","SK","SK","SK","SK","SK","SK","SK","SK","SK"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia","Slovakia"],[5439892,5439892,5439892,5439892,5439892,5439892,5439892,5439892,5439892,5439892,5439892,5439892,5439892,5439892,5439892,5439892],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[651.74,39.39,1095.72,19.53,1101.54,26.44,1165.75,32.08,1315.4,13.95,1394.46,31.31,1572.9,57.58,2668.49,15.18],[380.72,9.65,189.05,9.91,747.11,24.18,1160.92,11.64,639.92,13.93,1367.59,30.14,789.77,57.23,544.51,14.87],[0,29.74,0,9.62,0,2.26,0,20.43,0,0.02,0,1.17,0,0.35,0,0.31],[271.03,0,906.67,0,354.42,0,4.83,0,675.48,0,26.87,0,783.13,0,2123.98,0],[-0.07,-0.3,-0.47,-0.04,0.05,0.31,0.4,-0.3,-0.12,0.4,0.4,0.31,-0.04,0.4,-0.56,0.31],[0.8,-0.9,0.98,-0.6,0.5,-0.2,0.1,-0.9,0.7,-0.1,0.1,-0.2,0.6,-0.1,1,-0.2],[1498.54,67.53,1705,37,1919,27.02,111,56,2440,0.5,617.96,22.05,2914,8,3258,3]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-92035a747f684efe6cee" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-92035a747f684efe6cee">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","ILM-EKF","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","USC-SIkJalpha"],[0.61,0.72,0.73,0.8,1.21,1.34,1.55,1.59],[58.19,144.24,146.18,160.94,243.22,270.07,311.94,320.19],[53.75,141.76,144.67,118.79,70.35,222,248.52,256.6],[0.06,2.46,0,0,0,48.07,63.42,0],[4.38,0.02,1.52,42.15,172.88,0,0,63.59],[0.29,0.4,0.35,-0.04,-0.17,0.14,0.22,0.05],[-0.04,-0,0.15,0.6,0.75,-0.4,-0.3,0.5],[31.74,57,34.12,251.5,422.43,392.5,477.03,498]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-79596e16c77bb663c45c" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-79596e16c77bb663c45c">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","ILM-EKF","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","USC-SIkJalpha"],[0.61,0.72,0.73,0.8,1.21,1.34,1.55,1.59],[58.19,144.24,146.18,160.94,243.22,270.07,311.94,320.19],[53.75,141.76,144.67,118.79,70.35,222,248.52,256.6],[0.06,2.46,0,0,0,48.07,63.42,0],[4.38,0.02,1.52,42.15,172.88,0,0,63.59],[0.29,0.4,0.35,-0.04,-0.17,0.14,0.22,0.05],[-0.04,-0,0.15,0.6,0.75,-0.4,-0.3,0.5],[31.74,57,34.12,251.5,422.43,392.5,477.03,498]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-8857e268078231d3a6b4" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-8857e268078231d3a6b4">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","ILM-EKF","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","USC-SIkJalpha"],[0.61,0.7,0.72,0.79,1.22,1.35,1.56,1.59],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[242.08,279.1,287.86,312.12,483.42,537.19,619.28,633.17],[223.32,274.19,285.05,233.68,138.89,442.04,492.79,510.08],[0,4.91,0,0,0,95.15,126.49,0],[18.76,0,2.81,78.43,344.52,0,0,123.09],[0.21,0.4,0.4,0.14,-0.3,0.22,0.14,0.22],[0.5,-0.1,0.1,0.4,0.9,-0.3,-0.4,0.3],[131.34,113,64.68,486,839.41,780,949.87,980]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-8a6a097b80113977932e" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-8a6a097b80113977932e">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","LANL-GrowthRate","epiforecasts-EpiExpert","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","USC-SIkJalpha","ILM-EKF","epiforecasts-EpiNow2"],[0.46,0.62,0.63,0.94,0.96,1.51,1.96,2.04],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[2.22,2.96,3.03,4.5,4.61,7.21,9.37,9.76],[2.15,1.96,1.8,4.29,4.26,3.11,9.33,3.89],[0.08,1,0,0,0.35,0,0,0],[0,0,1.23,0.22,0,4.1,0.04,5.87],[0.31,0.05,-0.04,0.31,0.31,-0.12,0.4,-0.21],[-0.2,-0.5,0.6,0.2,-0.2,0.7,0.1,0.8],[1.43,5,5.45,3.56,4.19,16,1,17]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-8e57482c9adf6644aca4" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-8e57482c9adf6644aca4">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["RobertWalraven-ESG","ILM-EKF","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiExpert","LANL-GrowthRate","IEM_Health-CovidProject","USC-SIkJalpha"],[0.61,0.72,0.73,0.8,1.21,1.34,1.55,1.59],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[58.19,144.24,146.18,160.94,243.22,270.07,311.94,320.19],[53.75,141.76,144.67,118.79,70.35,222,248.52,256.6],[0.06,2.46,0,0,0,48.07,63.42,0],[4.38,0.02,1.52,42.15,172.88,0,0,63.59],[0.29,0.4,0.35,-0.04,-0.17,0.14,0.22,0.05],[-0.04,-0,0.15,0.6,0.75,-0.4,-0.3,0.5],[31.74,57,34.12,251.5,422.43,392.5,477.03,498]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-7da47928f56ed3cb2785" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-7da47928f56ed3cb2785">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["RobertWalraven-ESG","RobertWalraven-ESG","ILM-EKF","ILM-EKF","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiNow2","epiforecasts-EpiExpert","epiforecasts-EpiExpert","LANL-GrowthRate","LANL-GrowthRate","IEM_Health-CovidProject","IEM_Health-CovidProject","USC-SIkJalpha","USC-SIkJalpha"],[0.61,0.61,0.72,0.72,0.73,0.73,0.8,0.8,1.21,1.21,1.34,1.34,1.55,1.55,1.59,1.59],["SI","SI","SI","SI","SI","SI","SI","SI","SI","SI","SI","SI","SI","SI","SI","SI"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia","Slovenia"],[2066748,2066748,2066748,2066748,2066748,2066748,2066748,2066748,2066748,2066748,2066748,2066748,2066748,2066748,2066748,2066748],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[242.08,2.22,279.1,9.37,287.86,4.5,312.12,9.76,483.42,3.03,537.19,2.96,619.28,4.61,633.17,7.21],[223.32,2.15,274.19,9.33,285.05,4.29,233.68,3.89,138.89,1.8,442.04,1.96,492.79,4.26,510.08,3.11],[0,0.08,4.91,0,0,0,0,0,0,0,95.15,1,126.49,0.35,0,0],[18.76,0,0,0.04,2.81,0.22,78.43,5.87,344.52,1.23,0,0,0,0,123.09,4.1],[0.21,0.31,0.4,0.4,0.4,0.31,0.14,-0.21,-0.3,-0.04,0.22,0.05,0.14,0.31,0.22,-0.12],[0.5,-0.2,-0.1,0.1,0.1,0.2,0.4,0.8,0.9,0.6,-0.3,-0.5,-0.4,-0.2,0.3,0.7],[131.34,1.43,113,1,64.68,3.56,486,17,839.41,5.45,780,5,949.87,4.19,980,16]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-98f6a0f495ff76625910" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-98f6a0f495ff76625910">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","USC-SIkJalpha","LANL-GrowthRate","ILM-EKF","RobertWalraven-ESG","epiforecasts-EpiExpert","IEM_Health-CovidProject","UNIPV-BayesINGARCHX"],[0.45,0.48,0.72,0.74,0.89,1.11,1.37,1.43,4.49],[1892.52,2016.4,3014.47,3133.87,3768.89,2238.51,5818.62,6043.24,36808.24],[1066.66,1919.71,368.81,1872.99,576.58,1112.78,1441.27,733.62,1225.79],[0,12.67,2601.2,1260.88,3186.98,1115.21,0,5164.8,0],[825.86,84.02,44.45,0,5.33,10.52,4377.35,144.82,35582.45],[-0.08,0.22,-0.17,0.05,-0.08,0.15,-0.47,-0.39,-0.56],[0.65,-0.1,-0.15,-0.5,-0.39,0.04,0.98,-0.04,1],[3385.59,1432.75,5240.5,5924.25,5775,6669.15,9471.06,9058.64,40110]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-43420b5e3960d5a42658" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-43420b5e3960d5a42658">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","USC-SIkJalpha","LANL-GrowthRate","ILM-EKF","RobertWalraven-ESG","epiforecasts-EpiExpert","IEM_Health-CovidProject","UNIPV-BayesINGARCHX"],[0.45,0.48,0.72,0.74,0.89,1.11,1.37,1.43,4.49],[1892.52,2016.4,3014.47,3133.87,3768.89,2238.51,5818.62,6043.24,36808.24],[1066.66,1919.71,368.81,1872.99,576.58,1112.78,1441.27,733.62,1225.79],[0,12.67,2601.2,1260.88,3186.98,1115.21,0,5164.8,0],[825.86,84.02,44.45,0,5.33,10.52,4377.35,144.82,35582.45],[-0.08,0.22,-0.17,0.05,-0.08,0.15,-0.47,-0.39,-0.56],[0.65,-0.1,-0.15,-0.5,-0.39,0.04,0.98,-0.04,1],[3385.59,1432.75,5240.5,5924.25,5775,6669.15,9471.06,9058.64,40110]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-28c4d62b66f3bcd67cc7" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-28c4d62b66f3bcd67cc7">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","USC-SIkJalpha","LANL-GrowthRate","ILM-EKF","RobertWalraven-ESG","epiforecasts-EpiExpert","IEM_Health-CovidProject","UNIPV-BayesINGARCHX"],[0.44,0.48,0.72,0.76,0.91,1.12,1.33,1.42,4.49],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[3595.36,3946.02,5903.97,6219.1,7422.39,9214.68,10932.97,11652.19,36808.24],[2039.73,3777.98,701.56,3714.99,1048.43,4435.21,2827.1,1322.58,1225.79],[0,0,5202.41,2504.11,6373.96,4779.47,0,10329.61,0],[1555.64,168.04,0,0,0,0,8105.88,0,35582.45],[-0.04,0.31,-0.3,0.05,-0.47,-0.07,-0.39,-0.47,-0.56],[0.6,0.2,-0.9,-0.5,-0.98,-0.8,0.95,-0.98,1],[6420.87,2723,10260,11770.5,11431,28137.38,18066.11,17353.53,40110]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-7e190f4393e00de9cbd2" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-7e190f4393e00de9cbd2">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","epiforecasts-EpiNow2","RobertWalraven-ESG","ILM-EKF","USC-SIkJalpha","EuroCOVIDhub-ensemble","IEM_Health-CovidProject","epiforecasts-EpiExpert"],[0.31,0.55,0.73,0.73,0.79,1.19,2.73,4.43],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[48.64,86.78,115.33,115.39,124.97,189.67,434.29,704.26],[30.99,61.43,101.61,104.74,36.06,93.59,144.66,55.44],[17.65,25.35,0,0,0,0,0,0],[0,0,13.73,10.65,88.9,96.08,289.63,648.82],[0.05,0.14,0.22,0.31,-0.04,-0.12,-0.3,-0.56],[-0.5,-0.4,0.3,0.2,0.6,0.7,0.9,1],[78,142.5,135.34,119,221,350.31,763.75,876]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-c721649800294d3dfd62" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-c721649800294d3dfd62">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","USC-SIkJalpha","LANL-GrowthRate","ILM-EKF","RobertWalraven-ESG","epiforecasts-EpiExpert","IEM_Health-CovidProject","UNIPV-BayesINGARCHX"],[0.45,0.48,0.72,0.74,0.89,1.11,1.37,1.43,4.49],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[1892.52,2016.4,3014.47,3133.87,3768.89,2238.51,5818.62,6043.24,36808.24],[1066.66,1919.71,368.81,1872.99,576.58,1112.78,1441.27,733.62,1225.79],[0,12.67,2601.2,1260.88,3186.98,1115.21,0,5164.8,0],[825.86,84.02,44.45,0,5.33,10.52,4377.35,144.82,35582.45],[-0.08,0.22,-0.17,0.05,-0.08,0.15,-0.47,-0.39,-0.56],[0.65,-0.1,-0.15,-0.5,-0.39,0.04,0.98,-0.04,1],[3385.59,1432.75,5240.5,5924.25,5775,6669.15,9471.06,9058.64,40110]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-36ffd2c95a83cfd35feb" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-36ffd2c95a83cfd35feb">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"],["EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","epiforecasts-EpiNow2","epiforecasts-EpiNow2","USC-SIkJalpha","USC-SIkJalpha","LANL-GrowthRate","LANL-GrowthRate","ILM-EKF","ILM-EKF","RobertWalraven-ESG","RobertWalraven-ESG","epiforecasts-EpiExpert","epiforecasts-EpiExpert","IEM_Health-CovidProject","IEM_Health-CovidProject","UNIPV-BayesINGARCHX"],[0.45,0.45,0.48,0.48,0.72,0.72,0.74,0.74,0.89,0.89,1.11,1.11,1.37,1.37,1.43,1.43,4.49],["ES","ES","ES","ES","ES","ES","ES","ES","ES","ES","ES","ES","ES","ES","ES","ES","ES"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Spain","Spain","Spain","Spain","Spain","Spain","Spain","Spain","Spain","Spain","Spain","Spain","Spain","Spain","Spain","Spain","Spain"],[46572028,46572028,46572028,46572028,46572028,46572028,46572028,46572028,46572028,46572028,46572028,46572028,46572028,46572028,46572028,46572028,46572028],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[3595.36,189.67,3946.02,86.78,5903.97,124.97,6219.1,48.64,7422.39,115.39,9214.68,115.33,10932.97,704.26,11652.19,434.29,36808.24],[2039.73,93.59,3777.98,61.43,701.56,36.06,3714.99,30.99,1048.43,104.74,4435.21,101.61,2827.1,55.44,1322.58,144.66,1225.79],[0,0,0,25.35,5202.41,0,2504.11,17.65,6373.96,0,4779.47,0,0,0,10329.61,0,0],[1555.64,96.08,168.04,0,0,88.9,0,0,0,10.65,0,13.73,8105.88,648.82,0,289.63,35582.45],[-0.04,-0.12,0.31,0.14,-0.3,-0.04,0.05,0.05,-0.47,0.31,-0.07,0.22,-0.39,-0.56,-0.47,-0.3,-0.56],[0.6,0.7,0.2,-0.4,-0.9,0.6,-0.5,-0.5,-0.98,0.2,-0.8,0.3,0.95,1,-0.98,0.9,1],[6420.87,350.31,2723,142.5,10260,221,11770.5,78,11431,119,28137.38,135.34,18066.11,876,17353.53,763.75,40110]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-a8d40c5219bc887a8249" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-a8d40c5219bc887a8249">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","ILM-EKF","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","RobertWalraven-ESG","LANL-GrowthRate","USC-SIkJalpha","epiforecasts-EpiNow2"],[0.35,0.76,0.8,0.84,1.1,1.19,1.62,2.64],[456.75,996.24,1049.73,1099.58,679.85,1551.47,2116.78,3457.67],[183.52,656.76,581.86,850.14,549.4,1323.14,1154.6,1980.93],[0,0,467.88,0,130.45,217.48,961.88,0],[273.23,339.48,0,249.44,0,10.85,0.3,1476.74],[-0.3,0.14,0.01,0.22,0.15,-0.04,0.14,-0.17],[0.84,0.4,-0.55,0.3,-0.42,0.3,-0.2,0.75],[844.47,1724,1906.83,1644.83,908.6,2043.5,4664,5955.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-30b47f931f3f34ad2207" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-30b47f931f3f34ad2207">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","ILM-EKF","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","RobertWalraven-ESG","LANL-GrowthRate","USC-SIkJalpha","epiforecasts-EpiNow2"],[0.35,0.76,0.8,0.84,1.1,1.19,1.62,2.64],[456.75,996.24,1049.73,1099.58,679.85,1551.47,2116.78,3457.67],[183.52,656.76,581.86,850.14,549.4,1323.14,1154.6,1980.93],[0,0,467.88,0,130.45,217.48,961.88,0],[273.23,339.48,0,249.44,0,10.85,0.3,1476.74],[-0.3,0.14,0.01,0.22,0.15,-0.04,0.14,-0.17],[0.84,0.4,-0.55,0.3,-0.42,0.3,-0.2,0.75],[844.47,1724,1906.83,1644.83,908.6,2043.5,4664,5955.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-e5abb85fc2dd797dfbf5" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e5abb85fc2dd797dfbf5">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","ILM-EKF","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","RobertWalraven-ESG","LANL-GrowthRate","USC-SIkJalpha","epiforecasts-EpiNow2"],[0.34,0.76,0.8,0.84,1.1,1.19,1.63,2.65],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[886.61,1964.29,2067.63,2180.12,2843.58,3074.06,4214.77,6846.92],[361.98,1288.64,1145.56,1682.79,2303.9,2639.1,2291.01,3937.96],[0,0,922.06,0,539.68,434.96,1923.77,0],[524.63,675.65,0,497.33,0,0,0,2908.96],[-0.12,0.05,-0.04,0.14,0.21,0.22,-0.04,-0.04],[0.7,0.5,-0.6,0.4,-0.5,-0.3,-0.6,0.6],[1647.05,3416,3750.83,3271.54,3777.78,4038,9320,11796]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-9a473b180d10f4b0df6a" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-9a473b180d10f4b0df6a">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["USC-SIkJalpha","EuroCOVIDhub-ensemble","RobertWalraven-ESG","epiforecasts-EpiExpert","ILM-EKF","LANL-GrowthRate","IEM_Health-CovidProject","epiforecasts-EpiNow2"],[0.67,0.68,0.77,0.97,1.01,1.04,1.14,2.46],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[18.79,19.04,21.32,26.9,28.18,28.88,31.84,68.42],[18.2,17.48,15.42,5.06,24.87,7.19,18.15,23.9],[0,0,5.9,0,0,0,13.69,0],[0.59,1.56,0,21.84,3.3,21.7,0,44.53],[0.31,0.31,0.14,-0.47,0.22,-0.3,0.05,-0.3],[0.2,0.2,-0.4,0.98,0.3,0.9,-0.5,0.9],[8,18.11,35.37,41.9,32,49,62.84,115]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-6682e5b9eee940c76502" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-6682e5b9eee940c76502">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","ILM-EKF","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","RobertWalraven-ESG","LANL-GrowthRate","USC-SIkJalpha","epiforecasts-EpiNow2"],[0.35,0.76,0.8,0.84,1.1,1.19,1.62,2.64],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[456.75,996.24,1049.73,1099.58,679.85,1551.47,2116.78,3457.67],[183.52,656.76,581.86,850.14,549.4,1323.14,1154.6,1980.93],[0,0,467.88,0,130.45,217.48,961.88,0],[273.23,339.48,0,249.44,0,10.85,0.3,1476.74],[-0.3,0.14,0.01,0.22,0.15,-0.04,0.14,-0.17],[0.84,0.4,-0.55,0.3,-0.42,0.3,-0.2,0.75],[844.47,1724,1906.83,1644.83,908.6,2043.5,4664,5955.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-21f75cbeae0a2e1d49f5" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-21f75cbeae0a2e1d49f5">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","ILM-EKF","ILM-EKF","IEM_Health-CovidProject","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","RobertWalraven-ESG","RobertWalraven-ESG","LANL-GrowthRate","LANL-GrowthRate","USC-SIkJalpha","USC-SIkJalpha","epiforecasts-EpiNow2","epiforecasts-EpiNow2"],[0.35,0.35,0.76,0.76,0.8,0.8,0.84,0.84,1.1,1.1,1.19,1.19,1.62,1.62,2.64,2.64],["SE","SE","SE","SE","SE","SE","SE","SE","SE","SE","SE","SE","SE","SE","SE","SE"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Sweden","Sweden","Sweden","Sweden","Sweden","Sweden","Sweden","Sweden","Sweden","Sweden","Sweden","Sweden","Sweden","Sweden","Sweden","Sweden"],[10067744,10067744,10067744,10067744,10067744,10067744,10067744,10067744,10067744,10067744,10067744,10067744,10067744,10067744,10067744,10067744],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[886.61,26.9,1964.29,28.18,2067.63,31.84,2180.12,19.04,2843.58,21.32,3074.06,28.88,4214.77,18.79,6846.92,68.42],[361.98,5.06,1288.64,24.87,1145.56,18.15,1682.79,17.48,2303.9,15.42,2639.1,7.19,2291.01,18.2,3937.96,23.9],[0,0,0,0,922.06,13.69,0,0,539.68,5.9,434.96,0,1923.77,0,0,0],[524.63,21.84,675.65,3.3,0,0,497.33,1.56,0,0,0,21.7,0,0.59,2908.96,44.53],[-0.12,-0.47,0.05,0.22,-0.04,0.05,0.14,0.31,0.21,0.14,0.22,-0.3,-0.04,0.31,-0.04,-0.3],[0.7,0.98,0.5,0.3,-0.6,-0.5,0.4,0.2,-0.5,-0.4,-0.3,0.9,-0.6,0.2,0.6,0.9],[1647.05,41.9,3416,32,3750.83,62.84,3271.54,18.11,3777.78,35.37,4038,49,9320,8,11796,115]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-e71995c0b66c892b99ff" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e71995c0b66c892b99ff">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","IEM_Health-CovidProject"],[0.44,0.59,0.86,0.95,1.06,1.27,1.46,2.37],[221.79,294.73,428.89,472.62,530.04,631.45,347.34,1182.53],[101.44,277.52,191.52,222.27,307.9,173.98,224.21,163.24],[116.83,13.04,237.01,250.35,221.05,456.89,120.4,1019.29],[3.52,4.16,0.36,0,1.09,0.58,2.73,0],[-0.17,0.09,0.09,0.18,0.05,0.01,0.09,-0.17],[0.05,0.25,-0.25,-0.35,0,-0.15,0.12,-0.69],[425.03,244,840.18,908,1006.75,1222,834.21,1799.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-73f14639bfc936dba06c" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-73f14639bfc936dba06c">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","IEM_Health-CovidProject"],[0.44,0.59,0.86,0.95,1.06,1.27,1.46,2.37],[221.79,294.73,428.89,472.62,530.04,631.45,347.34,1182.53],[101.44,277.52,191.52,222.27,307.9,173.98,224.21,163.24],[116.83,13.04,237.01,250.35,221.05,456.89,120.4,1019.29],[3.52,4.16,0.36,0,1.09,0.58,2.73,0],[-0.17,0.09,0.09,0.18,0.05,0.01,0.09,-0.17],[0.05,0.25,-0.25,-0.35,0,-0.15,0.12,-0.69],[425.03,244,840.18,908,1006.75,1222,834.21,1799.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-6b2917124c80dd4927ff" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-6b2917124c80dd4927ff">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","IEM_Health-CovidProject"],[0.44,0.58,0.86,0.95,1.07,1.28,1.46,2.39],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[432.96,573.9,848.83,934.15,1054.69,1257.13,1439.45,2353.53],[199.3,547.81,374.8,433.71,612.59,343.36,923.46,318.36],[233.66,26.09,474.03,500.43,442.1,913.77,515.99,2035.17],[0,0,0,0,0,0,0,0],[-0.12,0.31,-0.12,-0.04,0.05,-0.12,-0.07,-0.47],[-0.7,-0.2,-0.7,-0.6,-0.5,-0.7,-0.8,-0.98],[831.32,460,1671.62,1810,2003.5,2437,3498.15,3578.59]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-521a3f231ac93bf64655" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-521a3f231ac93bf64655">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","USC-SIkJalpha","EuroCOVIDhub-ensemble","epiforecasts-EpiExpert","ILM-EKF","IEM_Health-CovidProject","RobertWalraven-ESG","epiforecasts-EpiNow2"],[0.55,0.59,0.91,1.08,1.13,1.17,1.52,1.58],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[5.39,5.77,8.95,10.61,11.09,11.52,14.96,15.56],[3.21,4.6,8.23,3.58,10.83,8.11,11.4,7.24],[0,0,0,0,0.26,3.41,0,0],[2.17,1.17,0.71,7.03,0,0,3.56,8.33],[0.05,0.14,0.31,-0.21,0.4,0.14,0.14,-0.12],[0.5,0.4,0.2,0.8,-0.1,-0.4,0.4,0.7],[10,7,8.75,18.74,6,20.4,23.45,28]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-bb9b8479fd0e825f8d6b" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-bb9b8479fd0e825f8d6b">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["epiforecasts-EpiExpert","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","ILM-EKF","LANL-GrowthRate","USC-SIkJalpha","RobertWalraven-ESG","IEM_Health-CovidProject"],[0.44,0.59,0.86,0.95,1.06,1.27,1.46,2.37],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[221.79,294.73,428.89,472.62,530.04,631.45,347.34,1182.53],[101.44,277.52,191.52,222.27,307.9,173.98,224.21,163.24],[116.83,13.04,237.01,250.35,221.05,456.89,120.4,1019.29],[3.52,4.16,0.36,0,1.09,0.58,2.73,0],[-0.17,0.09,0.09,0.18,0.05,0.01,0.09,-0.17],[0.05,0.25,-0.25,-0.35,0,-0.15,0.12,-0.69],[425.03,244,840.18,908,1006.75,1222,834.21,1799.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-3ba5c066f5613d1e0e91" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-3ba5c066f5613d1e0e91">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"],["epiforecasts-EpiExpert","epiforecasts-EpiExpert","epiforecasts-EpiNow2","epiforecasts-EpiNow2","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","ILM-EKF","ILM-EKF","LANL-GrowthRate","LANL-GrowthRate","USC-SIkJalpha","USC-SIkJalpha","RobertWalraven-ESG","RobertWalraven-ESG","IEM_Health-CovidProject","IEM_Health-CovidProject"],[0.44,0.44,0.59,0.59,0.86,0.86,0.95,0.95,1.06,1.06,1.27,1.27,1.46,1.46,2.37,2.37],["CH","CH","CH","CH","CH","CH","CH","CH","CH","CH","CH","CH","CH","CH","CH","CH"],["inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland","Switzerland"],[8466017,8466017,8466017,8466017,8466017,8466017,8466017,8466017,8466017,8466017,8466017,8466017,8466017,8466017,8466017,8466017],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[432.96,10.61,573.9,15.56,848.83,8.95,934.15,11.09,1054.69,5.39,1257.13,5.77,1439.45,14.96,2353.53,11.52],[199.3,3.58,547.81,7.24,374.8,8.23,433.71,10.83,612.59,3.21,343.36,4.6,923.46,11.4,318.36,8.11],[233.66,0,26.09,0,474.03,0,500.43,0.26,442.1,0,913.77,0,515.99,0,2035.17,3.41],[0,7.03,0,8.33,0,0.71,0,0,0,2.17,0,1.17,0,3.56,0,0],[-0.12,-0.21,0.31,-0.12,-0.12,0.31,-0.04,0.4,0.05,0.05,-0.12,0.14,-0.07,0.14,-0.47,0.14],[-0.7,0.8,-0.2,0.7,-0.7,0.2,-0.6,-0.1,-0.5,0.5,-0.7,0.4,-0.8,0.4,-0.98,-0.4],[831.32,18.74,460,28,1671.62,8.75,1810,6,2003.5,10,2437,7,3498.15,23.45,3578.59,20.4]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall

<div id="htmlwidget-861933c38589fef73ac5" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-861933c38589fef73ac5">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["USC-SIkJalpha","UVA-Ensemble","epiforecasts-EpiExpert","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","LANL-GrowthRate","ILM-EKF","epiforecasts-EpiNow2"],[0.46,0.52,0.82,0.93,1.02,1.23,1.36,1.8,1.82],[937.48,1921.15,1652.43,948.14,2040.96,2452.65,2705.42,3578.88,3637.06],[567.92,1423.22,408.21,505,1258.34,738,508.97,849.23,442.33],[143.23,0,1103.47,443.15,759.76,1694.76,2176.08,2708.43,3067.15],[226.33,497.93,140.75,0,22.86,19.89,20.37,21.22,127.58],[-0.17,0.21,-0.43,-0.11,0.14,-0.08,-0.34,-0.12,-0.56],[0.35,0.5,0.05,-0.72,-0.1,-0.15,-0.02,-0.2,0],[1278,3485.5,2855.56,2134.79,3701.5,4462.63,4464.75,6234,5302.75]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### latest

<div id="htmlwidget-0fa9e4ff6e310e538a5e" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-0fa9e4ff6e310e538a5e">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["USC-SIkJalpha","UVA-Ensemble","epiforecasts-EpiExpert","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","LANL-GrowthRate","ILM-EKF","epiforecasts-EpiNow2"],[0.46,0.52,0.82,0.93,1.02,1.23,1.36,1.8,1.82],[937.48,1921.15,1652.43,948.14,2040.96,2452.65,2705.42,3578.88,3637.06],[567.92,1423.22,408.21,505,1258.34,738,508.97,849.23,442.33],[143.23,0,1103.47,443.15,759.76,1694.76,2176.08,2708.43,3067.15],[226.33,497.93,140.75,0,22.86,19.89,20.37,21.22,127.58],[-0.17,0.21,-0.43,-0.11,0.14,-0.08,-0.34,-0.12,-0.56],[0.35,0.5,0.05,-0.72,-0.1,-0.15,-0.02,-0.2,0],[1278,3485.5,2855.56,2134.79,3701.5,4462.63,4464.75,6234,5302.75]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,3,4,5,6,7,8,9]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

### Cases

<div id="htmlwidget-1fb8322f80b0cfeac3ea" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1fb8322f80b0cfeac3ea">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["USC-SIkJalpha","UVA-Ensemble","epiforecasts-EpiExpert","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","LANL-GrowthRate","epiforecasts-EpiNow2","ILM-EKF"],[0.38,0.52,0.81,0.96,1.02,1.28,1.44,1.88,1.89],["inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case","inc case"],[1399.73,1921.15,3000.02,3570.49,3806.72,4779.85,5357.71,6992.54,7036.1],[1113.27,1423.22,793.07,1935.35,2287.2,1390.34,1005.55,858.24,1619.23],[286.46,0,2206.95,1635.15,1519.52,3389.51,4352.16,6134.3,5416.87],[0,497.93,0,0,0,0,0,0,0],[0.22,0.21,-0.3,-0.07,0.05,-0.21,-0.39,-0.56,-0.3],[-0.3,0.5,-0.9,-0.8,-0.5,-0.8,-0.95,-1,-0.9],[1986,3485.5,5330.57,8218.37,7039.98,8716.39,8840.5,10229,12260]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Deaths

<div id="htmlwidget-f8b1da5a16b4dec1e32b" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-f8b1da5a16b4dec1e32b">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8"],["LANL-GrowthRate","ILM-EKF","EuroCOVIDhub-ensemble","RobertWalraven-ESG","IEM_Health-CovidProject","epiforecasts-EpiNow2","epiforecasts-EpiExpert","USC-SIkJalpha"],[0.29,0.66,0.68,0.81,1.49,1.52,1.65,2.57],["inc death","inc death","inc death","inc death","inc death","inc death","inc death","inc death"],[53.13,121.67,125.44,150.04,275.2,281.58,304.85,475.23],[12.4,79.23,85.66,69.67,229.48,26.43,23.35,22.57],[0,0,0,80.37,0,0,0,0],[40.74,42.43,39.78,0,45.73,255.16,281.5,452.66],[-0.3,0.05,0.05,-0.12,0.22,-0.56,-0.56,-0.56],[0.9,0.5,0.5,-0.7,0.3,1,1,1],[89,208,208.87,283.26,363.01,376.5,380.55,570]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>target_variable<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### overall by horizon

<div id="htmlwidget-67e3b4f2d60994c9b0b3" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-67e3b4f2d60994c9b0b3">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9"],["USC-SIkJalpha","UVA-Ensemble","epiforecasts-EpiExpert","RobertWalraven-ESG","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","LANL-GrowthRate","ILM-EKF","epiforecasts-EpiNow2"],[0.46,0.52,0.82,0.93,1.02,1.23,1.36,1.8,1.82],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],[937.48,1921.15,1652.43,948.14,2040.96,2452.65,2705.42,3578.88,3637.06],[567.92,1423.22,408.21,505,1258.34,738,508.97,849.23,442.33],[143.23,0,1103.47,443.15,759.76,1694.76,2176.08,2708.43,3067.15],[226.33,497.93,140.75,0,22.86,19.89,20.37,21.22,127.58],[-0.17,0.21,-0.43,-0.11,0.14,-0.08,-0.34,-0.12,-0.56],[0.35,0.5,0.05,-0.72,-0.1,-0.15,-0.02,-0.2,0],[1278,3485.5,2855.56,2134.79,3701.5,4462.63,4464.75,6234,5302.75]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>horizon<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,4,5,6,7,8,9,10]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

### Detailed

<div id="htmlwidget-e6f102fa888b3a3ceffd" style="width:100%;height:500px;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-e6f102fa888b3a3ceffd">{"x":{"filter":"none","extensions":["FixedColumns","Buttons"],"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"],["USC-SIkJalpha","USC-SIkJalpha","UVA-Ensemble","epiforecasts-EpiExpert","epiforecasts-EpiExpert","RobertWalraven-ESG","RobertWalraven-ESG","IEM_Health-CovidProject","IEM_Health-CovidProject","EuroCOVIDhub-ensemble","EuroCOVIDhub-ensemble","LANL-GrowthRate","LANL-GrowthRate","ILM-EKF","ILM-EKF","epiforecasts-EpiNow2","epiforecasts-EpiNow2"],[0.46,0.46,0.52,0.82,0.82,0.93,0.93,1.02,1.02,1.23,1.23,1.36,1.36,1.8,1.8,1.82,1.82],["GB","GB","GB","GB","GB","GB","GB","GB","GB","GB","GB","GB","GB","GB","GB","GB","GB"],["inc case","inc death","inc case","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death","inc case","inc death"],["2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13","2021-03-13"],["United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom","United Kingdom"],[66022273,66022273,66022273,66022273,66022273,66022273,66022273,66022273,66022273,66022273,66022273,66022273,66022273,66022273,66022273,66022273,66022273],["2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08","2021-03-08"],["horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1","horizon 1"],["wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk","wk"],["quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile","quantile"],[1399.73,475.23,1921.15,3000.02,304.85,3570.49,150.04,3806.72,275.2,4779.85,125.44,5357.71,53.13,7036.1,121.67,6992.54,281.58],[1113.27,22.57,1423.22,793.07,23.35,1935.35,69.67,2287.2,229.48,1390.34,85.66,1005.55,12.4,1619.23,79.23,858.24,26.43],[286.46,0,0,2206.95,0,1635.15,80.37,1519.52,0,3389.51,0,4352.16,0,5416.87,0,6134.3,0],[0,452.66,497.93,0,281.5,0,0,0,45.73,0,39.78,0,40.74,0,42.43,0,255.16],[0.22,-0.56,0.21,-0.3,-0.56,-0.07,-0.12,0.05,0.22,-0.21,0.05,-0.39,-0.3,-0.3,0.05,-0.56,-0.56],[-0.3,1,0.5,-0.9,1,-0.8,-0.7,-0.5,0.3,-0.8,0.5,-0.95,0.9,-0.9,0.5,-1,1],[1986,570,3485.5,5330.57,380.55,8218.37,283.26,7039.98,363.01,8716.39,208.87,8840.5,89,12260,208,10229,376.5]],"container":"<table class=\"white-space: nowrap\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>model<\/th>\n      <th>rel_skill<\/th>\n      <th>location<\/th>\n      <th>target_variable<\/th>\n      <th>target_end_date<\/th>\n      <th>location_name<\/th>\n      <th>population<\/th>\n      <th>forecast_date<\/th>\n      <th>horizon<\/th>\n      <th>temporal_resolution<\/th>\n      <th>type<\/th>\n      <th>wis<\/th>\n      <th>sharpness<\/th>\n      <th>underpred<\/th>\n      <th>overpred<\/th>\n      <th>cvrage_dev<\/th>\n      <th>bias<\/th>\n      <th>aem<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"pageLength":10,"buttons":["csv","excel"],"dom":"Bfrtip","scrollX":true,"fixedColumns":true,"columnDefs":[{"className":"dt-right","targets":[2,7,12,13,14,15,16,17,18]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>

TRUE

# 

------------------------------------------------------------------------

# Evaluation metrics

-   Relative skill is a metric based on the weighted interval score
    (WIS) that is using a ‘pairwise comparison tournament’. All pairs of
    forecasters are compared against each other in terms of the weighted
    interval score. The mean score of both models based on the set of
    common targets for which both models have made a prediction are
    calculated to obtain mean score ratios. The relative skill is the
    geometric mean of these mean score ratios. Smaller values are better
    and a value smaller than one means that the model beats the average
    forecasting model.
-   The weighted interval score is a proper scoring rule (meaning you
    can’t cheat it) suited to scoring forecasts in an interval format.
    It has three components: sharpness, underprediction and
    overprediction. Sharpness is the width of your prediction interval.
    Over- and underprediction only come into play if the prediction
    interval does not cover the true value. They are the absolute value
    of the difference between the upper or lower bound of your
    prediction interval (depending on whether your forecast is too high
    or too low).
-   coverage deviation is the average difference between nominal and
    empirical interval coverage. Say your 50 percent prediction interval
    covers only 20 percent of all true values, then your coverage
    deviation is 0.5 - 0.2 = -0.3. The coverage deviation value in the
    table is calculated by averaging over the coverage deviation
    calculated for all possible prediction intervals. If the value is
    negative you have covered less then you should. If it is positve,
    then your forecasts could be a little more confident.
-   bias is a measure between -1 and 1 that expresses your tendency to
    underpredict (-1) or overpredict (1). In contrast to the over- and
    underprediction components of the WIS it is bound between -1 and 1
    and cannot go to infinity. It is therefore less susceptible to
    outliers.
-   aem is the absolute error of your median forecasts. A high aem means
    your median forecasts tend to be far away from the true values.

# 

------------------------------------------------------------------------

# Forecast visualisation

This is a visualisation of all forecasts made so far.

# 

------------------------------------------------------------------------

# Scores over time

Here you can see a visualisation of forecaster scores over time. The
first tab shows the weighted interval score. Other tabs show the
components of the interval score, sharpness (how narrow are forecasts -
smaller is better), and penalties for underprediction and
overprediction.

## Austria

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-1.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-2.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-3.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-4.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-5.png)

## Belgium

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-6.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-7.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-8.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-9.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-10.png)

## Bulgaria

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-11.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-12.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-13.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-14.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-15.png)

## Croatia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-16.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-17.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-18.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-19.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-20.png)

## Cyprus

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-21.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-22.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-23.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-24.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-25.png)

## Czechia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-26.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-27.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-28.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-29.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-30.png)

## Denmark

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-31.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-32.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-33.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-34.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-35.png)

## Estonia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-36.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-37.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-38.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-39.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-40.png)

## Finland

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-41.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-42.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-43.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-44.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-45.png)

## France

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-46.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-47.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-48.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-49.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-50.png)

## Germany

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-51.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-52.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-53.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-54.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-55.png)

## Greece

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-56.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-57.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-58.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-59.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-60.png)

## Hungary

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-61.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-62.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-63.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-64.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-65.png)

## Iceland

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-66.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-67.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-68.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-69.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-70.png)

## Ireland

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-71.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-72.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-73.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-74.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-75.png)

## Italy

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-76.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-77.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-78.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-79.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-80.png)

## Latvia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-81.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-82.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-83.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-84.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-85.png)

## Liechtenstein

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-86.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-87.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-88.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-89.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-90.png)

## Lithuania

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-91.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-92.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-93.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-94.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-95.png)

## Luxembourg

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-96.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-97.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-98.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-99.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-100.png)

## Malta

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-101.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-102.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-103.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-104.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-105.png)

## Netherlands

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-106.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-107.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-108.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-109.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-110.png)

## Norway

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-111.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-112.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-113.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-114.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-115.png)

## Poland

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-116.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-117.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-118.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-119.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-120.png)

## Portugal

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-121.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-122.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-123.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-124.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-125.png)

## Romania

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-126.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-127.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-128.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-129.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-130.png)

## Slovakia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-131.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-132.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-133.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-134.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-135.png)

## Slovenia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-136.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-137.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-138.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-139.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-140.png)

## Spain

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-141.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-142.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-143.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-144.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-145.png)

## Sweden

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-146.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-147.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-148.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-149.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-150.png)

## Switzerland

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-151.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-152.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-153.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-154.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-155.png)

## United Kingdom

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-156.png)

### 

#### Weighted interval score

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-157.png)

#### Overprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-158.png)

#### Underprediction

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-159.png)

#### Sharpness

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/scores-and-truth1-160.png)

<!-- # {.unlisted .unnumbered} -->
<!--  -->
<!-- --- -->
<!-- # Ranks over time {.tabset .tabset-fade .tabset-dropdown} -->
<!-- This table shows you the model rank among all forecasting models, or alternatively a standardised rank. The standardised rank is computed as (100 - the forecast model percentile rank) among all models for a given target and forecast date. What happens is basically this: Every model gets assigned a rank (1 is the best and the worst equals the number of available forecasts for that date). This rank is then transformed to a scale from 1 to 100 such that 100 is best and 0 is worst. Ranks are determined based on the weighted interval scores. -->

# 

------------------------------------------------------------------------

# WIS decomposition

As mentionend above, the weighted interval score can be decomposed into
three parts: sharpness (the amount of uncertainty around the forecast),
overprediction and underprediction. This visualisation gives an
impression of the distribution between these three forms of penalties
for the different models.

## overall

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-1.png)

## Austria

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-2.png)

## Belgium

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-3.png)

## Bulgaria

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-4.png)

## Croatia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-5.png)

## Cyprus

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-6.png)

## Czechia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-7.png)

## Denmark

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-8.png)

## Estonia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-9.png)

## Finland

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-10.png)

## France

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-11.png)

## Germany

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-12.png)

## Greece

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-13.png)

## Hungary

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-14.png)

## Iceland

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-15.png)

## Ireland

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-16.png)

## Italy

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-17.png)

## Latvia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-18.png)

## Liechtenstein

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-19.png)

## Lithuania

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-20.png)

## Luxembourg

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-21.png)

## Malta

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-22.png)

## Netherlands

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-23.png)

## Norway

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-24.png)

## Poland

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-25.png)

## Portugal

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-26.png)

## Romania

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-27.png)

## Slovakia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-28.png)

## Slovenia

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-29.png)

## Spain

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-30.png)

## Sweden

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-31.png)

## Switzerland

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-32.png)

## United Kingdom

![](/mnt/data/Google%20Drive/Uni/PhD/covid19-forecast-hub-europe/docs/index_files/figure-markdown_strict/wis-component-plot-33.png)

# 

<!--  -->
<!-- --- -->
<!-- # Models and available forecasts -->
<!-- The following graphic gives an overview of the models analysed and the number of forecasts they contributed.  -->

If you want to learn more about a model, you can go the the
‘data-processed’-folder of the [European Forecast Hub github
repository](https://github.com/epiforecasts/covid19-forecast-hub-europe),
select a model and access the metadata file with further information
provided by the model authors.
