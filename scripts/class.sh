#!/bin/bash
# Create all folders for an university class organisation.

# Create directories
mkdir 00-res
mkdir 01-labs # labs
mkdir 02-prob # problems/tasks/etc
mkdir 03-proj # projects

# Init documentation
# zk init "doc/"
# touch README.md

# Create a gitignore
touch .gitignore
# Init git
git init
git add .
git commit -m "initial commit"
