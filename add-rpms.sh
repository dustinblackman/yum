#!/usr/bin/env bash

set -e

APP="$1"
VERSION="$2"
DISTFOLDER="$3"

docker build -t yum-deploy:local .

cat _redirects | grep 'https' | awk '{print $2}' | while read link; do
	curl -L -o "packages/$(basename "$link")" "$link"
done

cp -r "$DISTFOLDER"/*.rpm ./packages

docker run -it -e "GPG_KEY=$(cat ~/.gpg/yum-private.key)" -v "$PWD:/repo" yum-deploy:local

git add .
git commit -m "add $APP $VERSION"
git push
