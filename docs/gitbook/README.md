# Install gitbook
```
$ npm i -g gitbook-cli
```

### Initialize the book
```
$ gitbook init
```

### Install GitBook plugins
```
$ gitbook install
```

### Run `gitbook serve` to create a static site
```
$ gitbook serve
```

### Create gh-pages branch Initially
```
# install the gitbook plugins and build the status site
$ gitbook install && gitbook build

# create an orphan docs branch - gh-pages
$ git checkout --orphan gh-pages
# remove all cached file(s) and folder(s) which carry over from code master branch
$ git rm --cached -r .

# clean up the workspace except _book which created by `gitbook build`
$ ls | grep -v _book | xargs rm -fr

# copy all docs to root directory
$ cp -R _book/* .

# add all files/folders under root directory to git repo
$ git add .
# move some dotfiles out of git repo
$ git rm --cached .babelrc .dockerignore .env
# EDIT: put the 3 .files to .gitignore

# commit and push the docs to gh-pages branch
$ git commit
$ git push origin gh-pages

# checkout back to code branch - master
$ git checkout master
```
