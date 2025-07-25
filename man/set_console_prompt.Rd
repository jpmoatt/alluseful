% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/set_console_prompt.R
\name{set_console_prompt}
\alias{set_console_prompt}
\title{Add my R console prompt.}
\usage{
set_console_prompt(scope = c("user", "project"), prompt = c("emoji", "git"))
}
\arguments{
\item{scope}{string. "user" sets the prompt globally, "project" sets it just
for the active project.}

\item{prompt}{string. "emoji" sets the prompt to be a themed emoji and git
branch (if active) or "git" sets it to the active git branch.}
}
\value{
Altered R prompt
}
\description{
Function to change the R console prompt from default to one of
two custom options. Either a themed emoji and the git branch, or just the
git branch. This can be set at the user level or the project level.
}
\author{
Josh Moatt
}
