# app/views/sample/_circle.svg.ruby
svg = Victor::SVG.new template: :html, width: 100, height: 100
svg.circle cx: 50, cy: 50, r: 30, fill: color
svg.render
