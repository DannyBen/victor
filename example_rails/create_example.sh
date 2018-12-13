#!/usr/bin/env bash

# Create a new rails app in the 'myrails' folder.
rails new myrails

# Copy files to the relevant places
cp files/mime_types.rb myrails/config/initializers/mime_types.rb
cp files/sample_controller.rb myrails/app/controllers/sample_controller.rb
cp files/routes.rb myrails/config/routes.rb
mkdir myrails/app/views/sample
cp files/*.{erb,ruby} myrails/app/views/sample/

# Add 'gem "victor"' to the Gemfile unless it is there already
grep -q -F 'gem "victor"' myrails/Gemfile || echo 'gem "victor"' >> myrails/Gemfile
