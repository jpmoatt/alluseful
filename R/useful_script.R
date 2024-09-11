#' @title Create a new script with my header.
#'
#' @author Josh Moatt
#'
#' @description This function will create a new script with my header added.
#'
#' @param file_name string containing desired name for script.
#'
#' @param file_path string containing folder name to save script. This is built
#'   on the here function in R, so will follow your root directory. If you want
#'   to save in a sub-folder, enter the full folder sequence, e.g.
#'   "folder/sub-folder".
#'
#' @param date string containing a date. By default, this will be set as today's
#'   date.
#'
#' @return An R script will be saved in the root directory or in the specified
#' folder.
#'
#' @export

useful_script <- function(file_name = NULL,
                          file_path = NULL,
                          project = NULL,
                          date = format(Sys.Date(), "%d/%m/%Y")) {
  # header
  header <- stringr::str_c(
    "## - - - - - - - - - - - - - -\n",
    "##\n",
    "## Organisation: Defra Agri-Foodchain Directorate (Evidence & Analysis)\n",
    "##\n",
    "## Project: ", project, "\n",
    "##\n",
    "## Script name: \n",
    "##\n",
    "## Purpose of script: \n",
    "##\n",
    "## Author: Josh Moatt \n",
    "##\n",
    "## Email: joshua.moatt@defra.gov.uk \n",
    "##\n",
    "## Date Created: ", date, "\n",
    "##\n",
    "## - - - - - - - - - - - - - -\n",
    "## Notes:\n",
    "##\n" ,
    "##\n",
    "## - - - - - - - - - - - - - -\n",
    "## Packages:\n",
    "\n",
    "# Pacman\n",
    "if(!require(pacman)){\n",
    "  install.packages(\"pacman\")\n",
    "  library(pacman) # for automatic install of missing packaged through p_load\n",
    "}\n",
    "\n",
    "# Common packages:\n",
    "p_load( \n",
    "  dplyr, \n",
    "  glue, \n",
    "  here, \n",
    "  readr, \n",
    "  readxl, \n",
    "  stringr, \n",
    "  scales, \n",
    ") \n",
    "\n",
    "## - - - - - - - - - - - - - -\n",
    "## Functions:\n",
    "\n",
    "## - - - - - - - - - - - - - -\n",
    "\n"
  )

  # file name
  name_script <- ifelse(is.null(file_name),
                        "New Script",
                        file_name)

  # file path
  add_to <- ifelse(is.null(file_path),
                   here::here(glue::glue("{name_script}.R")),
                   here::here(glue::glue("{file_path}"),
                              glue::glue("{name_script}.R")))


  # create qmd
  cat(header,
      file = add_to,
      sep = "\n")
}
