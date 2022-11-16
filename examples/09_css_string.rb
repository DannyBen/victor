require 'victor'

svg = Victor::SVG.new width: 200, height: 200, viewBox: '0 0 70 70',
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
