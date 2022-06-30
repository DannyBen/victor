module Victor

  class SVGBase
    attr_accessor :template, :glue
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

      @template = attributes[:template] || @template || :default
      @glue = attributes[:glue] || @glue || "\n"

      attributes.delete :template
      attributes.delete :glue

      @svg_attributes = Attributes.new attributes
    end

    def build(&block)
      self.instance_eval(&block)
    end

    def element(name, value=nil, attributes={}, &_block)
      if value.is_a? Hash
        attributes = value
        value = nil
      end

      escape = true

      if name.to_s.end_with? '!'
        escape = false
        name = name[0..-2]
      end

      attributes = Attributes.new attributes
      empty_tag = name.to_s == '_'

      if block_given? || value
        content.push "<#{name} #{attributes}".strip + ">" unless empty_tag
        if value
          content.push(escape ? value.to_s.encode(xml: :text) : value)
        else
          yield
        end
        content.push "</#{name}>" unless empty_tag
      else      
        content.push "<#{name} #{attributes}/>"
      end
    end

    def css(defs = nil)
      @css ||= {}
      @css = defs if defs
      @css
    end

    def css=(defs)
      @css = defs
    end

    def render(template: nil, glue: nil)
      @template = template if template
      @glue = glue if glue
      css_handler = CSS.new css

      svg_template % {
        css: css_handler,
        style: css_handler.render,
        attributes: svg_attributes,
        content: to_s
      }
    end

    def to_s
      content.join glue
    end

    def save(filename, template: nil, glue: nil)
      filename = "#{filename}.svg" unless filename =~ /\..{2,4}$/
      File.write filename, render(template: template, glue: glue)
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