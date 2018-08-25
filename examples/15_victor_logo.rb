#!/usr/bin/env ruby

require 'victor'
include Victor

# Colors
color1 = "#2364aa"
color2 = "#3da5d9"
color3 = "#fec601"
color4 = "#ea7317"
color5 = "#73bfb8"
color6 = color1

# Background
bg = SVG.new 
bg.rect x: 0, y: 0, width: 350, height: 120, fill: '#eee'

# V
v = SVG.new
v.path d: "M0,0 h80 L40,100", fill: color1

# I
i = SVG.new
i.rect x: 0, y: 0, width: 30, height: 100, fill: color2

# C
c = SVG.new
c.build do
  g transform: "rotate(45 50 50)" do
    path d: "M50,50 v-50 a50,50 0 1,0 50,50", fill: color3
  end
end

# T
t = SVG.new
t.polygon points: "0,0 70,0 50,20 50,120 20,120 20,20", fill: color4

# O
o = SVG.new
o.circle cx: 50, cy: 50, r: 50, fill: color5

# r
r = SVG.new
r.build do
  circle cx: 30, cy: 30, r: 30, fill: color6
  rect x: 0, y: 0, width: 30, height: 100, fill: color6
  g transform: "skewX(20)" do
    rect x: 10, y: 30, width: 20, height: 70, fill: color6
  end
end

# All together now
svg = SVG.new width: 350, height: 120
svg.build do
  append bg
  g(transform: "translate(70  20)") { append i }
  g(transform: "translate(0   20)") { append v }
  g(transform: "translate(150  0)") { append t }
  g(transform: "translate(90  20)") { append c }
  g(transform: "translate(280 20)") { append r }
  g(transform: "translate(190 20)") { append o }
end

svg.save '15_victor_logo'

