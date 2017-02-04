require 'victor'

svg = SVG.new width: 300, height: 130, viewBox:"0 0 300 130"

svg.build do
  
  # Whenever the value of a CSS entry is an array, each item in the
  # array will simply be placed after the key,separated by a space
  # so this will create two '@import url(...)' statements.
  css['@import'] = [
    "url('https://fonts.googleapis.com/css?family=Audiowide')",
    "url('https://fonts.googleapis.com/css?family=Pacifico')"
  ]

  rect x: 0, y: 0, width: '100%', height: '100%', fill: '#779'

  svg.text "Custom Fonts?", text_anchor: :middle, x: '50%', y: 50, 
    font_family: 'Audiowide', font_size: 30, fill: :white

  svg.text "No problem!", text_anchor: :middle, x: '50%', y: 100, 
    font_family: 'Pacifico', font_size: 30
end

svg.save '12_custom_fonts'

