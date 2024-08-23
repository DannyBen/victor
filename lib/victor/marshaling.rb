module Victor
  module Marshaling
    # YAML serialization methods
    def encode_with(coder)
      coder['template'] = @template
      coder['glue'] = @glue
      coder['svg_attributes'] = @svg_attributes
      coder['css'] = @css
      coder['content'] = @content
    end

    def init_with(coder)
      @template = coder['template']
      @glue = coder['glue']
      @svg_attributes = coder['svg_attributes']
      @css = coder['css']
      @content = coder['content']
    end

    # Marshal serialization methods
    def marshal_dump
      {
        template:       @template,
        glue:           @glue,
        svg_attributes: @svg_attributes,
        css:            @css,
        content:        @content,
      }
    end

    def marshal_load(data)
      @template = data[:template]
      @glue = data[:glue]
      @svg_attributes = data[:svg_attributes]
      @css = data[:css]
      @content = data[:content]
    end
  end
end
