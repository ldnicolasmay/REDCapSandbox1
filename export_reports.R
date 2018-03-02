#!/usr/bin/env Rscript

source("config.R") # contains API URL and API token
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
  returnFormat = 'json',
  config = c(ssl_verifypeer = TRUE, ssl_verifyhost = TRUE)
)
result_json <- fromJSON(result)
print(result_json)



library(redcapAPI)
# Only getting an error using the redcapAPI
# I'm just going to stick to using RCurl + jsonlite
rcon <- redcapConnection(url = api_url, token = api_token)
report <- exportReports(rcon = rcon, report_id = '1680', labels = FALSE) # Works
report <- exportReports(rcon = rcon, report_id = '1680', labels = TRUE)
report <- exportReports(rcon = rcon, report_id = '1680',
                        factors = TRUE, labels = TRUE,
                        dates = TRUE, checkboxLabels = FALSE)
my_metadata <- exportMetaData(rcon)
save(my_metadata, file = "my_metadata.Rda")
exportProjectInformation(rcon)
exportVersion(rcon)

# if (FALSE){
#   exportBundle(rcon = rcon)
#   report <- exportReports(rcon = rcon, report_id = 1680,
#                           factors = TRUE, labels = TRUE, dates = TRUE)
#   save(report, file = "report.Rdata")
# }
# print(report)
# class(report)


