# Examples

## 01 hello world

```ruby
require 'victor'

svg = SVG.new

svg.build do 
  rect x: 0, y: 0, width: 100, height: 100, style: { fill: '#ccc' }
  rect x: 20, y: 20, width: 60, height: 60, style: { fill: '#f99' },
    transform: "rotate(10 40 40)"
end

# If you want the XML itself:
result = svg.render

# If you want to save:
svg.save '01_hello_world'
```

[![01_hello_world](https://cdn.rawgit.com/DannyBen/victor/master/examples/01_hello_world.svg)](https://github.com/DannyBen/victor/blob/master/examples/01_hello_world.rb)


## 02 element

```ruby
require 'victor'

svg = SVG.new

# These two are the same
svg.element :rect, x: 2, y: 2, width: 200, height: 200, fill: '#ddd'
svg.rect x: 2, y: 2, width: 200, height: 200, fill: '#ddd'

p svg.content

# => ["<rect x=\"2\" y=\"2\" width=\"200\" height=\"200\" fill=\"#ddd\"/>", 
#     "<rect x=\"2\" y=\"2\" width=\"200\" height=\"200\" fill=\"#ddd\"/>"]
```



## 03 shapes

```ruby
require 'victor'

svg = SVG.new width: 202, height: 204

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

[![03_shapes](https://cdn.rawgit.com/DannyBen/victor/master/examples/03_shapes.svg)](https://github.com/DannyBen/victor/blob/master/examples/03_shapes.rb)


## 04 path

```ruby
require 'victor'

svg = SVG.new width: 200, height: 200 

svg.build do 
  rect x: 0, y: 0, width: 200, height: 200, fill: '#ddd'

  path d: "M100,90 q  180 -140 0 70", fill: 'red'
  path d: "M100,90 q -180 -140 0 70", fill: 'red'
end

svg.save '04_path'
```

[![04_path](https://cdn.rawgit.com/DannyBen/victor/master/examples/04_path.svg)](https://github.com/DannyBen/victor/blob/master/examples/04_path.rb)


## 05 path as array

```ruby
require 'victor'

svg = SVG.new width: 200, height: 200 

svg.build do 
  rect x: 0, y: 0, width: 200, height: 200, fill: '#ddd'

  path d: ['M', 100,90, 'q',  180, -140, 0, 70], fill: 'red'
  path d: ['M', 100,90, 'q', -180, -140, 0, 70], fill: 'red'
end

svg.save '05_path_as_array'
```

[![05_path_as_array](https://cdn.rawgit.com/DannyBen/victor/master/examples/05_path_as_array.svg)](https://github.com/DannyBen/victor/blob/master/examples/05_path_as_array.rb)


## 06 text

```ruby
require 'victor'

svg = SVG.new viewBox: "0 0 700 70"

svg.rect x: 0, y: 0, width: 700, height: 70, fill: '#ddd'
svg.text "Victor", x: 100, y: 50, font_family: 'arial', font_weight: 'bold', font_size: 40, fill: 'blue'

svg.save '06_text'
```

[![06_text](https://cdn.rawgit.com/DannyBen/victor/master/examples/06_text.svg)](https://github.com/DannyBen/victor/blob/master/examples/06_text.rb)


## 07 nested

```ruby
require 'victor'

svg = SVG.new width: 420, height: 80

svg.build do
  rect x: 0, y: 0, width: 420, height: 80, fill: '#666'

  g font_size: 30, font_family: 'arial', fill: 'white' do
    text "Scalable Victor Graphics", x: 40, y: 50
  end
end

svg.save '07_nested'
```

[![07_nested](https://cdn.rawgit.com/DannyBen/victor/master/examples/07_nested.svg)](https://github.com/DannyBen/victor/blob/master/examples/07_nested.rb)


## 08 css

```ruby
require 'victor'

svg = SVG.new width: 200, height: 200, viewBox: "0 0 70 70", 
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

[![08_css](https://cdn.rawgit.com/DannyBen/victor/master/examples/08_css.svg)](https://github.com/DannyBen/victor/blob/master/examples/08_css.rb)


## 09 pacman

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

svg.save '09_pacman'
```

[![09_pacman](https://cdn.rawgit.com/DannyBen/victor/master/examples/09_pacman.svg)](https://github.com/DannyBen/victor/blob/master/examples/09_pacman.rb)


## 10 animation

```ruby
require 'victor'

svg = SVG.new width: 140, height: 100, style: { background: '#ddd' }

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

[![10_animation](https://cdn.rawgit.com/DannyBen/victor/master/examples/10_animation.svg)](https://github.com/DannyBen/victor/blob/master/examples/10_animation.rb)



---

This file was generated automatically with `run examples readme`.