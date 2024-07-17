# Git commands


## 1. Git Configuration

+ git config: Set or get Git configuration values


> Example: 

```git config --global user.name "John Doe" (Set global username)```
## 2. Git Initialization

+ git init: Initialize a new Git repository

> Example: 

```git init (Initialize a new Git repository in the current directory)```

## 3. Git Status

+ git status: Show the status of the repository

> Example: 

```git status (Show the status of the repository)```

## 4. Git Add

+ git add <file>: Stage a file for the next commit

> Example:

``` git add README.md (Stage the README.md file)```

+ git add.: Stage all changes in the current directory and subdirectories
> Example:

```git add. (Stage all changes)```

## 5. Git Commit

+ git commit -m "<message>": Commit changes with a message
> Example: 

```git commit -m "Initial commit" (Commit with a message)```

+ git commit -a: Commit all changes with a message

> Example: 

```git commit -a -m "Commit all changes" (Commit all changes)```

## 6. Git Log

+ git log: Show commit history

> Example: 

```git log (Show commit history)```

+ git log --graph: Show commit history with a graph
> Example: 

```git log --graph (Show commit history with a graph)```

## 7. Git Branch

+ git branch <branch>: Create a new branch

> Example:

```git branch feature/new-feature (Create a new branch)```

+ git checkout <branch>: Switch to a branch
> Example:

```git checkout feature/new-feature (Switch to a branch)```

## 8. Git Merge

+ git merge <branch>: Merge a branch into the current branch

> Example: 

```git merge feature/new-feature (Merge a branch)```

## 9. Git Remote

+ git remote add <name> <url>: Add a remote repository
> Example: 

```git remote add origin https://github.com/user/repo.git (Add a remote repository)```

+ git remote -v: Show remote repositories

> Example: 

```git remote -v (Show remote repositories)```

## 10. Git Fetch

+ git fetch: Fetch changes from a remote repository

> Example: 

```git fetch origin (Fetch changes from a remote repository)```

## 11. Git Pull

+ git pull: Fetch and merge changes from a remote repository
> Example: 

```git pull origin master (Fetch and merge changes)```

## 12. Git Push

+ git push: Push changes to a remote repository

> Example: 

```git push origin master (Push changes)```

## 13. Git Tag

+ git tag <tag>: Create a new tag

> Example: 

```git tag v1.0 (Create a new tag)```

+ git tag -a <tag> -m "<message>": Create a new annotated tag

>Example: 

```git tag -a v1.0 -m "Release v1.0" (Create a new annotated tag)```

## 14. Git Reset

+ git reset <commit>: Reset the current branch to a specific commit

>Example: 

```git reset HEAD~1 (Reset to the previous commit)```

+ git reset --hard: Reset the current branch to the latest commit and discard all changes

> Example: 

```git reset --hard (Reset and discard all changes)```

## 15. Git Clean

+ git clean: Remove untracked files and directories

>Example: 

```git clean -fd (Remove untracked files and directories)```

## 16. Git Stash

+ git stash: Stash changes for later use

> Example: 

```git stash (Stash changes)```

+ git stash apply: Apply stashed changes

> Example: 

```git stash apply (Apply stashed changes)```

## 17. Git Cherry-Pick

+ git cherry-pick <commit>: Apply a specific commit to the current branch

> Example: 

```git cherry-pick abc123 (Apply a specific commit)```

## 18. Git Rebase

+ git rebase <branch>: Rebase the current branch onto another branch

> Example: 

```git rebase master (Rebase onto the master branch)```

## 19. Git Submodule

+ git submodule add <url>: Add a submodule

> Example: 

```git submodule add https://github.com/user/submodule.git (Add a submodule)```

+ git submodule update: Update submodules

> Example: 

```git submodule update (Update submodules)```

## 20. Git Archive

+ git archive: Create an archive of the repository

> Example: 

```git archive -o archive.zip HEAD (Create a ZIP archive of the latest commit)```

## 21. Git Bisect

+ git bisect: Find the commit that introduced a bug

> Example: 

```git bisect start HEAD HEAD~10 (Start a bisect session to find a bug)```

## 22. Git Blame

+ git blame: Show who last modified each line of a file

> Example: 

```git blame README.md (Show who last modified each line of README.md)```

## 23. Git Bundle

+ git bundle: Create a bundle of objects

> Example: 

```git bundle create bundle.git HEAD (Create a bundle of the latest commit)```

## 24. Git Checkout

+ git checkout -- <file>: Discard changes to a file

>Example: 

```git checkout -- README.md (Discard changes to README.md)```

+ git checkout -b <branch>: Create a new branch and switch to it

>Example: 

```git checkout -b feature/new-feature (Create a new branch and switch to it)```

## 25. Git Cherry

+ git cherry: Find commits that are not in the upstream branch

> Example: 

```git cherry -v master (Find commits that are not in the master branch)```

## 26. Git Citool

+ git citool: Graphical commit tool

> Example: 

```git citool (Open the graphical commit tool)```


## 27. Git Clone

+ git clone: Clone a repository
>Example: 

```git clone https://github.com/user/repo.git (Clone a repository)```

## 28. Git Commit

+ git commit --amend: Amend the last commit

Example: 

```git commit --amend -m "New message" (Amend the last commit)```

## 29. Git Diff

+ git diff: Show changes between commits or files

> Example: 

```git diff HEAD~1 HEAD (Show changes between the last two commits)```

+ git diff --staged: Show changes between the index and the last commit

> Example: 

```git diff --staged (Show changes between the index and the last commit)```

## 30. Git Fetch

+ git fetch --prune: Fetch and prune remote-tracking branches

> Example: 

```git fetch --prune origin (Fetch and prune remote-tracking branches)```

## 31. Git Filter-Branch

+ git filter-branch: Rewrite branches

> Example: 

```git filter-branch -d /tmp/backup HEAD (Rewrite the HEAD branch)```

## 32. Git Fsck

+ git fsck: Check the integrity of the repository

>Example: 

```git fsck (Check the integrity of the repository)```

## 33. Git Gc

+ git gc: Garbage collect the repository

> Example: 

```git gc (Garbage collect the repository)```

## 34. Git Greep

+ git grep: Search for patterns in the repository

> Example: 

```git grep "pattern" (Search for a pattern in the repository)```


##  35. Git Instaweb

+ git instaweb: Start a web server to browse the repository

>Example: 

```git instaweb (Start a web server)```

## 36. Git Mv

+ git mv: Move or rename a file

> Example: 

```git mv README.md README.txt (Rename a file)```

## 37. Git Notes

+ git notes: Show or add notes to commits

> Example: 

```git notes add -m "Note" HEAD (Add a note to the latest commit)```

## 38. Git Repack

+ git repack: Repack the repository

> Example: 

```git repack (Repack the repository)```

## 39. Git Request-Pull

+ git request-pull: Generate a pull request message

> Example: 

```git request-pull origin master (Generate a pull request message)```

## 40. Git Reset

+ git reset --soft: Reset the current branch to a specific commit, but keep changes

> Example: 

```git reset --soft HEAD~1 (Reset to the previous commit, but keep changes)```