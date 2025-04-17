#' @title
#' Apply my preffered RStudio settings and layout.
#'
#' @author Josh Moatt
#'
#' @param font string containing name of font to load. Need to refresh the
#' browser window for font change to take effect.
#'
#' @description
#' This function will change the settings and layout of RStudio to my usual
#' preferences. This has the source pane on the left, the console and terminal
#' on the top right and all others on the bottom right. It also applies my usual
#' global options (E.g. rainbow brackets, hexcode preview on etc).
#'
#' @return
#' RStudio configured to my settings
#'
#' @export

setup_rstudio <- function(font) {

  # function for applying changes
  customise_layout <- function(...){
    list_updated_prefs <- rlang::dots_list(...)

    # pull a list of current preferences based on the updates we want to make
    list_current_prefs <- names(list_updated_prefs) |>
      purrr::map(~rstudioapi::readRStudioPreference(.x, default = NULL)) |>
      stats::setNames(names(list_updated_prefs)) |>
      purrr::compact()

    # overwirte exisitng preferences and safe
    list_updated_prefs |>
      purrr::iwalk(~rstudioapi::writeRStudioPreference(name = .y, value = .x))
  }

  # my panel layout
  my_pane_layout <- list(
    quadrants = list("Source",
                     "TabSet1",
                     "Console",
                     "TabSet2"),
    tabSet1 = list("History",
                   "Presentation"), # need to keep history here (see notes)
    tabSet2 = list("Environment",
                   "Files",
                   "Plots",
                   "Connections",
                   "Packages",
                   "Help",
                   "Build",
                   "VCS",
                   "Tutorial",
                   "Viewer",
                   "Presentations"),
    hiddenTabSet = list(),
    console_left_on_top = FALSE,
    console_right_on_top = TRUE,
    additional_source_columns =0
  )

  # now update preferences (full list of modifiable settings here: https://docs.posit.co/ide/server-pro/reference/session_user_settings.html)
  customise_layout(
    always_save_history = FALSE, # don't auto save history
    save_workspace = "never", # don't save workspace
    load_workspace = FALSE, # don't load previous workspace
    restore_last_project = FALSE, # don't restore last opened project
    continue_comments_on_newline = TRUE, # when commenting, hitting enter continues comment on new line
    insert_native_pipe_operator = TRUE, # use native pipe
    highlight_selected_line = FALSE, # highlight line cursor is on
    highlight_r_function_calls = TRUE, # highlight R function calls
    show_margin = FALSE, # don't show margin (default = 80 characters)
    #font_size_points =11, # change font size (default is 10)
    rainbow_parentheses = TRUE, # colour match brackets
    color_preview = TRUE, # hexcode previews on
    panes = my_pane_layout, # Pane layout as set above
    server_editor_font = font,
    server_editor_font_enabled = TRUE
  )
}
