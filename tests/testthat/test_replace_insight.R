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

dw_test_that("replace_insight making the correct HTTP request", {
  request <- dwapi::insight_replace_request(
    title = "insightid",
    description = "description",
    image_url = "https://test"
  )
  expect_equal("insight_replace_request", class(request))
  response <- with_mock(
    `httr::PUT` = function(url, body, header, user_agent)  {
      expect_equal(url,
                   "https://api.data.world/v0/insights/ownerid/projectid/id")
      expect_equal(header$headers[["Authorization"]], "Bearer API_TOKEN")
      expect_equal(rjson::toJSON(request), body)
      expect_equal(user_agent$options$useragent, user_agent())
      success_message_response()
    },
    `mime::guess_type` = function(...) NULL,
    dwapi::replace_insight("ownerid", "projectid", "id", request)
  )
  expect_equal(class(response), "success_message")
})

dw_test_that("missing title", {
  expect_error(
    dwapi::replace_insight("ownerid", "projectid",
                          insight_create_request(
                          )),
    regexp = "title")
  expect_error(
    dwapi::replace_insight("ownerid", "projectid",
                          insight_create_request(
                            title = NA_character_
                          )),
    regexp = "title")
  expect_error(
    dwapi::replace_insight("ownerid", "projectid",
                          insight_create_request(
                            title = " "
                          )),
    regexp = "title")
})

dw_test_that("invalid url params", {
  expect_error(
    dwapi::replace_insight("ownerid", "projectid",
                          insight_create_request(
                            title = "Title"
                          )),
    regexp = "one of.+image_url.+embed_url")
  expect_error(
    dwapi::replace_insight("ownerid", "projectid",
                          insight_create_request(
                            title = "Title",
                            image_url = "https://...",
                            embed_url = "https://..."
                          )),
    regexp = "only one of.+image_url.+embed_url")
})
