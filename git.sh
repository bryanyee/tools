### git-stash

# Stash only some files
git stash --keep-index # git add files to staging to prevent them from being stashed
git stash -p           # Interactively choose which files to stash

# To apply the changes from only some files in a stash:
git checkout stash@{#} -- <path>

# To apply a stash that has been dropped:
git stash apply <stash_hash>


### git history

# Find the last commit(s) that affected a (deleted) file:
git rev-list -n 1 HEAD -- <path>          # Returns the commit
git checkout <deleting_commit>^ -- <path> #  Retrieves the deleted file

# Find if a commit exists in a branch:
git log --online --grep <sha>
git branch --contains <sha>

# Search for commits that changed the number of occurrences of a string:
git log -S <string>        # Retrieves the commit
git log -p -S <string>     # Retrieves the commit and its diff
git log -S <string> <path> # Scoped to a particular file path, retrieves the commit

# Finds all commits involving the matched regex:
git log -G <regex>
git log -p -G <regex>
git log -G <regex> <path>
