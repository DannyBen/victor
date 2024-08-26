module Victor
  class Component
    include Marshaling

    # Marshaling data
    def marshaling = %i[width height x y svg css]

    # Subclasses MUST implement this
    def body = raise(NotImplementedError, "#{self.class.name} must implement `body'")

    # Subclasses MUST override these methods, OR assign instance vars
    def height = @height || raise(NotImplementedError, "#{self.class.name} height or @height")
    def width = @width || raise(NotImplementedError, "#{self.class.name} width or @width")
    
    # Subclasses MAY override these methods, OR assign instance vars
    def style = @style ||= {}
    def x = @x ||= 0
    def y = @y ||= 0

    # Rendering
    def render = svg.render
    alias to_s render
    def save(...) = svg.save(...)

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

    # Appending/Embedding
    def append(component)
      vector.append component.svg
      css.merge! component.css
    end
    alias embed append
  end
end
