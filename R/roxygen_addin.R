#' @title
#' Addin to open new script with roxygen template
#'
#' @author Josh Moatt
#'
#' @description
#' This addin will open a new blank R script which is populated with a standard
#' roxygen header.
#'
#' @details
#' This addin will create a new blank script that is populated with standard
#' roxygen header.
#'
#' Addins must use the rstudioapi package. This addin uses the [documentNew()]
#' function from the `rstudioapi` package to open the new R script.
#'
#' Note: this opens an normal untitled script. It must be manually saved in the
#' correct directory.
#'
#' @return
#' A script will open in RStudio.
#'
#' @export

roxygen_addin <- function() {

  # make FS header template
  header <- stringr::str_c(
    "#' @title \n",
    "#' Title \n",
    "#' \n",
    "#' @author Josh Moatt \n",
    "#' \n",
    "#' @description \n",
    "#' Description of function \n",
    "#' \n",
    "#' @details \n",
    "#' Details of function (optional) \n",
    "#' \n",
    "#' @param argument description add more as needed \n",
    "#' \n",
    "#' @param argument description add more as needed \n",
    "#' \n",
    "#' @return \n",
    "#' what is the output \n" ,
    "#' \n",
    "#' @export \n")

  # Open using Rstudio API
  rstudioapi::documentNew(text = header,
                          type = "r",
                          execute = FALSE,
                          position = 17)
}
