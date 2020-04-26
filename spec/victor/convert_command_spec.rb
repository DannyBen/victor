require "spec_helper"
require_relative "../../lib/victor/convert_command"

describe ConvertCommand do
  subject { described_class.new attrs }
  let(:attrs) { { "FILE_NAME" => file_path } }
  let(:file_path) {
    File.join(__dir__, "..", "fixtures", "pacman.svg")
  }

  it "converts the svg into ruby code" do
    code = <<~RUBY
      require "victor"

      svg = Victor::SVG.new({"width"=>"140", "height"=>"100", "style"=>"background:#ddd"})
      svg.build do
        rect({"x"=>"10", "y"=>"10", "width"=>"120", "height"=>"80", "rx"=>"10", "fill"=>"#666"})
      circle({"cx"=>"50", "cy"=>"50", "r"=>"30", "fill"=>"yellow"})
      circle({"cx"=>"58", "cy"=>"32", "r"=>"4", "fill"=>"black"})
      polygon({"points"=>"45,50 80,30 80,70", "fill"=>"#666"})
      circle({"cx"=>"80", "cy"=>"50", "r"=>"4", "fill"=>"yellow"})
      circle({"cx"=>"98", "cy"=>"50", "r"=>"4", "fill"=>"yellow"})
      circle({"cx"=>"116", "cy"=>"50", "r"=>"4", "fill"=>"yellow"})
      end

      svg.save "generated"
    RUBY
    expect { subject.run }.to output(code).to_stdout
  end
end
