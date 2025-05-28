#' @title Add my rstudio themes
#'
#' @author Josh Moatt
#'
#' @description Function to add my rstudio themes from within this package.
#'
#' @return themes added to the rstudio api
#'
#' @export
add_themes <- function() {

  # find folder
  theme_folder <- system.file("rstudio", "themes", package = "alluseful")

  # ID themes
  my_themes <- list.files(theme_folder)

  # add themes
  for (i in 1:length(my_themes)) {
    rstudioapi::addTheme(
      themePath = glue::glue("{theme_folder}/{my_themes[i]}"),
      apply = FALSE,
      force = TRUE
    )
  }
}
