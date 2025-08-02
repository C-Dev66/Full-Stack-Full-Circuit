
2025-08-01 00:21

Status: #adult

Tags:  [[Efficient]] [[Github]] 

# How to set use .gitignore

To prevent files or folders from being committed and pushed to your repository, use a .gitignore file.

Add the filename to .gitignore:

```
my_secret_key.txt

```

If the file is already tracked, remove it from Git while keeping it locally:

```
git rm --cached my_secret_key.txt
git add .gitignore
git commit -m "Ignore my_secret_key.txt"

```

To stop tracking a folder that’s already committed:
```
git rm -r --cached folder_to_remove
git add .gitignore
git commit -m "Stop tracking folder_to_remove"

```
## References


[[Github Token Expired - Fix]]
[[Set Up a Github Pages for Obsidian using Quartz]]


