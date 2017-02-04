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

```ruby
require 'victor'

svg = SVG.new width: 140, height: 100, style: { background: '#ddd' }

svg.build do 
  rect x: 10, y: 10, width: 120, height: 80, rx: 10, fill: '#666'
  
  circle cx: 50, cy: 50, r: 30, fill: 'yellow'
  circle cx: 58, cy: 32, r: 4, fill: 'black'
  polygon points: %w[45,50 80,30 80,70], fill: '#666'

  3.times do |i|
    x = 80 + i*18
    circle cx: x, cy: 50, r: 4, fill: 'yellow'
  end
end

svg.save 'pacman'
```

Output:

[![pacman](https://cdn.rawgit.com/DannyBen/victor/master/examples/09_pacman.svg)](https://github.com/DannyBen/victor/blob/master/examples/09_pacman.rb)


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

In other words, these are the same:

```ruby
svg.element :anything, option: 'value'
svg.anything option: 'value'
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
svg.path d: ['M', 150, 0, 'L', 75, 200, 'L', 225, 200, 'Z']
# => <path d="M 159 9 L 75 200 L 225 200 Z"/>
```

For SVG elements that have an inner content - such as text - simply pass it as 
the first argument:

```ruby
svg.text "Victor", x: 40, y: 50
# => <text x="40" y="50">Victor</text>
```

You can also nest elements with blocks:

```ruby
svg.build do
  g font_size: 30, font_family: 'arial', fill: 'white' do
    text "Scalable Victor Graphics", x: 40, y: 50
  end
end
# => <g font-size="30" font-family="arial" fill="white">
#      <text x="40" y="50">Scalable Victor Graphics</text>
#    </g>
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

You can also set CSS by providing a hash:

```ruby
svg.css = {
  '.bar': {
    fill: '#666',
    stroke: '#fff',
    stroke_width: 1
  },
  '.negative': {
    fill: '#f66'
  },
  '.positive': {
    fill: '#6f6'
  }
}
```

Underscore characters will be converted to dashes (`stroke_width` becomes 
`stroke-width`).


If you need to add CSS statements , like `@import`, use the following syntax:

```ruby
css['@import'] = [
  "url('https://fonts.googleapis.com/css?family=Audiowide')",
  "url('https://fonts.googleapis.com/css?family=Pacifico')"
]
```

When the value of the CSS attribute is an array, Victor will simply use
the values of the array and prefix each of them with the key, so the above 
will result in two `@import url(...)` rows.

See the [custom fonts example](https://github.com/DannyBen/victor/tree/master/examples#12-custom-fonts)


---

[examples]: https://github.com/DannyBen/victor/tree/master/examples#examples
[templates]: https://github.com/DannyBen/victor/tree/master/lib/victor/templates
