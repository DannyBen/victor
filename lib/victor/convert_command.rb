require "mister_bin"

module Victor
  class ConvertCommand < MisterBin::Command
    summary "Convert an SVG into ruby code"
    usage "convert FILE_NAME"
    param "FILE_NAME", "name of the file to be converted"

    def run
      svg_file = File.read(args["FILE_NAME"])
      svg_tree = Parser.new(svg_file).parse
      puts CodeGenerator.new(svg_tree).generate
    end
  end
end
