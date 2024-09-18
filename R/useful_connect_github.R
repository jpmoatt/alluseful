#' @title
#' Connect RStudio to your GitHub account
#'
#' @description
#' This is a simple function which connect RStudio to GitHub, allowing you to
#' work on GitHub repositories. This is an essential part of Reproducible
#' Analytical Pipelines and best practice for coding.
#'
#' @details
#' This is a simple function which will set you GitHub credentials and Personal
#' Access Token (PAT) and connect RStudio to GitHub. This is essential if you
#' want to work in RStudio in projects/repos stored on GitHub.
#'
#' It uses [system()] to run the necessary code in the terminal to set your
#' credentials, and writes/updates your github PAT to your .Renviron file to
#' ensure git functionality. Instead of the intercative requirement (see below)
#' this new way does not require any inputs by the user after the function call.
#'
#' This new method replaces the old method suggested by defra which used
#' [gitcreds_set()] and [set_github_pat()] from the `gitcreds` and `credentials`
#' packages to connect your RStudio to GitHub.
#'
#' [gitcreds_set()] is an interactive function and will prompt users for input.
#' To replace existing credentials/PAT choose option 2. You will then be
#' prompted for you PAT. PAT should be changed every 30 days to ensure security.
#'
#' Note: For this function to work you must:
#'
#' \itemize{
#'    \item have git installed on your local machine
#'    \item have a GitHub account
#'    \item have created a Personal Access Token (PAT) on GitHub.
#' }
#'
#' Guidance on how to create a PAT can be found here: ADD LINK.
#'
#' @param pat string containing new PAT
#'
#' @param defra default TRUE. If TRUE will set the defra proxy in the terminal
#'   (needed for linking to github)
#'
#' @return
#' GitHub credentials and PAT set
#'
#' @export

useful_connect_github <- function(pat,
                                  defra = TRUE) {

  ## set my details ----
  # we only need to set the proxy if on Defra machines.

  if (defra) {
    # set proxy
    Sys.setenv(https_proxy = "http://secpr7e.demeter.zeus.gsi.gov.uk:80")

    ## this will run the terminal commands ----
    # proxy
    system("git config --global http.proxy http://secpr7e.demeter.zeus.gsi.gov.uk:80")
  }

  # GitHub UUN
  system('git config --global user.name "jpmoatt"')
  # email
  system('git config --global user.email "joshua.moatt@defra.gov.uk"')

  # check list
  cli::cli_alert_success("GitHub credentials set too:")
  system('git config --global --list')

  ## set pat ----
  # this is an alternative to the method suggested by Defra. It is more robust.

  # renviron path
  renviron_path <- file.path(Sys.getenv("HOME"), ".Renviron")

  # check .Renviron exists
  if (file.exists(renviron_path)) {
    renviron_lines <- readLines(renviron_path)
  } else {
    renviron_lines <- character()
  }

  # Check if GITHUB_PAT already exists in the file
  pat_line <- grep("^GITHUB_PAT=", renviron_lines)

  if (length(pat_line) > 0) {
    # Replace the existing GITHUB_PAT line
    renviron_lines[pat_line] <- paste0("GITHUB_PAT=", pat)
  } else {
    # If GITHUB_PAT does not exist, append it to the end
    renviron_lines <- c(renviron_lines, paste0("GITHUB_PAT=", pat))
  }

  # Write the updated lines back to the .Renviron file
  writeLines(renviron_lines, renviron_path)

  cli::cli_alert_success("GitHub pat is {pat}")

  # restart R
  cli::cli_alert_info("Restarting R to change PAT...")
  cli::cli_alert_info(cli::col_cyan('After restart, use `Sys.getenv("GITHUB_PAT")` to check your PAT has updated', wrap = TRUE))
  rstudioapi::restartSession()
}
