# in /etc/profile
# export HISTSIZE=2000
# export HISTFILESIZE=2000

# TODO

# locate files - current directory, git repo, engineering/jarvis repo, path, important locations
# stash the number of specified commits with the saved commit message

# ALIASES

alias bashrc="open -a \"Sublime Text\" ~/.bashrc"
alias bashp="open -a \"Sublime Text\" ~/.bash_profile"
alias sbrc="source ~/.bashrc"
alias opens="open_sublime" # see function
alias ol="open_sublime -l" # see function
alias cl="copy_last" # see function
alias h="history"
alias hs="history_search" # see function
alias es="env | grep -i"
alias paths="path_search" # see function
alias lss="ls -a | grep -i"
alias bx="bundle exec"
alias pm="precise_math"
alias ccount="wc -m <<<"
alias wcount="wc -w <<<"
alias pcd="cd ~/projects; cd"

# git aliases
alias sw="switch_dialog" # see function
alias glo="git_log_oneline" # see function
alias gls="git_log_search" # see function
alias gs="git status"
alias gsl="git stash list"
alias gb="git branch"
alias gbs="git branch | grep"
alias gcb="git branch; git rev-parse --abbrev-ref HEAD | tr -d '\n' | pbcopy; echo Copied current branch to clipboard."
alias groot="git rev-parse --show-toplevel"
alias gcdroot="cd `git rev-parse --show-toplevel`"
alias gd="git diff"
alias gdl="git diff HEAD^ HEAD"
alias gdc="git diff --cached"
alias gcm="git checkout master"
alias gcl="git checkout -"
alias gca="git_commit_ammend" # see function

# FUNCTIONS

# git_log_oneline
# git_log_search
# git_commit_ammend
# history_search
# switch
# switch_dialog
# show
# open_sublime
# math
# copy_last
# path_search



# aliased to "glo"
# Display git log history, one commit per line.
# git_log_oneline <option> [N]
#
# Arguments:
# N   : The number of commit lines to display. The default is 20.
#
# Options:
# -a  : "all" - Execute git log --oneline without a limit
function git_log_oneline {
  if [ $# = 0 ]; then
    git log --oneline -10
  elif [ $# = 1 ]; then
    if [[ $1 =~ [a-zA-Z] ]]; then
      if [ $1 = "-a" ]; then
        git log --oneline
      else
        echo "Invalid argument."
        return
      fi
    else
      git log --oneline -$1
    fi
  else
    echo "Too many arguments."
  fi
}


# aliased to "gls"
# Search tool for git commits.
# git_log_search <option> [string/regex] [path]
#
# Arguments:
# string/regex : the string/pattern to search for in a commit or commit message
# path         : (optional) the path used to limit the search
#
# Options:
# -p  : "patch" - show the commit diff
# -M  : "message" - search the git log messages
# -S  : "string" - look for differences that change the number of occurrences of the specified string
# -G  : "grep" - look for differences whose patch text contains added/removed lines that match the regex search
function git_log_search {
  if [ $# = 0 ]; then
    git_log_search_usage
  elif [ $# = 1 ]; then
    echo "git_log_search: Not enough arguments"
  else
    if [ $1 = "-p" ]; then
      if [ $2 = "-M" ]; then
        git log -p --grep "$3"
      else
        [ $# = 4 ] && path="$4" || path=""
        if [ $2 = "-S" ]; then
          git log -p -S "$3" $path
        elif [ $2 = "-G" ]; then
          git log -p -G "$3" $path
        else
          echo "git_log_search: Invalid arguments."
        fi
      fi
    else
      if [ $1 = "-M" ]; then
        git log --oneline --grep "$2"
      else
        [ $# = 3 ] && path="$3" || path=""
        if [ $1 = "-S" ]; then
          git log -S "$2" $path
        elif [ $1 = "-G" ]; then
          git log -G "$2" $path
        else
          echo "git_log_search: Invalid arguments."
        fi
      fi
    fi
  fi
}

function git_log_search_usage {
  echo -e "\nSearch tool for git commits
Usage: git_log_search <option> [string/regex] [path]

Arguments:
string/regex : the string/pattern to search for in a commit or commit message
path         : (optional) the path used to limit the search

Options:
-p  : 'patch' - show the commit diff
-M  : 'message' - search the git log messages
-S  : 'string' - look for differences that change the number of occurrences of the specified string
-G  : 'grep' - look for differences whose patch text contains added/removed lines that match the regex search"
}


# aliased to "gca"
# Amend the previous commit message
# git_commit_ammend [message]
#
# Arguments:
# message  :  the new commit message, in quotes
function git_commit_ammend {
  if [ $# = 0 ]; then
    git_commit_ammend_usage
    return
  fi

  git commit --amend -m"$1"
  echo "-> git commit --amend -m\"${1}\""
}

function git_commit_ammend_usage {
  echo -e "\nAmend the previous commit message
Usage: git_commit_ammend [message]

Arguments:
message  :  the new commit message, in quotes"
}

# aliased to "hs"
# Display terminal command history, filtered by a regex match
# history_search <option> [search]
#
# Arguments:
# search  :  a regular expression to filter history
#
# Options:
# -e      :  'execute' - allows the user to enter a number to execute a command immediately
function history_search {
  if [ $# = 0 ]; then
    echo "history_search: Not enough arguments."
    history_search_usage
  elif [ $# = 1 ]; then
    if [ $1 = "-e" ]; then
      echo "Please include a search argument."
      return
    fi

    history | grep -i $1
  elif [ $# = 2 ]; then
    if [ "$1" = "-e" ]; then
      history -a ~/.bash_history # append the session history to the bash_history file
      cat -n ~/.bash_history | grep -i $2

      echo -e "\nWhich command?"
      read command_index

      if [ -z $command_index ]; then
        echo "Please choose a command."
        return
      fi

      if [ $command_index = "q" ]; then
        echo "Quiting history_search."
        return
      fi

      selected_command=`head -${command_index} ~/.bash_history | tail -1`
      echo "Running: $selected_command"
      eval $selected_command

      echo "$selected_command" >> ~/.bash_history # add the command to the end og bash_history
      history -n ~/.bash_history # append the history lines not already read from the history file and append them to the history list
    else
      echo "Invalid option."
      history_search_usage
    fi
  else
    echo "Too many arguments."
    history_search_usage
  fi
}

function history_search_usage {
  echo -e "\nDisplays terminal command history, filtered by a regex match
Usage:  history_search <option> [search]

Arguments:
  search  :  a regular expression to filter history

Options:
  -e      :  'execute' - allows the user to enter a number to execute a command immediately"
}

# see switch_dialog for improved function
# Easily checkout git branches
# switch [branch]
#
# Arguments:
# branch  :  (optional) git branch to switch to
#
# If [branch] is not provided, all branches will be listed. Then enter
# the index that corresponds with a branch or the branch name to switch branches.
function switch {
  curr_branch=`git rev-parse --abbrev-ref HEAD`
  if [ -z $curr_branch ]; then
    return
  fi

  if [ $# = 1 ]; then
    echo "-> git checkout $1"
    git checkout $1
    return
  fi

  curr_branch_index=""
  branches=`git branch | tr -s "*" " "`

  GREEN='\033[0;32m'
  NC='\033[0m'

  counter1=0
  for b1 in $branches; do
    branch_line=" $counter1     $b1"
    if [ $b1 = "master" ]; then
      branch_line=${branch_line/"  "/"/m"}
    fi
    if [ $b1 = $curr_branch ]; then
      branch_line=${branch_line/"   "/" * "}
      branch_line="${GREEN}${branch_line}${NC}"
      curr_branch_index=$counter1
    fi
    echo -e "$branch_line"
    let counter1+=1
  done

  echo -e "\nWhich branch?"
  read branch_entry

  if [ -z $branch_entry ]; then
    echo "Please enter a branch number or name."
    return
  fi

  if [ $branch_entry = "q" ]; then
    echo "On branch $curr_branch"
    return
  fi

  if [ $branch_entry = $curr_branch_index ] || [ $branch_entry = $curr_branch ]; then
    echo "-> git checkout $curr_branch"
    echo "Already on '${curr_branch}'"
    return
  fi

  if [ $branch_entry = "m" ] || [ $branch_entry = "master" ]; then
    echo "-> git checkout master"
    git checkout master
    return
  fi

  counter2=0
  for b2 in $branches; do
    if [ $branch_entry = $counter2 ] || [ $branch_entry = $b2 ]; then

      echo "-> git checkout $b2"
      git checkout $b2
      return
    fi
    let counter2+=1
  done

  echo "-> git checkout $branch_entry"
  echo "error: pathspec '${branch_entry}' did not match any file(s) known to git."
}

# aliased to "sw"
# Easily checkout git branches, listed from a dialog menu
# dialog settings may be set in ~/.dialogrc
# switch_dialog
function switch_dialog {
  curr_branch=`git rev-parse --abbrev-ref HEAD`
  if [ -z $curr_branch ]; then
    return
  fi

  DIALOG_OK=0
  DIALOG_CANCEL=1
  DIALOG_ESC=255

  tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
  trap "rm -f $tempfile" 0 1 2 5 15

  curr_branch_index=""
  branches=`git branch | tr -s "*" " "`
  dialog_args=""

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
    let counter1+=1
  done

  dialog --keep-tite --title "git-checkout" \
          --menu "You are currently on branch:\n${curr_branch}\nSwitch to:" 0 0 0 \
          $dialog_args 2> $tempfile

  return_status=$?

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

# Find executable scripts or functions
# show <option> [search]
#
# Arguments:
# search  :  the name of a script or function
#
# Options:
# -s      :  "show" - cat the script/function
function show {
  if [ $# = 0 ]; then
    echo "usage: show <script>/<function>"
  elif [ $# = 1 ] || [ $# = 2 ]; then
    if [ $# = 1 ]; then search=$1; fi
    if [ $# = 2 ]; then search=$2; fi
    command_type=`type -t $search`
    case $command_type in
    "file")
      script_path=`which $search`
      echo "Script found:"
      echo $script_path
      if [ $# = 2 ]; then
        if [ $1 = "-s" ]; then
          echo "----------"
          cat $script_path
        else
          echo "$1 is not a valid option."
          echo "Use -s to cat the script."
        fi
      fi
      ;;
    "function")
      shopt -s extdebug
      func_path=`declare -F $search`
      shopt -u extdebug
      echo "Function found:"
      echo $func_path
      if [ $# = 2 ]; then
        if [ $1 = "-s" ]; then
          echo "----------"
          type $search
        else
          echo "$1 is not a valid option."
          echo "Use -s to display the function."
        fi
      fi
      ;;
    "builtin")
      echo "$1 is a shell builtin"
      ;;
    *)
      echo "Script or function not found."
      ;;
    esac
  else
    echo "Too many arguments."
  fi
}

# aliased to "opens"
# Open files in Sublime
# open_sublime <options> [file]
#
# Arguments:
# file  : file path for the file to open
#
# Options:
# -l    : reruns the last command and attempts to use the output
#         as the [file] argument to open Sublime with
function open_sublime {
  if [ $# = 0 ]; then
    open -a "Sublime Text"
  elif [ $# = 1 ]; then
    if [ "$1" = "-l" ]; then
      history -a ~/.bash_history # append the session history to the bash_history file
      last_command=`tail -2 ~/.bash_history | head -1`
      last_output=`eval $last_command`
      open -a "Sublime Text" $last_output
    else
      open -a "Sublime Text" "$1"
    fi
  else
    echo "Too many arguments."
  fi
}

# aliased to "cl"
# Copies the output of the last command to the clipboard
# copy_last
#
# There are no arguments.
function copy_last {
  history -a ~/.bash_history # append the session history to the bash_history file
  last_command=`tail -2 ~/.bash_history | head -1`
  last_output=`eval $last_command`
  echo -n "$last_output" | pbcopy
}

# aliased to "pm"
# Execute simple mathematical expressions with precision.
# Expressions must be in quotes.
# precise_math <options> [expression]
#
# Arguments:
# expression : mathematical expression to be executed
#
# Options:
# -p [N]     : 'precision' - specify the number of digits of precision
function precise_math {
  if [ $# = 0 ]; then
    precise_math_usage
    return
  fi

  if [ "$1" = "-p" ]; then
    input="scale=${2}; $3"
  else
    input="scale=20; $1"
  fi

  bc <<< "$input"
}

function precise_math_usage {
  echo -e "\nExecute simple mathematical expressions with precision.
Expressions must be in quotes.
Usage: precise_math <options> [expression]

Arguments:
 expression : mathematical expression to be executed

Options:
 -p [N]     : 'precision' - specify the N number of digits of precision"
}

# aliased to "paths"
# Display all directories in $PATH, with regex search
# path_search [search]
#
# Arguments
# search   :  (optional) a regular expression to paths
function path_search {
  paths=`echo $PATH`
  IFS=':' read -r -a path_array <<< "$paths"

  for path in "${path_array[@]}"; do
    if [ $# = 1 ]; then
      echo $path | grep -i $1
    else
      echo $path
    fi
  done
}
