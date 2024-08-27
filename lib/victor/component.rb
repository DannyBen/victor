module Victor
  class Component
    include Marshaling

    # Marshaling data
    def marshaling = %i[width height x y svg merged_css]

    # Subclasses MUST implement this
    def body
      raise(NotImplementedError, "#{self.class.name} must implement `body'")
    end

    # Subclasses MUST override these methods, OR assign instance vars
    def height
      @height || raise(NotImplementedError,
        "#{self.class.name} must implement `height' or `@height'")
    end

    def width
      @width || raise(NotImplementedError,
        "#{self.class.name} must implement `width' or `@width'")
    end

    # Subclasses MAY override these methods, OR assign instance vars
    def style = @style ||= {}
    def x = @x ||= 0
    def y = @y ||= 0

    # Rendering
    def save(...) = svg.save(...)
    def render(...) = svg.render(...)
    def content = svg.content
    def to_s = render

    # Appending/Embedding - DSL for the `#body` implementation
    def append(component)
      svg_instance.append component.svg
      merged_css.merge! component.merged_css
    end
    alias embed append

    # SVG / CSS
    def svg
      @svg ||= begin
        body
        svg_instance.css = merged_css
        svg_instance
      end
    end

    def css = @css ||= svg.css

  protected

    # Start with an ordinary SVG instance
    def svg_instance = @svg_instance ||= SVG.new(viewBox: "#{x} #{y} #{width} #{height}")

    # Internal DSL to enable `add.anything` in the `#body` implementation
    alias add svg_instance

    # Start with a copy of our own style
    def merged_css = @merged_css ||= style.dup
  end
end
