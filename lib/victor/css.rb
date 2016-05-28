

module Victor

  class CSS
    attr_reader :attributes

    def initialize(attributes={})
      @attributes = attributes
    end

    def to_s
      result = []
      attributes.each do |selector, styles|
        result.push "  #{selector} {"
        styles.each do |key, value|
          key = key.to_s.tr '_', '-'
          result.push "    #{key}: #{value};"
        end
        result.push "  }"
      end

      result.join "\n"
    end
  end

end