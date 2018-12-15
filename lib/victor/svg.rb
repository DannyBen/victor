module Victor
  class SVG < SVGBase
    def method_missing(method_sym, *arguments, &block)
      element method_sym, *arguments, &block
    end
  end
end