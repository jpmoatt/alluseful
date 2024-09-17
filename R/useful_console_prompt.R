#' @title Add my useful R console prompt.
#'
#' @author Josh Moatt
#'
#' @description Useful function to change the R console prompt from default to
#' one of two custom options. Either a themed emoji and the git branch, or just
#' the git branch. This can be set at the user level or the project level.
#'
#' @param scope string. "user" sets the prompt globally, "project" sets it just
#'   for the active project.
#'
#' @param prompt string. "emoji" sets the prompt to be a themed emoji and git
#'   branch (if active) or "git" sets it to the active git branch.
#'
#' @return
#' Altered R prompt
#'
#' @export

useful_console_prompt <- function(scope = c("user",
                                            "project"),
                                  prompt = c("emoji",
                                             "git")) {
  # set path
  if (scope == "user") {
    rprofile_path <- "~/.Rprofile"
  } else if (scope == "project") {
    rprofile_path <- "./.Rprofile"
  }

  current_profile <- readLines(rprofile_path)

  if (any(grepl("\\.First <- function\\(", current_profile)) &&
      any(grepl("my_prompt <- function\\(", current_profile))) {

    cli::cli_alert_danger("Note: custom profile already present\n")
    cli::cli_alert_info("Edit using `usethis::edit_r_profile()` and try again.")
    stop("Cancelled: Prompt already present!", call = FALSE)

  } else if (prompt == "emoji") {
    my_prompt <- '.First <- function() {
  my_prompt <- function(...) {
    git_branch <- suppressWarnings(system("git rev-parse --abbrev-ref HEAD",
                                          ignore.stderr = TRUE,
                                          intern = TRUE))
    # list of emojis
    emoji_list <- c("tractor", "man_farmer", "woman_farmer", "deer", "ox", "boar",
                    "cow", "pig", "ram", "ewe", "goat", "rooster", "egg", "chicken",
                    "herb", "sheaf_of_rice", "green_apple", "mushroom", "sunflower",
                    "seedling", "red_apple", "pear", "strawberry", "carrot", "potato",
                    "broccoli", "onion")
    # randomly sample
    emoj <- sample(emoji_list, replace = TRUE, size = 1)
    # branch name
    if (length(git_branch) != 0) {
      git_msg <- paste0(" @", git_branch)
    } else {
      git_msg <- ""
    }
    console_msg <- paste0(
      "[", emoji::emoji(emoj), git_msg, "]> "
    )

    options(prompt = console_msg)
    invisible(TRUE)
  }
  my_prompt()
  addTaskCallback(my_prompt)
}'
  } else if (prompt == "git") {
    my_prompt <- '.First <- function() {
  my_prompt <- function(...) {
    git_branch <- suppressWarnings(system("git rev-parse --abbrev-ref HEAD",
                                          ignore.stderr = TRUE,
                                          intern = TRUE))
    # branch name
    if (length(git_branch) != 0) {
      git_msg <- paste0("@", git_branch)
    } else {
      git_msg <- "no-git"
    }
    console_msg <- paste0(
      "[", git_msg, "]> "
    )

    options(prompt = console_msg)
    invisible(TRUE)
  }
  my_prompt()
  addTaskCallback(my_prompt)
}'
  }
# write to file
cat(my_prompt, file = rprofile_path, append = TRUE)

cli::cli_alert_info("Restart R for prompt changes to take effect")

}
