module Victor

  class SVGBase
    attr_accessor :template
    attr_reader :content, :svg_attributes

    def initialize(attributes = nil, &block)
      setup attributes
      @content = []
      build &block if block_given?
    end

    def <<(additional_content)
      content.push additional_content.to_s
    end
    alias append <<

    def setup(attributes = nil)
      attributes ||= {}
      attributes[:width] ||= "100%"
      attributes[:height] ||= "100%"

      if attributes[:template]
        @template = attributes.delete :template
      elsif !@template
        @template = :default
      end

      @svg_attributes = Attributes.new attributes
    end

    def build(&block)
      self.instance_eval(&block)
    end

    def element(name, value=nil, attributes={}, &block)
      @content += Element.new(name, value, attributes).render &block
    end

    def css(defs = nil)
      @css ||= {}
      @css = defs if defs
      @css
    end

    def css=(defs)
      @css = defs
    end

    def render(template: nil)
      @template = template if template
      css_handler = CSS.new css

      svg_template % {
        css: css_handler,
        style: css_handler.render,
        attributes: svg_attributes,
        content: content.join("\n")
      }
    end

    def to_s
      content.join "\n"
    end

    def save(filename, template: nil)
      filename = "#{filename}.svg" unless filename =~ /\..{2,4}$/
      File.write filename, render(template: template)
    end

  protected

    def svg_template
      File.read template_path
    end

    def template_path
      if template.is_a? Symbol
        File.join File.dirname(__FILE__), 'templates', "#{template}.svg"
      else
        template
      end
    end
  end

end