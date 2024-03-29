#!/usr/bin/env bash

# A keyboard-accessible dialog menu for switching git branches

# - `brew install dialog`
# - Put this script (git_branch_dialog.sh) in a directory in your PATH, such as /usr/local/bin (may need sudo)
# - Make the script executable: `chmod +x /usr/local/bin/git_branch_dialog.sh`
# - (optional) Dialog settings may be set in ~/.dialogrc, such as to change the background color
#   - https://bash.cyberciti.biz/guide/Dialog_customization_with_configuration_file
#   - `dialog --create-rc ~/.dialogrc`
#   - use_colors = ON
#   - screen_color = (CYAN,BLACK,ON)
# - Set alias in .bashrc/.zshrc: `alias gbd="git_branch_dialog.sh"`
# - Run `gbd`

function git_branch_dialog {
  # Get the current branch: https://stackoverflow.com/a/12142066
  curr_branch=`git rev-parse --abbrev-ref HEAD`
  # Return early if not on a git branch
  if [ -z $curr_branch ]; then
    return
  fi

  # Setup dialog arguments for branch selection
  branches=`git branch | tr -s "*" " "`
  curr_branch_index=""
  dialog_args="" # e.g. "0 first-branch > current-branch 1 third-branch 2 fourth-branch"

  counter1=0
  for b1 in $branches; do
    branch_line=""
    if [ $b1 = $curr_branch ]; then
      branch_line="> $b1"
      curr_branch_index=$counter1
    else
      branch_line="$counter1 $b1"
    fi
    dialog_args="$dialog_args $branch_line "
    let counter1+=1 # `let` evaluates arithmetic expressions
  done

  # Run the dialog menu
  tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
  trap "rm -f $tempfile" 0 1 2 5 15

  dialog --keep-tite --title "git-checkout" \
          --menu "You are currently on branch:\n${curr_branch}\nSwitch to:" 0 0 0 \
          $dialog_args 2> $tempfile

  return_status=$?
  DIALOG_OK=0
  DIALOG_CANCEL=1
  DIALOG_ESC=255

  case $return_status in
    $DIALOG_OK)
      branch_entry=`cat $tempfile`

      if [ $branch_entry = ">" ]; then
        echo -e "\n\n-> git checkout $curr_branch"
        echo "Already on '${curr_branch}'"
        return
      fi

      counter2=0
      for b2 in $branches; do
        if [ $branch_entry = $counter2 ]; then
          echo -e "\n\n-> git checkout $b2"
          git checkout $b2
        fi
        let counter2+=1
      done
      ;;
    $DIALOG_CANCEL)
      echo -e "\n\nQuit."
      echo "On branch $curr_branch"
      ;;
    $DIALOG_ESC)
      echo -e "\n\nQuit."
      echo "On branch $curr_branch"
      ;;
    *)
      echo -e "\n\nInvalid operation."
      echo "On branch $curr_branch"
  esac
}

git_branch_dialog
