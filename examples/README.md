# Examples

## 01 hello world

```ruby
require 'victor'

svg = Victor::SVG.new

svg.build do 
  rect x: 0, y: 0, width: 100, height: 100, style: { fill: '#ccc' }
  rect x: 20, y: 20, width: 60, height: 60, style: { fill: '#f99' },
    transform: "rotate(10 40 40)"
end

# If you want the XML itself:
result = svg.render

# If you want the XML without the surrounding template:
result = svg.to_s

# If you want to save:
svg.save '01_hello_world'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/01_hello_world.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/01_hello_world.svg)

[![01_hello_world](https://cdn.rawgit.com/DannyBen/victor/master/examples/01_hello_world.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/01_hello_world.svg)


## 02 element

```ruby
require 'victor'

svg = Victor::SVG.new

# These two are the same
svg.element :rect, x: 2, y: 2, width: 200, height: 200, fill: '#ddd'
svg.rect x: 2, y: 2, width: 200, height: 200, fill: '#ddd'

p svg.content

# => ["<rect x=\"2\" y=\"2\" width=\"200\" height=\"200\" fill=\"#ddd\"/>", 
#     "<rect x=\"2\" y=\"2\" width=\"200\" height=\"200\" fill=\"#ddd\"/>"]
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/02_element.rb)



## 03 shapes

```ruby
require 'victor'

svg = Victor::SVG.new width: 202, height: 204

style = {
  stroke: 'yellow',
  stroke_width: 4
}

svg.build do 
  rect x: 2, y: 2, width: 200, height: 200, fill: '#fcc', style: style
  circle cx: 60, cy: 50, r: 30, style: style, fill: 'red'
  ellipse cx: 100, cy: 140, rx: 80, ry: 20, style: style, fill: 'green'
  line x1: 100, y1: 60, x2: 110, y2: 100, style: style
  polygon points: "150,20 180,80 120,80", fill: 'blue', style: style
end

svg.save '03_shapes'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/03_shapes.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/03_shapes.svg)

[![03_shapes](https://cdn.rawgit.com/DannyBen/victor/master/examples/03_shapes.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/03_shapes.svg)


## 04 path

```ruby
require 'victor'

svg = Victor::SVG.new width: 200, height: 200 

svg.build do 
  rect x: 0, y: 0, width: 200, height: 200, fill: '#ddd'

  path d: "M100,90 q  180 -140 0 70", fill: 'red'
  path d: "M100,90 q -180 -140 0 70", fill: 'red'
end

svg.save '04_path'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/04_path.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/04_path.svg)

[![04_path](https://cdn.rawgit.com/DannyBen/victor/master/examples/04_path.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/04_path.svg)


## 05 path as array

```ruby
require 'victor'

svg = Victor::SVG.new width: 200, height: 200 

svg.build do 
  rect x: 0, y: 0, width: 200, height: 200, fill: '#ddd'

  path d: ['M', 100,90, 'q',  180, -140, 0, 70], fill: 'red'
  path d: ['M', 100,90, 'q', -180, -140, 0, 70], fill: 'red'
end

svg.save '05_path_as_array'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/05_path_as_array.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/05_path_as_array.svg)

[![05_path_as_array](https://cdn.rawgit.com/DannyBen/victor/master/examples/05_path_as_array.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/05_path_as_array.svg)


## 06 text

```ruby
require 'victor'

svg = Victor::SVG.new viewBox: "0 0 700 70"

svg.rect x: 0, y: 0, width: 700, height: 70, fill: '#ddd'
svg.text "Victor", x: 100, y: 50, font_family: 'arial', font_weight: 'bold', font_size: 40, fill: 'blue'

svg.save '06_text'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/06_text.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/06_text.svg)

[![06_text](https://cdn.rawgit.com/DannyBen/victor/master/examples/06_text.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/06_text.svg)


## 07 nested

```ruby
require 'victor'

svg = Victor::SVG.new width: 420, height: 80

svg.build do
  rect x: 0, y: 0, width: 420, height: 80, fill: '#666'

  g font_size: 30, font_family: 'arial', fill: 'white' do
    text "Scalable Victor Graphics", x: 40, y: 50
  end
end

svg.save '07_nested'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/07_nested.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/07_nested.svg)

[![07_nested](https://cdn.rawgit.com/DannyBen/victor/master/examples/07_nested.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/07_nested.svg)


## 08 css

```ruby
require 'victor'

svg = Victor::SVG.new width: 200, height: 200, viewBox: "0 0 70 70", 
  style: { background: '#eee' }

svg.build do 
  css['.main'] = {
    stroke: "green", 
    stroke_width: 2,
    fill: "yellow",
    opacity: 0.7
  }

  rect x: 5, y: 5, width: 60, height: 60, class: 'main'
  circle cx: 35, cy: 35, r: 20, class: 'main'
end

svg.save '08_css.svg'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/08_css.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/08_css.svg)

[![08_css](https://cdn.rawgit.com/DannyBen/victor/master/examples/08_css.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/08_css.svg)


## 09 pacman

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

svg.save '09_pacman'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/09_pacman.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/09_pacman.svg)

[![09_pacman](https://cdn.rawgit.com/DannyBen/victor/master/examples/09_pacman.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/09_pacman.svg)


## 10 animation

```ruby
require 'victor'

svg = Victor::SVG.new width: 140, height: 100, style: { background: '#ddd' }

def animation
  css[".mouth"] = {
    animation: "blink 0.5s step-start 0s infinite"
  }

  css[".candy"] = {
    animation: "move 0.6s 0s infinite"
  }

  css["@keyframes blink"] = {
    "50%": { opacity: 0 }
  }

  css["@keyframes move"] = {
    "100%": { transform: "translate(-70px, 0)" }
  }
end

def pacman
  circle cx: 50, cy: 50, r: 30, fill: 'yellow'
  circle cx: 58, cy: 32, r: 4, fill: 'black'
  polygon points: %w[45,50 80,30 80,70], fill: '#666', class: 'mouth'

  circle cx: 100, cy: 50, r: 6, fill: 'yellow', class: 'candy'
end

svg.build do 
  rect x: 10, y: 10, width: 100, height: 80, fill: '#666'
  animation
  pacman
end

svg.save '10_animation'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/10_animation.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/10_animation.svg)

[![10_animation](https://cdn.rawgit.com/DannyBen/victor/master/examples/10_animation.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/10_animation.svg)


## 11 def pattern

```ruby
require 'victor'

svg = Victor::SVG.new width: 300, height: 300, viewBox:"0 0 400 300"

svg.build do
  
  # Define a reusable pattern using SVG <defs>
  defs do
    pattern id: "Pattern", x: "0", y: "0", width: "75", height: "50", patternUnits: "userSpaceOnUse" do
      rect x: "0" , y: "0", width: "25", height: "50", fill: "black"
      rect x: "25", y: "0", width: "25", height: "50", fill: "red"
      rect x: "50", y: "0", width: "25", height: "50", fill: "yellow"
    end
  end

  # Use the pattern as a background fill for two shapes
  rect fill: "url(#Pattern)", stroke: "black", x: "0", y: "0", width: "300", height: "150"
  circle fill: "url(#Pattern)", stroke: "black", cx: "150", cy: "150", r: "100",
    transform: 'rotate(90 150 150)'
end

# Save it
svg.save '11_def_pattern'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/11_def_pattern.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/11_def_pattern.svg)

[![11_def_pattern](https://cdn.rawgit.com/DannyBen/victor/master/examples/11_def_pattern.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/11_def_pattern.svg)


## 12 custom fonts

```ruby
require 'victor'

svg = Victor::SVG.new width: 300, height: 180, viewBox:"0 0 300 180"

svg.build do
  
  # Whenever the value of a CSS entry is an array, each item in the
  # array will simply be placed after the key,separated by a space
  # so this will create two '@import url(...)' statements.
  css['@import'] = [
    "url('https://fonts.googleapis.com/css?family=Audiowide')",
    "url('https://fonts.googleapis.com/css?family=Pacifico')"
  ]

  rect x: 0, y: 0, width: '100%', height: '100%', fill: '#779'

  svg.text "Custom Fonts?", text_anchor: :middle, x: '50%', y: 50, 
    font_family: 'Audiowide', font_size: 30, fill: :white

  svg.text "No problem!", text_anchor: :middle, x: '50%', y: 100, 
    font_family: 'Pacifico', font_size: 30

  svg.text "this example does not work", 
    text_anchor: :middle, x: '50%', y: 140, 
    font_family: 'arial', font_size: 16

  svg.text "when embedded in HTML", 
    text_anchor: :middle, x: '50%', y: 160, 
    font_family: 'arial', font_size: 16
end

svg.save '12_custom_fonts'
```

[Open Source Ruby File](https://github.com/DannyBen/victor/blob/master/examples/12_custom_fonts.rb) | [Open Image](https://cdn.rawgit.com/DannyBen/victor/master/examples/12_custom_fonts.svg)

[![12_custom_fonts](https://cdn.rawgit.com/DannyBen/victor/master/examples/12_custom_fonts.svg)](https://cdn.rawgit.com/DannyBen/victor/master/examples/12_custom_fonts.svg)



---

This file was generated automatically with `run examples readme`.