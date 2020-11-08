#!/usr/bin/env ruby

require 'victor'
include Victor

svg = SVG.new viewBox: "0 0 100 50"

svg.build do 
  rect x: 0, y:0, width: 100, height: 50, style: { fill: '#ddd' }
  text "Ben & Jerry's", x: 10, y: 10, font_size: 12
  text! "&#x2714; Works!", x: 10, y: 25, font_size: 12
end

svg.save '18_xml_endcoding'

