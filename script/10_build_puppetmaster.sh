#!/bin/bash
set -e
set -o noclobber

# Import smitty.
source script/functions

say Create puppetmaster image.
pushd puppetmaster
cp -r ../ssl .
smitty docker build --rm -t jumanjiman/puppetmaster . 2>&1 | tee /tmp/build-puppetmaster.out
popd
