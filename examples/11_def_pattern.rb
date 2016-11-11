require 'victor'

svg = SVG.new width: 300, height: 300, viewBox:"0 0 400 300"

svg.build do
  
  # Define a reusable pattern using SVG defs>
  defs do
    pattern id: "Pattern", x: "0", y: "0", width: "75", height: "50", patternUnits: "userSpaceOnUse" do
      rect x: "0" , y: "0", width: "25", height: "50", fill: "black"
      rect x: "25", y: "0", width: "25", height: "50", fill: "red"
      rect x: "50", y: "0", width: "25", height: "50", fill: "yellow"
    end
  end

  # Use the pattern as a background fill for two shapes
  rect fill: "url(#Pattern)", stroke: "black", x: "0", y: "0", width: "300", height: "150"
  circle fill: "url(#Pattern)", stroke: "black", cx: "150", cy: "150", r: "100",
    transform: 'rotate(90 150 150)'
end

# Save it
svg.save '11_def_pattern'
