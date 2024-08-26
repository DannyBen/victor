module Victor
  module Marshaling
    # YAML serialization methods
    def encode_with(coder)
      marshaling.each do |attr|
        coder[attr.to_s] = send(attr)
      end
    end

    def init_with(coder)
      marshaling.each do |attr|
        instance_variable_set(:"@#{attr}", coder[attr.to_s])
      end
    end

    # Marshal serialization methods
    def marshal_dump
      marshaling.to_h do |attr|
        [attr, send(attr)]
      end
    end

    def marshal_load(data)
      marshaling.each do |attr|
        instance_variable_set(:"@#{attr}", data[attr])
      end
    end
  end
end
