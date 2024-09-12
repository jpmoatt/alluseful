#' @title
#' Apply my rstudio themes via addins
#'
#' @author Josh Moatt
#'
#' @description
#' Addins to apply my rstudio themes
#'
#' @return
#' themes added to the rstudio api
#'
#' @export
#' @rdname useful_theme_addins
useful_lighttheme_addin <- function() {

  rstudioapi::applyTheme("my-light")

}

#' @export
#' @rdname useful_theme_addins
useful_darktheme_addin <- function() {

  rstudioapi::applyTheme("my-dark")

}
