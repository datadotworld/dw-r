"dwapi-r
Copyright 2017 data.world, Inc.

Licensed under the Apache License, Version 2.0 (the \"License\");
you may not use this file except in compliance with the License.

You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an \"AS IS\" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied. See the License for the specific language governing
permissions and limitations under the License.

This product includes software developed at data.world, Inc.
https://data.world"

dw_test_that("createDataset making the correct HTTR request", {
  request <- dwapi::dataset_create_request(
    title = "datasetid",
    visibility = "OPEN",
    description = "it's data",
    tags = c("rsdk", "sdk", "arr"),
    license = "Public Domain"
  )
  response <- with_mock(
    `httr::POST` = function(url, body, header, user_agent)  {
      expect_equal(url,
        "https://api.data.world/v0/datasets/ownerid")
      expect_equal(header$headers[["Authorization"]], "Bearer API_TOKEN")
      expect_equal(rjson::toJSON(request), body)
      expect_equal(user_agent$options$useragent, user_agent())
      return(
        success_message_with_content(
          "resources/api.data.world/v0/CreateDatasetResponse.sample.json",
          "application/json"
        )
      )
    },
    `mime::guess_type` = function(...)
      NULL,
    dwapi::create_dataset("ownerid", create_dataset_req = request)
  )
  expect_equal(class(response), "create_dataset_response")
})
