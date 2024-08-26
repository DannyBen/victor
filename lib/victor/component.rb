module Victor
  class Component
    include Marshaling

    # Marshaling data
    def marshaling = %i[width height x y svg css]

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

    # Appending/Embedding
    def append(component)
      vector.append component.svg
      css.merge! component.css
    end
    alias embed append

  protected

    # SVG
    def vector = @vector ||= SVG.new(viewBox: "#{x} #{y} #{width} #{height}")
    alias add vector
    def svg
      @svg ||= begin
        body
        vector.css = css
        vector
      end
    end

    # CSS
    def css = @css ||= style.dup
  end
end
