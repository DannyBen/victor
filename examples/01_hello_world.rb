require 'victor'

svg = SVG.new

svg.build do 
  rect x: 0, y: 0, width: 100, height: 100, style: { fill: '#ccc' }
  rect x: 20, y: 20, width: 60, height: 60, style: { fill: '#f99' },
    transform: "rotate(10 40 40)"
end

puts "Result:\n\n"
puts svg.render

svg.save '01_hello_world'
