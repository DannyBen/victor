module Victor
  module DSL
    def svg
      @svg ||= Victor::SVG.new
    end

    def setup(attributes)
      svg.setup attributes
    end

    def build(&block)
      svg.build &block
    end

    def save(file)
      svg.save file
    end

    def render
      svg.render
    end
  end
end
