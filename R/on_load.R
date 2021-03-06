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

create_url <- function(subdomain) {
  environment <- Sys.getenv("DW_ENVIRONMENT")
  if (environment == "") {
    return(paste("https://", subdomain, ".data.world", sep = ""))
  }
  paste("https://", environment, ".", subdomain, ".data.world", sep = "")
}

.onLoad <- function(libname, pkgname) { # nolint
  op <- options()
  op_dwapi <- list(
    dwapi.api_url      = ifelse(
      Sys.getenv("DW_API_HOST") == "",
      paste(create_url("api"), "/v0", sep = ""),
      Sys.getenv("DW_API_HOST")
    ),
    dwapi.query_url    = ifelse(
      Sys.getenv("DW_QUERY_HOST") == "",
      create_url("query"),
      Sys.getenv("DW_QUERY_HOST")
    ),
    dwapi.download_url = ifelse(
      Sys.getenv("DW_DOWNLOAD_HOST") == "",
      create_url("download"),
      Sys.getenv("DW_DOWNLOAD_HOST")
    ),
    dwapi.cache_dir    = path.expand(file.path("~", ".dw", "cache"))
  )
  toset <- !(names(op_dwapi) %in% names(op))

  if (any(toset))
    options(op_dwapi[toset])

  invisible(op_dwapi)

}
