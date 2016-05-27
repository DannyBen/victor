require 'victor'

svg = SVG.new

svg.build do 
  rect x: 2, y: 2, width: 200, height: 200, fill: '#ddd'

  path d: "M100,90 q  180 -140 0 70", fill: 'red'
  path d: "M100,90 q -180 -140 0 70", fill: 'red'
end

puts "Result:\n\n"
puts svg.render

svg.save '03_path'
