% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_dataset.R
\name{get_dataset}
\alias{get_dataset}
\title{Retrieve dataset information.}
\usage{
get_dataset(owner_id, dataset_id)
}
\arguments{
\item{owner_id}{User name and unique identifier of the creator of a
dataset or project}

\item{dataset_id}{Dataset unique identifier}
}
\value{
Object of type \code{\link{dataset_summary_response}}.
}
\description{
Retrieve dataset information.
}
\examples{
\dontrun{
  dwapi::get_dataset("user", "dataset")
}
}
