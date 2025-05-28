#' @title Addin to open new script with my template
#'
#' @author Josh Moatt
#'
#' @description This addin will open a new blank R script which is populated
#'   with my header.
#'
#' @details This addin will create a new blank script that is populated with my
#'   template header.
#'
#'   Addins must use the rstudioapi package. This addin uses the [documentNew()]
#'   function from the `rstudioapi` package to open the new R script.
#'
#'   Note: this opens an normal untitled script. It must be manually saved in
#'   the correct directory.
#'
#' @return A script will open in RStudio.
#'
#' @export
script_addin <- function() {

  # make FS header template
  header <- stringr::str_c(
    "## - - - - - - - - - - - - - - \n",
    "## \n",
    "## Organisation: Defra Agri-Foodchain Directorate (Evidence & Analysis) \n",
    "## \n",
    "## Project: \n",
    "## \n",
    "## Script name: \n",
    "## \n",
    "## Purpose of script: \n",
    "## \n",
    "## Author: Josh Moatt \n",
    "## \n",
    "## Email: joshua.moatt@defra.gov.uk \n",
    "## \n",
    "## Date Created: ", format(Sys.Date(), "%d/%m/%Y"), " \n",
    "## \n",
    "## - - - - - - - - - - - - - - \n",
    "## Notes: \n",
    "## \n" ,
    "## \n",
    "## - - - - - - - - - - - - - - \n",
    "## Packages: \n",
    "\n",
    "# Pacman \n",
    "if (!require(pacman)) { \n",
    "  install.packages(\"pacman\") \n",
    "  library(pacman) # for automatic install of missing packaged through p_load \n",
    "} \n",
    "\n",
    "# packages: \n",
    "p_load( \n",
    "  dplyr, \n",
    "  glue, \n",
    "  here, \n",
    "  readr, \n",
    "  readxl, \n",
    "  stringr, \n",
    "  scales, \n",
    "  tidyr \n",
    ") \n",
    "\n",
    "## - - - - - - - - - - - - - - \n",
    "## Sourced files: \n",
    "\n",
    "## - - - - - - - - - - - - - - \n"
  )

  # Open using Rstudio API
  rstudioapi::documentNew(
    text = header,
    type = "r",
    execute = FALSE,
    position = 43
  )
}
