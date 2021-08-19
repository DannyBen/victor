module Victor

  class Element
    attr_reader :name, :value, :attributes

    def initialize(name, value_or_attributes = nil, attributes = {})
      @name = name

      if value_or_attributes.is_a? Hash
        @attributes = Attributes.new value_or_attributes
        @value = nil
      else
        @value = value_or_attributes
        @attributes = Attributes.new attributes
      end

      if name.to_s.end_with? '!'
        @name = name[0..-2]
      elsif @value
        @value = @value.to_s.encode xml: :text
      end
    end

    def render(&block)
      if block_given? || value
        wrap_element &block
      else      
        ["<#{name} #{attributes}/>"]
      end
    end

  private

    def empty_tag?
      name.to_s == '_'
    end

    def wrap_element(&block)
      inner = body_parts &block

      if empty_tag?
        inner        
      else
        ["<#{name} #{attributes}".strip + ">"] + inner + ["</#{name}>"]
      end
    end

    def body_parts(&block)
      value ? [value] : yield
    end

  end
end