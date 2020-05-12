![Victor](/examples//15_victor_logo.svg)

# Victor - Ruby SVG Image Builder

[![Gem Version](https://badge.fury.io/rb/victor.svg)](https://badge.fury.io/rb/victor)
[![Build Status](https://github.com/DannyBen/victor/workflows/Test/badge.svg)](https://github.com/DannyBen/victor/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/85cc05c219d6d233ab78/maintainability)](https://codeclimate.com/github/DannyBen/victor/maintainability)

---

Victor is a direct Ruby-to-SVG builder. All method calls are converted
directly to SVG elements.

![Demo](assets/animated.gif)

---

## Table of Contents

* [Install](#install)
* [Examples](#examples)
* [Usage](#usage)
* [Features](#features)
  * [Composite SVG](#composite-svg)
  * [Saving the Output](#saving-the-output)
  * [SVG Templates](#svg-templates)
  * [CSS](#css)
  * [Tagless Elements](#tagless-elements)
  * [XML Encoding](#xml-encoding)
  * [DSL Syntax](#dsl-syntax)
* [Using with Rails](#using-with-rails)
* [Related Projects](#related-projects)
* [Contributing / Support](#contributing--support)

---

## Install

```
$ gem install victor
```

Or with bundler:

```ruby
gem 'victor'
```

## Examples

```ruby
require 'victor'

svg = Victor::SVG.new width: 140, height: 100, style: { background: '#ddd' }

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


## Usage

Initialize your SVG image:

```ruby
require 'victor'
svg = Victor::SVG.new
```

Any option you provide to `SVG.new` will be added as an attribute to the
main `<svg>` element. By default, `height` and `width` are set to 100%.

```ruby
svg = Victor::SVG.new width: '100%', height: '100%'
# same as just Victor::SVG.new

svg = Victor::SVG.new width: '100%', height: '100%', viewBox: "0 0 200 100"
```

As an alternative, you can set the root SVG attributes using the `setup` method:

```ruby
require 'victor'
svg = Victor::SVG.new
svg.setup width: 200, height: 150
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

## Features

### Composite SVG

Victor also supports the abiliy to combine several smaller SVG objects into 
one using the `<<` operator or the `#append` method. 

This operator expects to receive any object that responds to `#to_s` (can be another `SVG` object).

```ruby
require 'victor'
include Victor

# Create a reusable SVG object
frame = SVG.new
frame.rect x: 0, y: 0, width: 100, height: 100, fill: '#336'
frame.rect x: 10, y: 10, width: 80, height: 80, fill: '#fff'

# ... and another
troll = SVG.new
troll.circle cx: 50, cy: 60, r: 24, fill: 'yellow'
troll.polygon points: %w[24,50 50,14 76,54], fill: 'red'

# Combine objects into a single image
svg = SVG.new viewBox: '0 0 100 100'
svg << frame
svg << troll

# ... and save it
svg.save 'framed-troll'
```

Output:

[![troll](https://cdn.rawgit.com/DannyBen/victor/master/examples/13_composite_svg.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/13_composite_svg.svg)

These two calls are identical:

```ruby
svg << other
svg.append other
```

To make this common use case a little easier to use, you can use a block when instantiating a new `SVG` object:

```ruby
troll = SVG.new do
  circle cx: 50, cy: 60, r: 24, fill: 'yellow'
end
```

Which is the same as:

```ruby
troll = SVG.new
troll.build do
  circle cx: 50, cy: 60, r: 24, fill: 'yellow'
end
```

Another approach to a more modular SVG composition, would be to subclass 
`Victor::SVG`.

See the [composite svg example](https://github.com/DannyBen/victor/tree/master/examples#13-composite-svg)
or the [subclassing example](https://github.com/DannyBen/victor/tree/master/examples#14-subclassing)
for more details.


### Saving the Output

Generate the full SVG to a string with `render`:

```ruby
result = svg.render
```

Or, save it to a file with `save`:

```ruby
svg.save 'filename'
# the '.svg' extension is optional
```

### SVG Templates

The `:default` SVG template is designed to be a full XML document (i.e., 
a standalone SVG image). If you wish to use the output as an SVG element 
inside HTML, you can change the SVG template:

```ruby
svg = Victor::SVG.new template: :html 
# accepts :html, :minimal, :default or a filename
```

You can also point it to any other template file:

```ruby
svg = Victor::SVG.new template: 'path/to/template.svg'
```

See the [templates] folder for an understanding of how templates are 
structured.

Templates can also be provided when rendering or saving the output:

```ruby
svg.save 'filename', template: :minimal
svg.render template: :minimal
```


### CSS

To add a CSS to your SVG, simply use the `css` command inside your `build` 
block, like this:

```ruby
svg = Victor::SVG.new

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

See the [custom fonts example](https://github.com/DannyBen/victor/tree/master/examples#12-custom-fonts).


### Tagless Elements

Using underscore (`_`) as the element name will simply add the value to the 
generated SVG, without any surrounding element. This is designed to allow
generating something like this:

```xml
<text>
  You are
  <tspan font-weight="bold">not</tspan>
  a banana
</text>
```

using this Ruby code:

```ruby
svg.build do 
  text do
    _ 'You are'
    tspan 'not', font_weight: "bold"
    _ 'a banana'
  end
end
```

See the [targless elements example](https://github.com/DannyBen/victor/tree/master/examples#16-tagless-elements).


### XML Encoding

Plain text values are encoded automatically:

```ruby
svg.build do
  text "Ben & Jerry's"
end
# <text>Ben &amp; Jerry's</text>
```

If you need to use the raw, unencoded string, add `!` to the element's name:

```ruby
svg.build do
  text! "Ben & Jerry's"
end
# <text>Ben & Jerry's</text>
```

See the [xml encoding example](https://github.com/DannyBen/victor/tree/master/examples#17-xml-encoding).

### DSL Syntax

Victor also supports a DSL-like syntax. To use it, simply `require 'victor/script'`.

Once required, you have access to:

- `svg` - returns an instance of `Victor::SVG`
- All the methods that are available on the `SVG` object, are included at the root level.

For example:

```ruby
require 'victor/script'

setup width: 100, height: 100

build do
  circle cx: 50, cy: 50, r: 30, fill: "yellow"
end

puts render
save 'output.svg'
```

See the [dsl example](https://github.com/DannyBen/victor/tree/master/examples#18-dsl).

## Using with Rails

See the [example_rails](example_rails) folder.


## Related Projects

### [Victor CLI][victor-cli]

A command line utility that allows converting Ruby to SVG as well as SVG to
Victor Ruby scripts.

### [Victor Opal][victor-opal]

A Victor playground that works in the browser.

### [Icodi][icodi]

A Ruby gem that uses Victor to generate consistent random icon 
images, similar to GitHub's identicon.

[![Icodi](assets/icodi.svg)][icodi]


## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

---

[examples]: https://github.com/DannyBen/victor/tree/master/examples#examples
[templates]: https://github.com/DannyBen/victor/tree/master/lib/victor/templates
[icodi]: https://github.com/DannyBen/icodi
[victor-opal]: https://kuboon.github.io/victor-opal/
[victor-cli]:  https://github.com/DannyBen/victor-cli
[issues]: https://github.com/DannyBen/victor/issues
