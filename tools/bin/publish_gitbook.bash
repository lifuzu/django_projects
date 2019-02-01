#!/usr/bin/env bash

# install the gitbook plugins and build the status site
gitbook install && gitbook build

# checkout to docs branch - gh-pages
git checkout gh-pages

# copy all docs to root directory
cp -R _book/* .

# add all files/folders under root directory to git repo
git add .

# commit and push the docs to gh-pages branch
git commit -a -m "Update docs at $(date)"
git push origin gh-pages

# checkout back to code branch - master
git checkout master
