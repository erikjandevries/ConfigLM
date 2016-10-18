# Changing the Git history of a repository

See https://help.github.com/articles/changing-author-info/

1. Open Git Bash
2. Create a temporary clone of the repository
3. Run the script git_author_rewrite.sh from the repository folder
4. Review the Git history for errors
5. Push the corrected history to the original repository

    git push --force --tags origin 'refs/heads/*'

6. Remove the temporary clone
