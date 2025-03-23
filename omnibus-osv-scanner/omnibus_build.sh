#!/usr/bin/env bash

set -eux

PROJECT="osv-scanner"

cd /$PROJECT/omnibus-$PROJECT

bundle install --binstubs
#erb "/$PROJECT/omnibus-$PROJECT/config/projects/$PROJECT.erb" > "/$PROJECT/omnibus-$PROJECT/config/projects/$PROJECT.rb"
export OMNIBUS_SKIP_HEALTHCHECK=true
omnibus build $PROJECT
