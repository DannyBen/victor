require 'victor'

svg = SVG.new

# These two are the same, and both return the XML code
a = svg.element :rect, x: 2, y: 2, width: 200, height: 200, fill: '#ddd'
b = svg.rect x: 2, y: 2, width: 200, height: 200, fill: '#ddd'

puts "Result:\n\n"
puts "a: #{a}"
puts "b: #{b}"

