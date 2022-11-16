require 'victor'

class Troll < Victor::SVG
  attr_reader :color, :hat_color

  def initialize(color: 'yellow', hat_color: 'red')
    # Accept parameters we care about, and call the super initializer
    @color = color
    @hat_color = hat_color
    super width: 100, height: 100, viewBox: '0 0 100 100'

    # Generate the base image with the frame and head elements
    frame
    head
  end

  # Allow adding more elements after instantiation
  def add_nose
    circle cx: 50, cy: 65, r: 4, fill: 'black'
  end

  def frame
    rect x: 0, y: 0, width: 100, height: 100, fill: '#336'
    rect x: 10, y: 10, width: 80, height: 80, fill: '#fff'
  end

  def head
    circle cx: 50, cy: 60, r: 24, fill: color
    polygon points: %w[24,50 50,14 76,54], fill: hat_color
  end
end

troll = Troll.new color: '#33f', hat_color: '#3f3'
troll.add_nose
troll.save '15_subclassing'
