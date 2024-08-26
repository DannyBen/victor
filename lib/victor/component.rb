module Victor
  class Component
    # Subclasses MUST implement this
    def body = raise(NotImplementedError, "#{self.class.name} must implement `body'")

    # Subclasses MUST override these methods, OR assign instance vars
    def height = @height || raise(NotImplementedError, "#{self.class.name} height or @height")
    def width = @width || raise(NotImplementedError, "#{self.class.name} width or @width")
    
    # Subclasses MAY implement these methods
    def style = {}

    # Subclasses MAY override these methods, OR assign instance vars
    def x = @x ||= 0
    def y = @y ||= 0

    # Rendering
    def render = svg.render
    alias to_s render
    def save(...) = svg.save(...)

    # SVG
    def vector = @vector ||= SVG.new(viewBox: "#{x} #{y} #{width} #{height}")
    alias add vector

    # Appending/Embedding
    def append(component)
      vector.append component.svg
      css.merge! component.style
    end
    alias embed append

  protected

    def css = @css ||= style.dup

    def svg
      @svg ||= begin
        body
        vector.css = css
        vector
      end
    end
  end
end
