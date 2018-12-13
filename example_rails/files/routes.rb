# config/routes.rb
Rails.application.routes.draw do
  # Route to the demo page that contains both inline and referencesd SVG
  get 'sample/demo'

  # Route to an SVG image
  get 'sample/square', format: :svg
end
