#' @title
#' Function for RStudio project template
#'
#' @author Josh Moatt
#'
#' @description
#' This is a function that is called in the "New project" viewer pane when the
#' user chooses the useful project template. It should not be used away from the
#' RStudio "New project" viewer.
#'
#' I have not included additional information on how to use this function, as it
#' is not intended to be used outside the template call.
#'
#' To subsequently link this to a github repo, the best plan is to use
#' [fs_use_github()].
#'
#' @export

useful_proj_template <- function(path, ...) {
  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  # collect inputs and paste together as 'Parameter: Value'
  params <- list()
  dots <- list(...)
  for (i in seq_along(dots)) {
    key <- names(dots)[[i]]
    val <- dots[[i]]
    params[[key]] <- val
  }

  # set default title if no text entered
  params$title <- ifelse(nchar(params$title) < 1,
                          "Project title",
                          params$title)


  alluseful::useful_readme(format = params$readme,
                           file_path = path,
                           readme_title = params$title)

  # set file structure
  structure <- c("01_data", "02_src", "03_outputs")

  # add folders based on structure
  for (i in 1:length(structure)) {
    dir.create(glue::glue("{path}/{structure[i]}"))
  }

  if (params$pipeline) {
    alluseful::useful_script(file_name = "pipeline",
                             file_path = path,
                             project = params$title)
  }

}
