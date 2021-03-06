% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataset_update_request.R
\name{dataset_update_request}
\alias{dataset_update_request}
\title{Create request object for updating existing datasets.}
\usage{
dataset_update_request(
  description = NULL,
  summary = NULL,
  tags = NULL,
  license = NULL,
  visibility = NULL,
  files = NULL
)
}
\arguments{
\item{description}{(optional) Dataset description.}

\item{summary}{(optional) Dataset summary (markdown supported).}

\item{tags}{(optional) Character vector of dataset tags
(letters, numbers and spaces).}

\item{license}{(optional) Dataset license ("Public Domain", "PDDL", "CC-0",
"CC-BY", "ODC-BY", "CC-BY-SA", "ODC-ODbL", "CC BY-NC-SA" or Other).}

\item{visibility}{(optional) Dataset visibility ("PRIVATE" or "OPEN").}

\item{files}{(optional) List
of \code{\link{file_create_or_update_request}} objects.}
}
\value{
Request object of type \code{dataset_update_request}.
}
\description{
Create request object for updating existing datasets.
}
\examples{
request <- dwapi::dataset_update_request(description = 'description',
  summary = 'summary',
  tags = list('sdk'), license = 'Public Domain')
}
\seealso{
\code{\link{update_dataset}}, \code{\link{add_file}}
}
