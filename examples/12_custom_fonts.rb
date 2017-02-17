require 'victor'

svg = Victor::SVG.new width: 300, height: 180, viewBox:"0 0 300 180"

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

  svg.text "this example does not work", 
    text_anchor: :middle, x: '50%', y: 140, 
    font_family: 'arial', font_size: 16

  svg.text "when embedded in HTML", 
    text_anchor: :middle, x: '50%', y: 160, 
    font_family: 'arial', font_size: 16
end

svg.save '12_custom_fonts'



