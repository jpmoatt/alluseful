#' @title Create an default R script template.
#'
#' @author Josh Moatt
#'
#' @description This function can be used to create a default R script template.
#' All scripts opened from this point will have this template applied as a
#' header.
#'
#' @details This function is used to create a new template for R scripts. This
#' will be the default that all subsequent R scripts opened will contain. By
#' doing this is it should be easier to follow best practice and properly
#' comment all scripts you create.
#'
#' The default is stored in the appdata folder on your c drive:
#' "~/AppData/Roaming/RStudio". It will create a "templates" folder where the
#' default will be stored.
#'
#' The function has various ways it can work which will give you the ability to
#' create whatever header template you wish. It has four ways formatting
#' options:
#'
#' \itemize{
#'    \item mine
#'    \item custom
#'    \item manual_edit
#'    \item blank
#' }
#'
#' "mine" will pre-load the default script with my template.
#'
#' "custom" will allow you to provide your own custom template as a string,
#' which will then be added to the default.
#'
#' "manual" will allow you to manually edit the default template. It will open
#' it in your R studio window and manual edits can be saved. Note, this can also
#' be used to tweak a pre-existing template (e.g. to add your name and email to
#' all scripts).
#'
#' "blank" will delete the default R script and template. This returns R back to
#' normal, and any script opened subsequently will be blank.
#'
#' @param format what format the template will take. There are four options:
#'   "mine" (my default template), "custom" will apply a custom template
#'   (provided as a string), "manual_edit" will open the template so you can
#'   manually edit the template, and "blank" can be used to remove all
#'   pre-existing templates. Note: manual edit can also be used to edit existing
#'   templates.
#'
#' @param template default is NULL, only used if format = "custom". Used to
#'   provide custom template design. Must be provided as a string. Must be
#'   provided if using format = "custom" or the function will return an error.
#'
#' @param dash default is FALSE. If TRUE changes the file path to the one needed
#'   for the RStudio server on DASH
#'
#' @return New .R file created containing the script template
#'
#' @export
set_script_template <- function(
    format = c(
      "mine",
      "manual_edit",
      "blank"
    ),
    template = NULL,
    dash = TRUE
) {

  file_path <- ifelse(dash,
                      "~/.config/rstudio/templates",
                      "~/AppData/Roaming/RStudio/templates")

  if (format == "mine") {

    # create template file if it doesn't exist already
    if (!fs::file_exists(file_path)) {
      fs::dir_create(path = file_path)
    }

    # make FS header template
    header <- c(
      "## - - - - - - - - - - - - - -",
      "##",
      "## Organisation: Defra Agri-Foodchain Directorate (Evidence & Analysis)",
      "##",
      "## Project:",
      "##",
      "## Script name: ",
      "##",
      "## Purpose of script: ",
      "##",
      "## Author: Josh Moatt",
      "##",
      "## Email: joshua.moatt@defra.gov.uk",
      "##",
      "## Date Created: ",
      "##",
      "## - - - - - - - - - - - - - -",
      "## Notes:",
      "##" ,
      "##",
      "## - - - - - - - - - - - - - -",
      "## Packages:",
      "",
      "# Pacman",
      "if (!require(pacman)) {",
      "  install.packages(\"pacman\")",
      "  library(pacman) # for automatic install of missing packaged through p_load",
      "}",
      "",
      "# Common packages:",
      "p_load( ",
      "  dplyr, ",
      "  glue, ",
      "  here, ",
      "  readr, ",
      "  readxl, ",
      "  stringr, ",
      "  scales,",
      "  tidyr",
      ")",
      "",
      "## - - - - - - - - - - - - - -",
      "## Sourced files:",
      "",
      "## - - - - - - - - - - - - - -",
      ""
    )

    # Create default R script template with header
    cat(header,
        file = fs::path_expand(paste0(file_path, "/default.R")),
        sep = "\n")

  } else if (format == "manual_edit") {
    # create template file if it doesn't exist already
    if (!fs::file_exists(file_path)) {
      fs::dir_create(path = file_path)
    }

    # Create the default file if doesn't exist already
    if (!fs::file_exists(paste0(file_path, "/default.R"))) {
      fs::file_create(paste0(file_path, "/default.R"))
    }

    # Open the file in RStudio to edit it
    usethis::edit_file(paste0(file_path, "/default.R"))

  } else if (format == "blank") {
    # this removes any pre-existing defaults
    fs::file_delete(paste0(file_path, "/default.R"))
  }
}
