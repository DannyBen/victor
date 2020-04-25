require "spec_helper"

describe CodeGenerator do
  subject { described_class.new svg_tree }

  describe "#generate" do
    let(:svg_tree) {
      ["svg", { "a" => "b" }, [["rect", { "x" => "10" }, []]]]
    }

    it "converts the svg tree into ruby code" do
      expected = <<~RUBY
        require "victor"

        svg = Victor::SVG.new({"a"=>"b"})
        svg.build do
          rect({"x"=>"10"})
        end

        svg.save "generated"
      RUBY
      expect(subject.generate).to eql(expected)
    end

    context "nested nodes are present" do
      let(:svg_tree) {
        ["g", { "a" => "b" }, [["rect", { "x" => "10" }, []]]]
      }

      it "converts the svg tree into ruby code" do
        expected = <<~RUBY
          g({"a"=>"b"}) do
          rect({"x"=>"10"})
          end
        RUBY
        expect(subject.generate).to eql(expected)
      end
    end
  end
end
