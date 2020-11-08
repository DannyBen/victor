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

[View Source Ruby File](01_hello_world.rb) | [View Image](01_hello_world.svg)

[![01_hello_world](01_hello_world.svg)](01_hello_world.svg)


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

[View Source Ruby File](02_element.rb)



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

[View Source Ruby File](03_shapes.rb) | [View Image](03_shapes.svg)

[![03_shapes](03_shapes.svg)](03_shapes.svg)


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

[View Source Ruby File](04_path.rb) | [View Image](04_path.svg)

[![04_path](04_path.svg)](04_path.svg)


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

[View Source Ruby File](05_path_as_array.rb) | [View Image](05_path_as_array.svg)

[![05_path_as_array](05_path_as_array.svg)](05_path_as_array.svg)


## 06 text

```ruby
require 'victor'

svg = Victor::SVG.new viewBox: "0 0 700 70"

svg.rect x: 0, y: 0, width: 700, height: 70, fill: '#ddd'
svg.text "Victor", x: 100, y: 50, font_family: 'arial', font_weight: 'bold', font_size: 40, fill: 'blue'

svg.save '06_text'
```

[View Source Ruby File](06_text.rb) | [View Image](06_text.svg)

[![06_text](06_text.svg)](06_text.svg)


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

[View Source Ruby File](07_nested.rb) | [View Image](07_nested.svg)

[![07_nested](07_nested.svg)](07_nested.svg)


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

[View Source Ruby File](08_css.rb) | [View Image](08_css.svg)

[![08_css](08_css.svg)](08_css.svg)


## 09 css string

```ruby
require 'victor'

svg = Victor::SVG.new width: 200, height: 200, viewBox: "0 0 70 70", 
  style: { background: '#eee' }

# This can be loaded from a file with `svg.css = File.read 'file.css'`
svg.css = <<CSS
  .main {
    stroke: green;
    stroke-width: 2;
    fill: yellow;
    opacity: 0.7;
  }
CSS

svg.build do 
  rect x: 5, y: 5, width: 60, height: 60, class: 'main'
  circle cx: 35, cy: 35, r: 20, class: 'main'
end

svg.save '09_css_string.svg'
```

[View Source Ruby File](09_css_string.rb) | [View Image](09_css_string.svg)

[![09_css_string](09_css_string.svg)](09_css_string.svg)


## 10 pacman

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

svg.save '10_pacman'
```

[View Source Ruby File](10_pacman.rb) | [View Image](10_pacman.svg)

[![10_pacman](10_pacman.svg)](10_pacman.svg)


## 11 animation

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

svg.save '11_animation'
```

[View Source Ruby File](11_animation.rb) | [View Image](11_animation.svg)

[![11_animation](11_animation.svg)](11_animation.svg)


## 12 def pattern

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
svg.save '12_def_pattern'
```

[View Source Ruby File](12_def_pattern.rb) | [View Image](12_def_pattern.svg)

[![12_def_pattern](12_def_pattern.svg)](12_def_pattern.svg)


## 13 custom fonts

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

svg.save '13_custom_fonts'
```

[View Source Ruby File](13_custom_fonts.rb) | [View Image](13_custom_fonts.svg)

[![13_custom_fonts](13_custom_fonts.svg)](13_custom_fonts.svg)


## 14 composite svg

```ruby
require 'victor'
include Victor

# Create two reusable objects: frame and troll
frame = SVG.new
frame.rect x: 0, y: 0, width: 100, height: 100, fill: '#336'
frame.rect x: 10, y: 10, width: 80, height: 80, fill: '#fff'

troll = SVG.new
troll.circle cx: 50, cy: 60, r: 24, fill: 'yellow'
troll.polygon points: %w[24,50 50,14 76,54], fill: 'red'

# Append the objects to a new SVG using the << operator
svg = SVG.new viewBox: '0 0 100 100', width: 100, height: 100
svg << frame
svg << troll

svg.save '14_composite_svg'
```

[View Source Ruby File](14_composite_svg.rb) | [View Image](14_composite_svg.svg)

[![14_composite_svg](14_composite_svg.svg)](14_composite_svg.svg)


## 15 subclassing

```ruby
require 'victor'

class Troll < Victor::SVG
  attr_reader :color, :hat_color

  def initialize(color: 'yellow', hat_color: 'red')
    # Accept parameters we care about, and call the super initializer
    @color, @hat_color = color, hat_color
    super width: 100, height: 100, viewBox: '0 0 100 100'

    # Generate the base image with the frame and head elements
    frame
    head
  end

  # Allow adding more elements after instantiation
  def add_nose
    circle cx: 50, cy: 65, r: 4, fill: 'black'
  end

  def frame
    rect x: 0, y: 0, width: 100, height: 100, fill: '#336'
    rect x: 10, y: 10, width: 80, height: 80, fill: '#fff'
  end

  def head
    circle cx: 50, cy: 60, r: 24, fill: color
    polygon points: %w[24,50 50,14 76,54], fill: hat_color
  end
end

troll = Troll.new color: '#33f', hat_color: '#3f3';
troll.add_nose
troll.save '15_subclassing'
```

[View Source Ruby File](15_subclassing.rb) | [View Image](15_subclassing.svg)

[![15_subclassing](15_subclassing.svg)](15_subclassing.svg)


## 16 victor logo

```ruby
#!/usr/bin/env ruby

require 'victor'
include Victor

# Style
color1 = "#2364aa"
color2 = "#3da5d9"
color3 = "#fec601"
color4 = "#ea7317"
color5 = "#73bfb8"
color6 = color1
style = { stroke: 'white', stroke_width: 3 }

# V
v = SVG.new
v.path d: "M0,0 h80 L40,100", fill: color1, style: style

# I
i = SVG.new
i.rect x: 0, y: 0, width: 30, height: 100, fill: color2, style: style

# C
c = SVG.new
c.build do
  g transform: "rotate(45 50 50)" do
    path d: "M50,50 v-50 a50,50 0 1,0 50,50 Z", fill: color3, style: style
  end
end

# T
t = SVG.new
t.polygon points: "0,0 70,0 50,20 50,120 20,120 20,20", fill: color4, style: style

# O
o = SVG.new
o.circle cx: 50, cy: 50, r: 50, fill: color5, style: style

# R
r = SVG.new
r.build do
  g transform: "skewX(20)" do
    rect x: 10, y: 30, width: 20, height: 70, fill: color6, style: style
  end
  circle cx: 30, cy: 30, r: 30, fill: color6, style: style
  rect x: 0, y: 0, width: 30, height: 100, fill: color6, style: style
end

# All together now
svg = SVG.new width: 350, height: 120
svg.build do
  g(transform: "translate(70  20)") { append i }
  g(transform: "translate(0   20)") { append v }
  g(transform: "translate(140  0)") { append t }
  g(transform: "translate(90  20)") { append c }
  g(transform: "translate(270 20)") { append r }
  g(transform: "translate(180 20)") { append o }
end

svg.save '16_victor_logo'
```

[View Source Ruby File](16_victor_logo.rb) | [View Image](16_victor_logo.svg)

[![16_victor_logo](16_victor_logo.svg)](16_victor_logo.svg)


## 17 tagless elements

```ruby
#!/usr/bin/env ruby

require 'victor'
include Victor

svg = SVG.new viewBox: "0 0 180 20"

svg.build do 
  rect x: 0, y:0, width: 180, height: 20, style: { fill: '#ddd' }
  text x: 15, y: 15, font_size: 14, font_family: 'Verdana' do
    _ 'You are'
    tspan 'not', fill: "red", font_weight: "bold"
    _ 'a banana'
  end
end

svg.save '17_tagless_elements'
```

[View Source Ruby File](17_tagless_elements.rb) | [View Image](17_tagless_elements.svg)

[![17_tagless_elements](17_tagless_elements.svg)](17_tagless_elements.svg)


## 18 xml encoding

```ruby
#!/usr/bin/env ruby

require 'victor'
include Victor

svg = SVG.new viewBox: "0 0 100 50"

svg.build do 
  rect x: 0, y:0, width: 100, height: 50, style: { fill: '#ddd' }
  text "Ben & Jerry's", x: 10, y: 10, font_size: 12
  text! "&#x2714; Works!", x: 10, y: 25, font_size: 12
end

svg.save '18_xml_endcoding'
```

[View Source Ruby File](18_xml_encoding.rb)



## 19 dsl

```ruby
#!/usr/bin/env ruby
require 'victor/script'

setup viewBox: "-10 -10 120 120", width: 200, height: 200

build do
  mask id: "heart" do
    rect x: 0, y: 0, width: 100, height: 100, fill: "white"
    path d: "M10,35 A20,20,0,0,1,50,35 A20,20,0,0,1,90,35 Q90,65,50,95 Q10,65,10,35 Z", fill: "black"
  end

  polygon points: "-10,110 110,110 110,-10", fill: "orange"
  circle cx: 50, cy: 50, r: 50, mask: "url(#heart)"
end

save '19_dsl'
```

[View Source Ruby File](19_dsl.rb) | [View Image](19_dsl.svg)

[![19_dsl](19_dsl.svg)](19_dsl.svg)



---

This file was generated automatically with `run examples readme`.