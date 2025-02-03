#' @title
#' Add [set_github_pat()] to project specific .Rprofiles
#'
#' @author Josh Moatt
#'
#' @description
#' A simple function to add the [set_github_pat()] function call to your project
#' specific .Rprofile. This is needed for projects where `renv` is activated, so
#' you can avoid hardcoding your PAT anywhere. See [useful_connect_github] for
#' full details and reasoning behind this function.
#'
#' @return
#' updated .Rprofile
#'
#' @export
set_proj_pat <- function() {

  # set path
  rprofile_path <- "./.Rprofile"

  # check if function call present
  rprofile_lines <- readLines(rprofile_path)

  # check for function
  cred_line <- grep("credentials", rprofile_lines)

  # update .Rprofile
  if (length(cred_line) == 0) {

    # create function as string
    cred_func <- 'credentials::set_github_pat(verbose = FALSE)\n'

    # add to .Rprofile
    rprofile_lines <- c(rprofile_lines, cred_func)

    # write lines
    writeLines(rprofile_lines, rprofile_path)

    cli::cli_alert_success("Added {.code credentials::set_github_pat()} to .Rprofile", wrap = TRUE)

  } else if (length(cred_line) > 0) {
    cli::cli_alert_success("{.code credentials::set_github_pat()} already in .Rprofile", wrap = TRUE)
  }

}
