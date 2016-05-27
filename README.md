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

Victor uses a single method (`element`) to generate all SVG elements:

```ruby
require 'victor'
svg = SVG.new

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
  rect x: 0, y: 0, width: 100, height: 100, style: { fill: '#ccc' }
  rect x: 20, y: 20, width: 60, height: 60, style: { fill: '#f99' }
end
```

Generate the SVG to a string with `render`:

```ruby
result = svg.render
```

Or, save it to a file with `save`:

```ruby
svg.save 'filename'
# the '.svg' extension is optional
```


---

[examples]: https://github.com/DannyBen/victor/tree/master/examples
