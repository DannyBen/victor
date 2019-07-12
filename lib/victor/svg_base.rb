module Victor

  class SVGBase
    attr_accessor :template, :css
    attr_reader :content, :svg_attributes

    def initialize(attributes={})
      @template = attributes.delete(:template) || :default
      @svg_attributes = Attributes.new attributes
      svg_attributes[:width] ||= "100%"
      svg_attributes[:height] ||= "100%"
      @content = []
      @css = {}
    end

    def <<(additional_content)
      content.push additional_content.to_s
    end
    alias append <<

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

    def render
      css_string = CSS.new css
      svg_template % {
        css: css_string,
        style: css_string.render,
        attributes: svg_attributes,
        content: content.join("\n")
      }
    end

    def to_s
      content.join "\n"
    end

    def save(filename)
      filename = "#{filename}.svg" unless filename =~ /\..{2,4}$/
      File.write filename, render
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