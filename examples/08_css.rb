require 'victor'

svg = SVG.new width: 400, height: 400, viewBox: "0 0 100 100", 
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

