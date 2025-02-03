#' @title Connect RStudio to your GitHub account
#'
#' @description This is a simple function which connect RStudio to GitHub,
#' allowing you to work on GitHub repositories. This is an essential part of
#' Reproducible Analytical Pipelines and best practice for coding.
#'
#' @details This is a simple function which will set you GitHub credentials and
#' Personal Access Token (PAT) and connect RStudio to GitHub. This is essential
#' if you want to work in RStudio in projects/repos stored on GitHub.
#'
#' It uses [system()] to run the necessary code in the terminal to set your
#' credentials, and uses [gitcreds_set()] and [set_github_pat()] from the
#' `gitcreds` and `credentials` packages to connect your RStudio to GitHub.
#'
#' [gitcreds_set()] is an interactive function and will prompt users for input.
#' To replace existing credentials/PAT choose option 2. You will then be
#' prompted for you PAT. PAT should be changed every 30 days to ensure security.
#'
#' An additional feature I have added, not mentioned in the Defra instructions
#' is to add the [set_github_pat()] function call to your .Rprofile. This will
#' ensure your PAT is set for every R session, meaning you wont need to provide
#' your PAT when running functions such as [install_github()] from the devtools
#' package.
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
#' @param defra default TRUE. If TRUE will set the defra proxy in the terminal
#'   (needed for linking to github)
#'
#' @return GitHub credentials and PAT set
#'
#' @export

connect_github <- function(defra = TRUE) {

  ## set my details ----
  # we only need to set the proxy if on Defra machines.

  if (defra) {
    # set proxy
    Sys.setenv(http_proxy = "http://127.0.0.1:9000")

    ## this will run the terminal commands ----
    # proxy
    system("git config --global http.proxy http://127.0.0.1:9000")
  }

  # GitHub UUN
  system('git config --global user.name "jpmoatt"')
  # email
  system('git config --global user.email "joshua.moatt@defra.gov.uk"')

  # check list
  cli::cli_alert_success("GitHub credentials set too:")
  system('git config --global --list')

  ## set pat ----
  # set gitcreds - this will prompt for user input
  gitcreds::gitcreds_set()

  # set PAT
  credentials::set_github_pat()

  # check PAT
  pat <- Sys.getenv("GITHUB_PAT")
  cli::cli_alert_success("GitHub pat is {pat}")

  ## update .Rprofile ----
  # set path
  rprofile_path <- "~/.Rprofile"

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
