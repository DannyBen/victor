#!/usr/bin/env bash

# Create a new rails app in the 'myrails' folder.
rails new myrails \
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-text \
  --skip-active-record \
  --skip-active-storage \
  --skip-action-cable \
  --skip-sprockets \
  --skip-spring \
  --skip-listen \
  --skip-javascript \
  --skip-turbolinks \
  --skip-test \
  --skip-system-test \
  --skip-bootsnap \
  --skip-webpack-install

# Copy files to the relevant places
cp files/mime_types.rb myrails/config/initializers/mime_types.rb
cp files/sample_controller.rb myrails/app/controllers/sample_controller.rb
cp files/routes.rb myrails/config/routes.rb
mkdir myrails/app/views/sample
cp files/*.{erb,ruby} myrails/app/views/sample/

# Add 'gem "victor"' to the Gemfile unless it is there already
pushd ./myrails
bundle add victor
popd

