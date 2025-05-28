#' @title Connect RStudio to your GitHub account using a SSH
#'
#' @author Josh Moatt
#'
#' @description Connect RStudio to your GitHub account using SSH - this is the
#'   preferred method of connecting RStudio and GitHub on the DASH platform. The
#'   function is set up to use my username and email address,using these to set
#'   my credentials and generate an SSH key. Once the SSH key has been added to
#'   GitHub, the function does the final bits of set-up. All steps and outputs
#'   are printed in the RStudio console rather than the terminal, which offers a
#'   more user friendly experience.
#'
#' @details The suggested method for connecting RStudio and GitHub on the DASH
#'   platform is via SSH. The alternative is via Personal Access Token, but this
#'   method can be a bit clunky and frustrating on the DASH platform. With SSH
#'   providing a much smoother user experience.
#'
#'   This function is designed to simplify the connection process and avoid the
#'   me having to interact with the terminal. Instead, all prompts and outputs
#'   are returned in the RStudio console.
#'
#'   The function will set my username and email then print an output to confirm
#'   they have been set. The function will then create a hidden SSH folder and
#'   sub-folder for "id_ed25519" (~/.ssh/id_ed25519). Once done, it will then
#'   generate an SSH key and save it to this folder. The SSH key will then be
#'   printed in the console. The function then adds GitHub as a known host.
#'
#'   At this point, the function pauses and asks the for confirmation that the
#'   SSH key has been added to GitHub. Now I can then copy the SSH key from the
#'   console, go to GitHub -> settings -> SSH and GPG keys and add the SSH key.
#'
#'   Once added, the I can respond to the prompt and the function will finish
#'   establishing the connection. If all works as expected, the message "Hi
#'   jpmoatt! You've successfully authenticated, but GitHub does not provide
#'   shell access" will be printed in the console.
#'
#' @export
connect_github_ssh <- function() {

  # Git config
  system('git config --global user.name "jpmoatt"')
  system('git config --global user.email "joshua.moatt@defra.gov.uk"')

  # check config
  cli::cli_text("")
  cli::cli_alert_success("GitHub credentials set to:")
  system('git config --global --list')
  cli::cli_text("")

  # Set SSH key path
  ssh_key_path <- "~/.ssh/id_ed25519"

  # Create SSH directory
  dir.create("~/.ssh", showWarnings = FALSE, recursive = TRUE)

  # Generate SSH key (no prompts)
  system(sprintf('ssh-keygen -t ed25519 -C "joshua.moatt@defra.gov.uk" -f %s -N ""', ssh_key_path))

  # messages
  cli::cli_text("")
  cli::cli_alert_success("SSH toke created")
  cli::cli_alert_info("Now copy your SSH token below and add it to your SSH keys on GitHub.com")
  cli::cli_text("")

  # Show public key (for adding to GitHub)
  system("cat ~/.ssh/id_ed25519.pub")

  # Message
  cli::cli_text("")
  cli::cli_alert_success("Adding github.com to known hosts")

  # Add GitHub to known_hosts
  system("ssh-keyscan github.com >> ~/.ssh/known_hosts")

  {

    tmp <- readline("Have you added your SSH token on GitHub? y/n \n")

    if (tmp == "y") {
      # connect GitHub and RStudio
      cli::cli_alert_success("Connected with GitHub")
      system("ssh -T git@github.com")
    } else {
      cli::cli_alert_danger("SSH token not added to GitHub. Add now and then complete manually \n")
      cli::cli_alert_info("To complete manually, run `ssh -T git@github.com` in the terminal once SSH token added to GitHub \n")
    }

  }

}
