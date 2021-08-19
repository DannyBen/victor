module Victor

  class Element
    attr_reader :name, :value, :attributes, :escape

    def initialize(name, value_or_attributes = nil, attributes = {})
      if value_or_attributes.is_a? Hash
        @attributes = Attributes.new value_or_attributes
        @value = nil
      else
        @value = value_or_attributes
        @attributes = Attributes.new attributes
      end

      if name.to_s.end_with? '!'
        @escape = false
        @name = name[0..-2]
      else
        @escape = true
        @name = name
      end
    end

    def render
      result = []

      if block_given? || value
        result.push "<#{name} #{attributes}".strip + ">" unless empty_tag?
        if value
          result.push(escape ? value.to_s.encode(xml: :text) : value)
        else
          result += yield
        end
        result.push "</#{name}>" unless empty_tag?
      else      
        result.push "<#{name} #{attributes}/>"
      end

      result
    end

  private

    def empty_tag?
      name.to_s == '_'
    end

  end
end