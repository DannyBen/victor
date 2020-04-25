module Victor
  class CodeGenerator
    def initialize(svg_tree)
      @svg_tree = svg_tree
    end

    def generate
      code_for_node(svg_tree)
    end

    private

    attr_reader :svg_tree

    def code_for_node(node)
      case node.first
      when "svg"
        root_to_ruby(node)
      else
        node_to_ruby(node)
      end
    end

    def node_to_ruby(node)
      name, attrs, children = node
      code = "#{name}(#{attrs_to_ruby(attrs)})"
      unless children.empty?
        code << " do\n"
        code << nodes_to_ruby(children)
        code << "\nend\n"
      end
      code
    end

    def nodes_to_ruby(nodes)
      nodes.map(&method(:code_for_node)).join("\n")
    end

    def attrs_to_ruby(attrs)
      attrs.inspect
    end

    def root_to_ruby(node)
      _, attrs, children = node
      <<~RUBY
        require "victor"

        svg = Victor::SVG.new(#{attrs_to_ruby(attrs)})
        svg.build do
          #{nodes_to_ruby(children)}
        end

        svg.save "generated"
      RUBY
    end
  end
end
