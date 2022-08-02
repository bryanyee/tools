### git-stash

# Advanced Stash
git stash --keep-index           # git add files to staging to keep them in staging, and save the whole diff to a stash.
git stash save --patch <message> # Interactively choose which files to stash.

# To apply the changes from only some files in a stash:
git checkout stash@{#} -- <path>

# To apply a stash that has been dropped:
git stash apply <stash_hash>


### git-rebase

git rebase -i <sha>                    # Rebase up to (but not including) the specified sha
git rebase -i HEAD~<number of commits> # Rebase the exact number of commits specified, starting from the latest commit


### Undo a merge commit
git revert -m 1 <merge-commit-hash>
git reset --hard <commit-before-merge>


### git history

# Find the last commit(s) that affected a (deleted) file:
git rev-list -n 1 HEAD -- <path>          # Returns the commit
git checkout <deleting_commit>^ -- <path> #  Retrieves the deleted file

# Find if a commit exists in a branch:
git log --oneline | grep <sha>
git branch --contains <sha>

# Search for commits that changed the number of occurrences of a string:
git log -S <string>        # Retrieves the commit
git log -p -S <string>     # Retrieves the commit and its diff
git log -S <string> <path> # Scoped to a particular file path, retrieves the commit

# Finds all commits involving the matched regex:
git log -G <regex>
git log -p -G <regex>
git log -G <regex> <path>


### git tags
git fetch --all --tags                    # Fetch all tags
git tag -l                                # List all tags
git checkout tags/<tag> -b <branch>       # Checkout a branch for a tag
git checkout tags/4.2.2 -b v4.2.2-branch


### Diffs

# View file names only in a diff
git diff --name-only <sha> <sha>
git diff --name-only <branch> <branch>

# View line change count in a diff
git diff --stat <sha> <sha>
git diff --stat <branch> <branch>

# View diff and ignore changes in whitespace (such as if code gets wrapped in a block and becomes indented)
git diff -w  # git diff --ignore-all-space


### Saving a diff to a patch and applying the patch
# Useful as an alternative to stashing and/or rebasing + squashing for the following cases:
# - Preserving the commits in a separate branch is desired.
# - The commits include merge commits (can't be combined with rebasing).
# - Saving the diff and sending it as a file (can't do this with stashes).
git diff <base_branch> <feature_branch> > <file_name>.patch # Saves the diff between branches as a file
git apply <file_name>.patch                                 # Applies the saved diff to the current branch


### Push an empty commit
git commit --allow-empty -m "Empty-Commit"
