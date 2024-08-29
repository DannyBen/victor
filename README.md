<div align='center'>
<img src='assets/logo.svg' width=500>

# Victor - Ruby SVG Image Builder

[![Gem Version](https://badge.fury.io/rb/victor.svg)](https://badge.fury.io/rb/victor)
[![Build Status](https://github.com/DannyBen/victor/workflows/Test/badge.svg)](https://github.com/DannyBen/victor/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/85cc05c219d6d233ab78/maintainability)](https://codeclimate.com/github/DannyBen/victor/maintainability)

## [victor.dannyb.co](https://victor.dannyb.co)

</div>

---

**Victor** is a lightweight, zero-dependencies Ruby library that lets you build
SVG images using Ruby code.

---

## Install

```
$ gem install victor
```

## Example

<table><tr><td width="250">

<img src='assets/ghost.svg' width=250>

</td><td>

```ruby
setup viewBox: '0 0 100 100'

build do
  rect x: 0, y: 0, width: 100, height: 100, fill: :white
  circle cx: 50, cy: 50, r: 40, fill: 'yellow'
  rect x: 10, y: 50, width: 80, height: 50, fill: :yellow

  [25, 50].each do |x|
    circle cx: x, cy: 40, r: 8, fill: :white
  end

  path fill: 'white', d: %w[
    M11 100 l13 -15 l13 15 l13 -15 
    l13 15 l13 -15 l13 15 Z
  ]
end
```

</td></tr></table>


## Documentation

- [Victor Homepage][docs]

## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues] or
[start a discussion][discussions].

[issues]: https://github.com/DannyBen/victor/issues
[discussions]: https://github.com/DannyBen/victor/discussions
[docs]: https://victor.dannyb.co/
