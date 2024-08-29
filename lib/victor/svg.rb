module Victor
  class SVG < SVGBase
    def method_missing(method_sym, ...)
      tag(method_sym, ...)
    end

    def respond_to_missing?(*)
      true
    end
  end
end
