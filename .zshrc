# in /etc/profile
# export HISTSIZE=2000
# export HISTFILESIZE=2000

# TODO

# use local variables
# locate files - current directory, git repo, path, important locations
# stash the number of specified commits with the saved commit message
# get the diff for a single commit
# add function to count lines e.g. git branch -a | wc -l  ?? wc -l <<<


# SHORTCUT TO NOTES

export TOOLS_REPO=${HOME}/projects/myprojects/tools
alias tools="code ${TOOLS_REPO}"


# ALIASES

alias zshrc="code ~/.zshrc"
alias szshrc="source ~/.zshrc"
alias restart="exec $SHELL"

alias cl="copy_last" # see function
alias h="history"
alias hs="history_search" # see function
alias es="env | grep -i"
alias paths="echo \"${PATH//:/\n}\""
# alias paths="tr ':' '\n' <<< ${PATH}" # Alternative for zsh
alias show="type -a"
alias lss="ls -a | grep -i"
alias bx="bundle exec"
alias pm="precise_math" # see function
alias ccount="wc -m <<<"
alias wcount="wc -w <<<"
alias ports="lsof -i" # e.g. `ports :10001` to view processes at port 10001
alias ip_local="ipconfig getifaddr en0" # local private ip
alias ip_public="curl ifconfig.me" # public ip

# git aliases
alias gbd="git_branch_dialog.sh" # file in PATH at /usr/local/bin
alias glo="git_log_oneline" # see function
alias gls="git_log_search" # see function
alias gs="git status"
alias gsl="git stash list"
alias gb="git branch"
alias gbs="git branch | grep"
alias gcb="git branch; git rev-parse --abbrev-ref HEAD | tr -d '\n' | pbcopy; echo Copied current branch to clipboard."
alias gd="git diff"
alias gdl="git diff HEAD^ HEAD"
alias gdc="git diff --cached"
alias gcm="git checkout master"
alias gcl="git checkout -"
alias gca="git_commit_ammend" # see function


# MISC.

# Add configuration required for specifc tooling, like nvm, rvm, and pyenv



# FUNCTIONS

# git_log_oneline
# git_log_search
# git_commit_ammend
# history_search
# precise_math
# copy_last
# run_interval



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


# NOTE: Needs to be re-written for zsh instad of bash
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


# NOTE: Needs to be re-written for zsh instad of bash
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


# Run a command at a given internal
# run_interval "<command>" <interval>
#
# Arguments:
# command  : the command to run, wrapped in double quotes
# interval : the time interval in seconds
function run_interval {
  if [ $# = 2 ]; then
    while true; do eval "$1"; sleep $2; done
  else
    echo 'Must have two arguments'
  fi
}


# Squashes the last two commits, and uses the commit message of the earlier commit.
function squash_last_two {
  # Get the full commit message of the second-to-last commit
  commit_msg=$(git log --format=%B -n 1 HEAD~1)

  # Soft reset to the commit before the last two
  git reset --soft HEAD~2

  # Commit with the saved message, preserving formatting
  git commit -F- <<EOF
$commit_msg
EOF
  echo "Last two commits have been squashed."
}
