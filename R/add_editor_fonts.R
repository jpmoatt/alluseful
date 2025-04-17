#' @title add my custom fonts to the editor selection
#'
#' @author Josh Moatt
#'
#' @description Adds my custom fonts (all open source) to the editor UI
#'
#' @param dash logical, default TRUE. If TRUE uses .config file on DASH RStudio
#'   server, else uses windows.
#'
#' @return fonts added to UI
#'
#' @export
add_editor_fonts <- function(dash = TRUE) {

  # create font file path - path expand to add user details
  file_path <- ifelse(
    dash,
    fs::path_expand("~/.config/rstudio/fonts"),
    fs::path_expand("~/AppData/Roaming/RStudio/fonts")
  )

  # create font directory
  dir.create(file_path)

  # find folder in package
  fonts_folder <- system.file("rstudio", "fonts", package = "alluseful")

  # list fonts
  fonts <- list.files(fonts_folder)

  # copy font files
  for(i in 1:length(fonts)) {
    file.copy(
      from = paste0(fonts_folder,"/", fonts[[i]]),
      to = paste0(file_path, "/", fonts[[i]])
    )
  }
}
