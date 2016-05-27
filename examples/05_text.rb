require 'victor'

svg = SVG.new

svg.text "Victor", x: 40, y: 50, font_family: 'arial', font_weight: 'bold', font_size: 40

puts "Result:\n\n"
puts svg.render

svg.save '05_text'


