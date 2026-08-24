#!/bin/bash

# Create directories
mkdir package
mkdir out

# Create files
touch package/__init__.py
touch requirements.txt

# Ask for requirements
read -p "Requirements(comma separated): " requirements
for i in ${requirements//,/ }; do
  # Write requirements into requirements.txt
  echo $i >>requirements.txt
done

# Create a makefile
touch makefile
# Update the makefile for python
# TODO: Future updates, right now i dont really know how to do this, right now i dont really know how to do this

# Init venv
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

# Update .gitignore adding github gitignore for python
curl -s https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore >>.gitignore
