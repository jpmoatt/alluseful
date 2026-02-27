#' @title Apply my rstudio themes via addins
#'
#' @author Josh Moatt
#'
#' @description Addins to apply my rstudio themes
#'
#' @return themes added to the rstudio api
#'
#' @export
#' @rdname theme_addins
sqllight_addin <- function() {

  rstudioapi::applyTheme("my-sqlserver")

}

#' @export
#' @rdname theme_addins
kisstheme_addin <- function() {

  rstudioapi::applyTheme("my-kiss")

}

#' @export
#' @rdname theme_addins
draculatheme_addin <- function() {

  rstudioapi::applyTheme("my-dracula")

}

#' @export
#' @rdname theme_addins
cobalttheme_addin <- function() {

  rstudioapi::applyTheme("my-cobalt")

}
