#!/usr/bin/env Rscript

source('config.R') # contains API URL and API token
library(redcapAPI)
library(RCurl)
library(jsonlite)

# # Project info
# result <- postForm(
#   uri = api_url,
#   token = api_token,
#   content = 'project',
#   format = 'json',
#   returnFormat = 'json'
# )
# result_json <- fromJSON(result)
# print(result_json)

# Project report - WORKS!
result <- postForm(
  uri = api_url,
  token = api_token,
  content = 'report',
  format = 'json',
  report_id = '1680',
  rawOrLabel = 'label',
  rawOrLabelHeaders = 'label',
  exportCheckboxLabel = 'false',
  returnFormat = 'json'
)
result_json <- fromJSON(result)
print(result_json)

rcon <- redcapConnection(url = api_url, token = api_token)
# report <- exportReports(rcon = rcon, report_id = '1680') # Doesn't work
# report <- exportReports(rcon = rcon, report_id = '1680', 
#                         factors = TRUE, labels = TRUE, 
#                         dates = TRUE, checkboxLabels = FALSE)

exportProjectInformation(rcon)
exportVersion(rcon)

if (FALSE){
  # exportBundle(rcon = rcon)
  report <- exportReports(rcon = rcon, report_id = '1680', 
                          factors = TRUE, labels = TRUE, dates = TRUE)
  save(report, file = "report.Rdata")
}
print(report)
class(report)


