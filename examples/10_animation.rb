require 'victor'

svg = Victor::SVG.new width: 140, height: 100, style: { background: '#ddd' }

def animation
  css[".mouth"] = {
    animation: "blink 0.5s step-start 0s infinite"
  }

  css[".candy"] = {
    animation: "move 0.6s 0s infinite"
  }

  css["@keyframes blink"] = {
    "50%": { opacity: 0 }
  }

  css["@keyframes move"] = {
    "100%": { transform: "translate(-70px, 0)" }
  }
end

def pacman
  circle cx: 50, cy: 50, r: 30, fill: 'yellow'
  circle cx: 58, cy: 32, r: 4, fill: 'black'
  polygon points: %w[45,50 80,30 80,70], fill: '#666', class: 'mouth'

  circle cx: 100, cy: 50, r: 6, fill: 'yellow', class: 'candy'
end

svg.build do 
  rect x: 10, y: 10, width: 100, height: 80, fill: '#666'
  animation
  pacman
end

svg.save '10_animation'
