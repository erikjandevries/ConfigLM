# Bare Repositories

This folder is a shared folder, intended to contain only bare Git repositories.

### Creating a bare repository
To create a bare Git repository, run the following Git command on the server:
> git init --bare REPO_NAME


### Cloning a bare repository
To clone a bare Git repository, run the following Git command on a workstation:
> git clone BARE_REPO_LOCATION LOCAL_REPO_NAME

When a bare repository has been created and cloned for the first time, you have
to specify the origin's branch on the workstation, before you can push edits to
the bare repository.
> gedit .gitignore
> git add .  
> git commit -m "Initial commit."  
> git push --set-upstream origin master

After the origin's branch has been set, you can add, commit and push files to
the bare repository as usual.
> git add .  
> git commit -m "Commit message"  
> git push
