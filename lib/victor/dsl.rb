require 'forwardable'

module Victor
  module DSL
    extend Forwardable
    def_delegators :svg, :setup, :build, :save, :render, :append, :element

    def svg
      @svg ||= Victor::SVG.new
    end
  end
end
