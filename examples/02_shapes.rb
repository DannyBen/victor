require 'victor'

svg = SVG.new

style = {
  stroke: 'yellow',
  stroke_width: 4
}

svg.build do 
  rect x: 2, y: 2, width: 200, height: 200, fill: '#f88', style: style
  circle cx: 50, cy: 50, r: 40, style: style, fill: 'red'
  ellipse cx: 100, cy: 140, rx: 80, ry: 30, style: style, fill: 'green'
  line x1: 100, y1: 200, x2: 100, y2: 300, style: style
  polygon points: "150,20 180,80 120,80", fill: 'blue', style: style
end

puts "Result:\n\n"
puts svg.render

svg.save '02_shapes'
