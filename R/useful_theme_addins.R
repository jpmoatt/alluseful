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

#' @export
#' @rdname useful_theme_addins
useful_randomtheme_addin <- function() {

  # themes I use
  themes <- c("my-dark",
              "my-light",
              "my-green",
              "my-chaos",
              "my-night-owl")

  # select random
  theme <- sample(themes, 1)

  rstudioapi::applyTheme(theme)

}
