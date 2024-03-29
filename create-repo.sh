#!/usr/bin/env bash

set -e

echo "$GPG_KEY" | gpg --import
cd /repo/packages
rm -rf repodata
createrepo --database --compatibility .
gpg --detach-sign --armor repodata/repomd.xml
