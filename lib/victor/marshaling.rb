module Victor
  module Marshaling
    # YAML serialization methods
    def encode_with(coder)
      coder['content'] = @content
      coder['glue'] = @glue
      coder['svg_attributes'] = @svg_attributes
      coder['template'] = @template
      coder['css'] = @css
    end

    def init_with(coder)
      @content = coder['content']
      @glue = coder['glue']
      @svg_attributes = coder['svg_attributes']
      @template = coder['template']
      @css = coder['css']
    end

    # Marshal serialization methods
    def marshal_dump
      {
        content:        @content,
        glue:           @glue,
        svg_attributes: @svg_attributes,
        template:       @template,
        css:            @css,
      }
    end

    def marshal_load(data)
      @content = data[:content]
      @glue = data[:glue]
      @svg_attributes = data[:svg_attributes]
      @template = data[:template]
      @css = data[:css]
    end
  end
end
