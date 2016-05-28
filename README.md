Victor - Ruby SVG Image Builder
==================================================

[![Gem](https://img.shields.io/gem/v/victor.svg?style=flat-square)](https://rubygems.org/gems/victor)
[![Travis](https://img.shields.io/travis/DannyBen/victor.svg?style=flat-square)](https://travis-ci.org/DannyBen/victor)
[![Code Climate](https://img.shields.io/codeclimate/github/DannyBen/victor.svg?style=flat-square)](https://codeclimate.com/github/DannyBen/victor)
[![Gemnasium](https://img.shields.io/gemnasium/DannyBen/victor.svg?style=flat-square)](https://gemnasium.com/DannyBen/victor)

---

Victor is a direct Ruby-to-SVG builder. All method calls are converted
directly to SVG elements.

---

Install
--------------------------------------------------

```
$ gem install victor
```

Or with bundler:

```ruby
gem 'victor'
```

Examples
--------------------------------------------------

See the [examples] folder for several ruby scripts and their SVG output.


Usage
--------------------------------------------------

Initialize your SVG image:

```ruby
require 'victor'
svg = SVG.new
```

Any option you provide to `SVG.new` will be added as an attribute to the
main `<svg>` element. By default, `height` and `width` are set to 100%.

```ruby
svg = SVG.new width: '100%', height: '100%'
# same as just SVG.new

svg = SVG.new width: '100%', height: '100%', viewBox: "0 0 200 100"
```

Victor uses a single method (`element`) to generate all SVG elements:

```ruby
svg.element :rect, x: 2, y: 2, width: 200, height: 200
# => <rect x="2" y="2" width="200" height="200"/>
```

But you can omit it. Calls to any other method, will be delegated to the 
`element` method, so normal usage looks more like this:

```ruby
svg.rect x: 2, y: 2, width: 200, height: 200
# => <rect x="2" y="2" width="200" height="200"/>
```

You can use the `build` method, to generate the SVG with a block

```ruby
svg.build do 
  rect x: 0, y: 0, width: 100, height: 100, fill: '#ccc'
  rect x: 20, y: 20, width: 60, height: 60, fill: '#f99'
end
```

If the value of an attribute is a hash, it will be converted to a 
style-compatible string:

```ruby
svg.rect x: 0, y: 0, width: 100, height: 100, style: { stroke: '#ccc', fill: 'red' }
# => <rect x=0 y=0 width=100 height=100 style="stroke:#ccc; fill:red"/>
```

If the value of an attribute is an array, it will be converted to a 
space delimited string:

```ruby
svg.path ['M', 150, 0, 'L', 75, 200, 'L', 225, 200, 'Z']
# => <rect x=0 y=0 width=100 height=100 style="stroke:#ccc; fill:red"/>
```


For SVG elements that have an inner content - such as text - simply pass it as 
the first argument:

```ruby
svg.text "Victor", x: 40, y: 50
# => <text x="40" y="50">Victor</text>
```

Underscores in attribute names are converted to dashes:

```ruby
svg.text "Victor", x: 40, y: 50, font_family: 'arial', font_weight: 'bold', font_size: 40
# => <text x="40" y="50" font-family="arial" font-weight="bold" font-size="40">
#      Victor
#    </text>
```

Saving the Output
--------------------------------------------------

Generate the full SVG to a string with `render`:

```ruby
result = svg.render
```

Or, save it to a file with `save`:

```ruby
svg.save 'filename'
# the '.svg' extension is optional
```

SVG Templates
--------------------------------------------------

The `:default` SVG template is designed to be a full XML document (i.e., 
a standalone SVG image). If you wish to use the output as an SVG element 
inside HTML, you can change the SVG template:

```ruby
svg = SVG.new template: :html 
# accepts :html, :default or a filename
```

You can also point it to any other template file:

```ruby
svg = SVG.new template: 'path/to/template.svg'
```

See the [templates] folder for an understanding of how templates are 
structured.


CSS
--------------------------------------------------

To add a CSS to your SVG, simply use the `css` command inside your `build` 
block, like this:

```ruby
svg = SVG.new

svg.build do 
  css['.main'] = {
    stroke: "green", 
    stroke_width: 2,
    fill: "yellow"
  }

  circle cx: 35, cy: 35, r: 20, class: 'main'
end
```

Underscore characters will be converted to dashes (`stroke_width` becomes 
`stroke-width`).

---

[examples]: https://github.com/DannyBen/victor/tree/master/examples#examples
[templates]: https://github.com/DannyBen/victor/tree/master/lib/victor/templates
