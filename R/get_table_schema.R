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

#' Retrieve schema information for a dataset table.
#' @param owner_id User name and unique identifier of the creator of a
#' dataset or project
#' @param dataset_id Dataset unique identifier
#' @param table_name Table name.
#' @return Object of type \code{\link{table_schema_response}}.
#' @seealso \code{\link{list_tables}}
#' @examples
#' \dontrun{
#'   table_schema <- dwapi::get_table_schema("user", "dataset", "table")
#' }
#' @export
get_table_schema <- function(owner_id, dataset_id, table_name) {
  url <- sprintf("%s/tables/%s/%s/%s/schema",
    getOption("dwapi.query_url"),
    owner_id, dataset_id,
    table_name)
  response <- httr::GET(
    url,
    httr::add_headers(Authorization = paste0("Bearer ", auth_token())),
    httr::progress(),
    httr::user_agent(user_agent())
  )
  if (response$status_code == 200) {
    json_structure <-
      rjson::fromJSON(httr::content(
        x = response,
        as = "text",
        encoding = "UTF-8"
      ))
    ret <- table_schema_response(json_structure)
  } else {
    error_msg <-
      error_message(rjson::fromJSON(httr::content(
        x = response,
        as = "text",
        encoding = "UTF-8"
      )))
    stop(error_msg$message)
  }
  ret
}

#' @import dplyr
get_table_names_for_file <- function(owner_id, dataset_id, file_name) {
  q <- paste0("PREFIX dwo: <https://ontology.data.world/v0#> ",
    "SELECT ?filename ?tablename {",
    "[ a csvw:Table ; ",
    "dwo:definedInFile/dwo:name ",
    "?filename ; dwo:name ?tablename ]}")
  sparql(owner_id, dataset_id, q) %>%
    filter(filename == file_name) %>%
    pull(tablename)
}
