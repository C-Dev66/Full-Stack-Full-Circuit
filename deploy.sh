#!/bin/bash

# Stop on errors
set -e

# Paths (update these if your folders are different)
VAULT_PATH=~/Documents/"00. Obsidian Vault Notes"/My_Vault_CDev66/"06. Main Notes"
QUARTZ_PATH=~/Documents/"00. Obsidian Vault Notes"/Full-Stack-Full-Circuit/quartz
TARGET_PATH=$QUARTZ_PATH/content

echo "🧹 Clearing old content folder..."
rm -rf "$TARGET_PATH"
mkdir "$TARGET_PATH"

echo "📋 Copying published notes from Obsidian vault..."
cp -r "$VAULT_PATH"/* "$TARGET_PATH"

echo "🔧 Building Quartz site using npx..."
cd "$QUARTZ_PATH"
npx quartz build

echo "📦 Committing and pushing to GitHub..."
git add .
git commit -m "Deploy: $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main

echo "✅ Deployment complete. Your Quartz site will update shortly via GitHub Pages."