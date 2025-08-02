
2025-07-31 15:36

Status: #adult

Tags: [[Github]] [[Obsidian]] [[Quartz]] [[Blog]]

# Set Up a Github Pages for Obsidian using Quartz

To publish notes from an Obsidian vault to GitHub Pages, we’ll use Quartz, a static site generator built entirely on Node.js. GitHub Pages supports only static content, meaning there is no server-side rendering or support for frontend frameworks like React or Angular.

The goal is to create a portfolio website that includes:
	•	A short “About Me” section
	•	A showcase of personal or professional projects
	•	Selected notes from a specific folder in your Obsidian vault (e.g., Main Notes)
	
Quartz v4+ is a note-publishing tool designed for markdown-based content. It includes features such as:  Tag support, Backlinks and graph view,  Folder-based content organization
    

  

To set up Quartz, run the following:

```
git clone https://github.com/jackyzha0/quartz.git
cd quartz
npm i
npx quartz create
```

Responce after setting up quartz

```
  You're all set! Not sure what to do next? Try:
  • Customizing Quartz a bit more by editing `quartz.config.ts`
  • Running `npx quartz build --serve` to preview your Quartz locally
  • Hosting your Quartz online (see: https://quartz.jzhao.xyz/hosting)

npx quartz build --serve

to exit ctrl+c

```

You may want to keep your full Obsidian vault private and only publish a specific folder (e.g., Main Notes). While symlinking the folder to Quartz’s content directory works locally, GitHub Pages does not support symlinks. To address this, we use a script that copies the selected notes folder directly into the Quartz content directory before building and deploying the site.


Remeber to sync with

```
npx quartz sync

```

Bash script:

```
#!/bin/bash

# Stop on errors
set -e

# Paths (update these if your folders are different)
VAULT_PATH=~/Documents/ObsidianVault/Main\ Notes
QUARTZ_PATH=~/Documents/quartz-site
TARGET_PATH=$QUARTZ_PATH/content

echo "🧹 Clearing old content folder but keeping index.md..."
cd "$TARGET_PATH"
find . -mindepth 1 -not -name 'index.md' -exec rm -rf {} +

echo "📋 Copying published notes from Obsidian vault..."
cp -r "$VAULT_PATH"/* "$TARGET_PATH"

echo "📂 Switching to Quartz directory..."
cd "$QUARTZ_PATH"

echo "🔄 Syncing Quartz site metadata..."
npx quartz sync

echo "🏗️ Building Quartz site using npx..."
npx quartz build

echo "📦 Committing and pushing to GitHub..."
git add .
git commit -m "Deploy: $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main

echo "✅ Deployment complete. Your Quartz site will update shortly via GitHub Pages."te metadata..."
npx quartz sync

```

Make an executable:

```
chmod +x deploy.sh

```
Run with:

```
./deploy.sh

```
## References

https://quartz.jzhao.xyz/hosting

[[Obsidian The King of Learning Tools (Full Guide + Setup)]]
