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

#' Create request object for updating existing datasets.
#' @param visibility (optional) Dataset visibility ("PRIVATE" or "OPEN").
#' @param description (optional) Dataset description.
#' @param summary (optional) Dataset summary (markdown supported).
#' @param tags (optional) Character vector of dataset tags
#'  (letters, numbers and spaces).
#' @param files (optional) List
#'  of \code{\link{file_create_or_update_request}} objects.
#' @param license (optional) Dataset license ("Public Domain", "PDDL", "CC-0",
#' "CC-BY", "ODC-BY", "CC-BY-SA", "ODC-ODbL", "CC BY-NC-SA" or Other).
#' @return Request object of type \code{dataset_update_request}.
#' @seealso \code{\link{update_dataset}}, \code{\link{add_file}}
#' @examples
#' request <- dwapi::dataset_update_request(description = 'description',
#'   summary = 'summary',
#'   tags = list('sdk'), license = 'Public Domain')
#' @export
dataset_update_request <-
  function(description = NULL,
    summary = NULL,
    tags = NULL,
    license = NULL,
    visibility = NULL,
    files = NULL) {
    is_nothing <- function(x)
      is.null(x) || is.na(x)
    me <- list()
    if (!is_nothing(visibility)) {
      me$visibility <- visibility
    }
    if (!is_nothing(description)) {
      me$description <- description
    }
    if (!is_nothing(summary)) {
      me$summary <- summary
    }
    if (!is_nothing(tags)) {
      me$tags <- tags
    }
    if (!is_nothing(license)) {
      me$license <- license
    }
    if (!is.null(files)) {
      me$files <- files
    }
    class(me) <- "dataset_update_request"
    return(me)
  }
