#!/usr/bin/env ruby

require 'victor'
include Victor

svg = SVG.new viewBox: "0 0 180 20"

svg.build do 
  rect x: 0, y:0, width: 180, height: 20, style: { fill: '#ddd' }
  text x: 15, y: 15, font_size: 14, font_family: 'Verdana' do
    _ 'You are'
    tspan 'not', fill: "red", font_weight: "bold"
    _ 'a banana'
  end
end

svg.save '16_multiple_text_elements'

