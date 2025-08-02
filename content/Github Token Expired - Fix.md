
2025-07-27 11:43

Status: #adult 

Tags: [[Github]] [[Obsidian]] [[Token]]

# Github Token Expired - Fix

When returning to Obsidian after a long period of inactivity, I was prompted with a GitHub login screen due to an expired personal access token. This occurred because my Obsidian vault is backed up to a GitHub repository.

To resolve this, you need to generate a new personal access token from your GitHub account. Note that GitHub tokens now include an expiration date by default, so this process will need to be repeated once the token expires.

Once you have your new token, run the following command in the terminal within the directory where your Git repository is initialized:

```
git remote set-url origin "https://<YourUsername>:<YourToken>@github.com/your-repo-path.git"

or 

git remote add origin "https://<YourUsername>:<YourToken>@github.com/your-repo-path.git"

//confirm remote repository with:

git remote -v

```

Alternatively, you can configure SSH authentication instead of using a token. A helpful YouTube tutorial is linked below for reference.

*Edited with the help of AI tools for clarity and tone.*

Test for Quartz
###### References

| Type:   | Link/Description:                           |
| ------- | ------------------------------------------- |
| Youtube | https://www.youtube.com/watch?v=IuiH6cBtc58 |
