#!/bin/bash
set -e
set -o noclobber

# Import smitty.
source script/functions

say Create puppetmaster image.
pushd puppetserver
cp -r ../ssl .
smitty docker build --rm --no-cache -t jumanjiman/puppetserver .
popd
