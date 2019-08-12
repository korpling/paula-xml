#!/bin/bash

# Used by CI to deploy the existing documentation/book/<version> directory to Github Pages

if [ -n "$GITHUB_API_KEY" ]; then
    cd "$TRAVIS_BUILD_DIR"

    rm -Rf gh-pages

    echo "cloning gh-pages from https://github.com/{TRAVIS_REPO_SLUG}"
    git clone -q  -b gh-pages https://$GITHUB_API_KEY@github.com/{TRAVIS_REPO_SLUG} gh-pages &>/dev/null || echo "Git clone failed. Did you use the correct value for the GITHUB_API_KEY environment variable?" && exit 1
    cd gh-pages
    cp -R ${TRAVIS_BUILD_DIR}/book/* .
    git add .
    git -c user.name='travis' -c user.email='travis' commit -m "update documentation for version ${SHORT_VERSION}"
    echo "pushing to gh-pages to https://github.com/{TRAVIS_REPO_SLUG}"
    git push -q https://$GITHUB_API_KEY@github.com/{TRAVIS_REPO_SLUG} gh-pages &>/dev/null || echo "Git push failed. Did you use the correct value for the GITHUB_API_KEY environment variable?" && exit 1
    cd "$TRAVIS_BUILD_DIR"
else
	echo "Cannot deploy documentation because GITHUB_API_KEY environment variable is not set"
	exit 1
fi
