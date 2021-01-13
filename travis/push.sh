#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_files() {
  echo "Commiting files..."
  git add --all
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload_files() {
  echo "Uploading files..."
  git remote rm origin
  git remote add origin https://${AUTH}@github.com/KITmetricslab/covid19-forecast-hub-de.git > /dev/null 2>&1
  git push --quiet --set-upstream origin HEAD:master
  echo "pushed to github"
}

setup_git
commit_files
upload_files
