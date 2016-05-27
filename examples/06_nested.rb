require 'victor'

svg = SVG.new

svg.build do
  rect x: 0, y: 0, width: 420, height: 80, style: { fill: '#666' }

  g font_size: 30, font_family: 'arial', fill: 'white' do
    text "Scalable Victor Graphics", x: 40, y: 50
  end
end

puts "Result:\n\n"
puts svg.render

svg.save '06_nested'


