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
useful_kisstheme_addin <- function() {

  rstudioapi::applyTheme("my-kiss")

}

#' @export
#' @rdname useful_theme_addins
useful_chaostheme_addin <- function() {

  rstudioapi::applyTheme("my-chaos")

}

#' @export
#' @rdname useful_theme_addins
useful_grubbertheme_addin <- function() {

  rstudioapi::applyTheme("my-grubber")

}

#' @export
#' @rdname useful_theme_addins
useful_randomtheme_addin <- function() {

  # themes I use
  themes <- c("my-kiss",
              "my-grubber",
              "my-chaos",
              "my-night-owl")

  # select random
  theme <- sample(themes, 1)

  rstudioapi::applyTheme(theme)

}
