% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_files_by_source.R
\name{add_files_by_source}
\alias{add_files_by_source}
\title{Add one or more files to a dataset.}
\usage{
add_files_by_source(dataset, file_batch_update_req)
}
\arguments{
\item{dataset}{Dataset URL or path.}

\item{file_batch_update_req}{Object of type \code{\link{file_batch_update_request}}.}
}
\value{
Object of type \code{\link{success_message}}.
}
\description{
Add one or more files to a dataset.
}
\examples{
request <- dwapi::file_batch_update_request()
request <- dwapi::add_file(request = request, name = 'file.csv',
     url = 'https://data.world/some_file.csv')
\dontrun{
  dwapi::add_files_by_source(dataset = 'user/dataset',
     file_batch_update_req = request)
}
}