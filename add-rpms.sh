#!/usr/bin/env bash

set -e

export DOCKER_DEFAULT_PLATFORM=linux/amd64

APP="$1"
VERSION="$2"
DISTFOLDER="$3"

docker build -t yum-deploy:local .

rm -rf packages
mkdir -p packages
cat _redirects | grep 'https' | awk '{print $2}' | while read link; do
	curl -L -o "packages/$(basename "$link")" "$link"
done

ls "$DISTFOLDER" | grep '.rpm' | while read file; do
	echo "/packages/${file} https://github.com/dustinblackman/${APP}/releases/download/v${VERSION}/${file} 302" >>_redirects
done

cp -r "$DISTFOLDER"/*.rpm ./packages

docker run -it -e "GPG_KEY=$(cat ~/.gpg/yum-private.key)" -v "$PWD:/repo" yum-deploy:local

git add .
git commit -m "add $APP $VERSION"
git push
