require 'victor'

svg = SVG.new viewBox:"0 0 400 400"

svg.build do
  
  # Define a reusable pattern using SVG defs>
  defs do
    linearGradient id: "Gradient1" do
      stop offset: "5%", stop_color: "white"
      stop offset: "95%", stop_color: "blue"
    end

    linearGradient id: "Gradient2", x1: "0", x2: "0", y1: "0", y2: "1" do
      stop offset: "5%", stop_color: "red"
      stop offset: "95%", stop_color: "orange"
    end

    pattern id: "Pattern", x: "0", y: "0", width: "50", height: "50", patternUnits: "userSpaceOnUse" do
      rect x: "0", y: "0", width: "50", height: "50", fill: "skyblue"
      rect x: "0", y: "0", width: "25", height: "25", fill: "url(#Gradient2)"
      circle cx: "25", cy: "25", r: "20", fill: "url(#Gradient1)", fill_opacity: "0.5"
    end
  end

  # Use the pattern as a background fill for two shapes
  rect fill: "url(#Pattern)", stroke: "black", x: "0", y: "0", width: "300", height: "150"
  circle fill: "url(#Pattern)", stroke: "black", cx: "200", cy: "200", r: "100"
end

# Save it
svg.save '11_def_pattern'
