require 'victor'

svg = SVG.new width: 420, height: 80

svg.build do
  rect x: 0, y: 0, width: 420, height: 80, fill: '#666'

  g font_size: 30, font_family: 'arial', fill: 'white' do
    text "Scalable Victor Graphics", x: 40, y: 50
  end
end

svg.save '07_nested'


