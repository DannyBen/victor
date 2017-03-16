module Victor

  class CSS
    attr_reader :attributes

    def initialize(attributes={})
      @attributes = attributes
    end

    def to_s
      convert_hash attributes
    end

    private 

    def convert_hash(hash, indent=2)
      return hash unless hash.is_a? Hash

      result = []
      hash.each do |key, value|
        key = key.to_s.tr '_', '-'
        if value.is_a? Hash
          result.push " " * indent + "#{key} {"
          result.push convert_hash(value, indent+2)
          result.push " " * indent + "}"
        elsif value.is_a? Array
          value.each do |row|
            result.push " " * indent + "#{key} #{row};"
          end
        else
          result.push " " * indent + "#{key}: #{value};"
        end
      end

      result.join "\n"
    end
  end

end