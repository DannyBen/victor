Dynamic SVG Rendering in Rails
==================================================

Using Victor to dynamically render SVG in rails is easy, and can be done
in several ways. This guide and associated files demonstrate how to render
SVG images inline (as part of the HTML), or as separate SVG images.

Quick Start
--------------------------------------------------

If you wish to quickly dive into the action, you can use the 
`create_example.sh` script to generate a new rails app:

    $ ./create_example.sh
    $ cd myrails
    $ rails server

Then go to <http://localhost:3000/sample/demo>.

This guide assumes you have already included `gem "victor"` in your Rails 
`Gemfile`.


Inline SVG Rendering
--------------------------------------------------

### Step 1: Create the SVG partial view

```ruby
# app/views/sample/_circle.svg.ruby
svg = Victor::SVG.new template: :html, width: 100, height: 100
svg.circle cx: 50, cy: 50, r: 30, fill: color
svg.render
```

### Step 2: Render the view from any other view

```ruby
# app/views/sample/demo.html.erb
<%== render 'circle.svg', color: 'yellow' %>
```


Render SVG Using Image Tag and Controller
--------------------------------------------------

### Step 1: Configure SVG mime type

```ruby
# config/initializers/mime_types.rb
Mime::Type.register "image/svg+xml", :svg
```

### Step 2: Create a route

```ruby
# config/routes.rb
Rails.application.routes.draw do
  get 'sample/square', format: :svg
end
```

### Step 3: Add a controller action

You can either create a new controller, or add another method to an existing
controller.

```ruby
# app/controllers/sample_controller.rb
class SampleController < ApplicationController
  def square
    @params = params.permit(:color)
  end
end
```

### Step 4: Create the SVG view

```ruby
# app/views/sample/square.svg.ruby
color = @params[:color]

svg = Victor::SVG.new width: 100, height: 100
svg.rect x: 20, y: 20, width: 60, height: 60, fill: color
svg.render
```

### Step 5: Reference the SVG from other views

```html
<img src='/sample/square.svg?color=blue'>
```
