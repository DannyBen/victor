

module Victor

  class SVG
    attr_accessor :attributes
    attr_reader :content

    def initialize(attributes={})
      @attributes = attributes
      attributes[:width] ||= "100%"
      attributes[:height] ||= "100%"
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

      xml_attributes = expand attributes

      if block_given? || value
        content.push "<#{name} #{xml_attributes}".strip + ">"
        value ? content.push(value) : yield
        content.push "</#{name}>"
      else
        content.push "<#{name} #{xml_attributes}/>"
      end
    end

    def render
      template % { attributes: expand(attributes), content: content.join("\n") }
    end

    def save(filename)
      filename = "#{filename}.svg" unless filename =~ /\..{2,4}$/
      File.write filename, render
    end

    private

    def expand(attributes={})
      mapped = attributes.map do |key, value|
        key = key.to_s.tr '_', '-'
        value.is_a?(Hash) ? inner_expand(key, value) : "#{key}=\"#{value}\""
      end

      mapped.join ' '
    end

    def inner_expand(name, attributes)
      mapped = attributes.map do |key, value|
        "#{key}:#{value}"
      end

      "#{name}=\"#{mapped.join '; '}\""
    end

    def template
      File.read template_path
    end

    def template_path
      File.join File.dirname(__FILE__), 'templates', template_file
    end

    def template_file
      'default.svg'
    end
  end

end