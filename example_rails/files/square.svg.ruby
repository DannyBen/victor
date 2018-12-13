# app/views/sample/square.svg.ruby
color = @params[:color]

svg = Victor::SVG.new width: 100, height: 100
svg.rect x: 20, y: 20, width: 60, height: 60, fill: color
svg.render
