

module Victor

  class SVG
    attr_accessor :template
    attr_reader :content, :svg_attributes

    def initialize(attributes={})
      @template = attributes.delete(:template) || :default
      @svg_attributes = Attributes.new attributes
      svg_attributes[:width] ||= "100%"
      svg_attributes[:height] ||= "100%"
      @content = []
    end

    def method_missing(method_sym, *arguments, &block)
      element method_sym, *arguments, &block
    end

    def build(&block)
      self.instance_eval(&block)
    end

    def element(name, value=nil, attributes={}, &_block)
      if value.is_a? Hash
        attributes = value
        value = nil
      end

      attributes = Attributes.new attributes

      if block_given? || value
        content.push "<#{name} #{attributes}".strip + ">"
        value ? content.push(value) : yield
        content.push "</#{name}>"
      else
        content.push "<#{name} #{attributes}/>"
      end
    end

    def render
      svg_template % { attributes: svg_attributes, content: content.join("\n") }
    end

    def save(filename)
      filename = "#{filename}.svg" unless filename =~ /\..{2,4}$/
      File.write filename, render
    end

    private

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