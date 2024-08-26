module ComponentSet1
  class Base < Victor::Component
    def width = 100
    def height = 100
  end

  class Main < Base
    def body
      add.g transform: 'translate(10, 10)' do
        append Two.new
      end
    end

    def style = { '.one': { stroke: :magenta } }
  end

  class Two < Base
    def body
      add.text 'Two'
      append Three.new
    end

    def style = { '.two': { stroke: :magenta } }
  end

  class Three < Base
    def body
      add.text 'Tada'
    end

    def style = { '.three': { stroke: :magenta } }
  end
end
