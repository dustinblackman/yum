#!/usr/bin/env bash

set -e

echo "$GPG_KEY" | gpg --import
cd /repo/packages
rpm --addsign *.rpm
rm -rf repodata
createrepo .
gpg --detach-sign --armor repodata/repomd.xml
