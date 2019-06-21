module Victor

  # Handles conversion from a Hash of attributes, to an XML string or
  # a CSS string.
  class Attributes
    attr_reader :attributes

    def initialize(attributes={})
      @attributes = attributes
    end

    def to_s
      mapped = attributes.map do |key, value|
        key = key.to_s.tr '_', '-'

        if value.is_a? Hash
          style = Attributes.new(value).to_style
          "#{key}=\"#{style}\""
        elsif value.is_a? Array
          "#{key}=\"#{value.join ' '}\""
        else
          "#{key}=#{value.to_s.encode(xml: :attr)}"
        end
      end

      mapped.join ' '
    end

    def to_style
      mapped = attributes.map do |key, value|
        key = key.to_s.tr '_', '-'
        "#{key}:#{value}"
      end

      mapped.join '; '
    end

    def [](key)
      attributes[key]
    end

    def []=(key, value)
      attributes[key] = value
    end

  end

end