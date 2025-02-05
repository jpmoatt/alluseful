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
#' @rdname theme_addins
lighttheme_addin <- function() {

  rstudioapi::applyTheme("my-light")

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
grubbertheme_addin <- function() {

  rstudioapi::applyTheme("my-grubber")

}

#' @export
#' @rdname theme_addins
randomtheme_addin <- function() {

  # themes I use
  themes <- c("my-kiss",
              "my-grubber",
              "my-chaos",
              "my-night-owl")

  # select random
  theme <- sample(themes, 1)

  rstudioapi::applyTheme(theme)

}
