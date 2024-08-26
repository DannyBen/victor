module ComponentSet1
  class Base < Victor::Component
    def width = 100
    def height = 100
  end

  class Main < Base
    def body = append(Two.new)
    def style = { '.one': { stroke: :magenta } }
  end

  class Two < Base
    def body = append(Three.new)
    def style = { '.two': { stroke: :magenta } }
  end

  class Three < Base
    def body = add.text('Tada')
    def style = { '.three': { stroke: :magenta } }
  end
end
