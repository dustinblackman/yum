#!/usr/bin/env bash

set -e

echo "$GPG_KEY" | gpg --import
cd /repo/packages
rpm --addsign *.rpm
rm -rf repodata
createrepo_c --database --compatibility .
gpg --detach-sign --armor repodata/repomd.xml
