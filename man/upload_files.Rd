% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/upload_file.R
\name{upload_files}
\alias{upload_files}
\title{Upload one or more files to a dataset.}
\usage{
upload_files(owner_id, dataset_id, paths)
}
\arguments{
\item{owner_id}{User name and unique identifier of the creator of a
dataset or project}

\item{dataset_id}{Dataset unique identifier}

\item{paths}{List of file paths on local file system.}
}
\value{
Server response message.
}
\description{
Upload one or more files to a dataset.
}
\examples{
\dontrun{
  dwapi::upload_files('user', 'dataset',
    paths = c('file1.csv', 'file2.csv'))
}
}
