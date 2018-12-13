#!/usr/bin/env bash

# rails new myrails

cp files/mime_types.rb myrails/config/initializers/mime_types.rb
cp files/sample_controller.rb myrails/app/controllers/sample_controller.rb
cp files/routes.rb myrails/config/routes.rb

mkdir myrails/app/views/sample
cp files/*.{erb,ruby} myrails/app/views/sample/

grep -q -F 'gem "victor"' myrails/Gemfile || echo 'gem "victor"' >> myrails/Gemfile
