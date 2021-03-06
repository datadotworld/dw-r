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

dw_test_that("get_table_schema making the correct HTTR request", {
  response <- with_mock(
    `httr::GET` = function(url, header, progress, user_agent)  {
      expect_equal(url,
        "https://query.data.world/tables/ownerid/datasetid/tableid/schema")
      expect_equal(header$headers[["Authorization"]], "Bearer API_TOKEN")
      expect_equal(user_agent$options$useragent, user_agent())

      return(
        success_message_with_content(
          "resources/query.data.world/Schema.sample.json",
          "application/json"
        )
      )
    },
    `mime::guess_type` = function(...)
      NULL,
    dwapi::get_table_schema("ownerid", "datasetid", "tableid")
  )
  expect_equal(class(response), "table_schema_response")
  expect_length(response$fields, 2)
  expect_equal(names(response$fields[[1]]),
    c("name", "title", "description", "rdf_type"))
})

dw_test_that("get_table_names_for_file", {
  mock_sparql <- function(owner_id, dataset_id, q) {
    tribble(
      ~filename, ~tablename,
      "x", "t",
      "xx", "tx",
      "xx", "ty"
    )
  }
  table_name <- with_mock(
    `dwapi::sparql` = mock_sparql,
    get_table_names_for_file("ownerid", "datasetid", "x")
  )
  expect_equal(table_name, "t")
  table_name <- with_mock(
    `dwapi::sparql` = mock_sparql,
    get_table_names_for_file("ownerid", "datasetid", "xx")
  )
  expect_equal(table_name, c("tx", "ty"))
  table_name <- with_mock(
    `dwapi::sparql` = mock_sparql,
    get_table_names_for_file("ownerid", "datasetid", "z")
  )
  expect_length(table_name, 0)
})
