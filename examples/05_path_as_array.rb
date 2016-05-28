require 'victor'

svg = SVG.new width: 200, height: 200 

svg.build do 
  rect x: 0, y: 0, width: 200, height: 200, fill: '#ddd'

  path d: ['M', 100,90, 'q',  180, -140, 0, 70], fill: 'red'
  path d: ['M', 100,90, 'q', -180, -140, 0, 70], fill: 'red'
end

puts "Result:\n\n"
puts svg.render

svg.save '05_path_as_array'
