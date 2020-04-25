require "spec_helper"

describe Parser do
  subject { described_class.new svg }

  describe "#parse" do
    let(:svg) {
      <<~SVG
        <svg a="b">
          <rect width="30" />
        </svg>
      SVG
    }

    it "converts the svg into a simple tree structure" do
      expect(subject.parse).to eql([
        "svg",
        { "a" => "b" },
        [
          ["rect", { "width" => "30" }, []],
        ],
      ])
    end

    context "namespaced attributes are present" do
      let(:svg) { '<svg><use xlink:href="#b"/></svg>' }

      it "parses the attributes correctly" do
        expect(subject.parse).to eql(
          [
            "svg",
            {},
            [["use", { "xlink:href" => "#b" }, []]],
          ]
        )
      end
    end

    context "text node is present" do
      let(:svg) {
        <<~SVG
          <svg>
            <text>
              You are
              <tspan font-weight="bold">not</tspan>
              a banana
            </text>
          </svg>
        SVG
      }

      it "parses the attributes correctly" do
        expect(subject.parse).to eql(
          [
            "svg",
            {},
            [["text", {}, [
              ["_", {}, "You are"],
              ["tspan", { "font-weight" => "bold" }, [["_", {}, "not"]]],
              ["_", {}, "a banana"],
            ]]],
          ]
        )
      end
    end

    context "style node is present" do
      let(:svg) { "<svg><style>.test-class{color: red;}</style></svg>" }

      it "parses the attributes correctly" do
        expect(subject.parse).to eql(
          [
            "svg",
            {},
            [["style", {}, [
              ["_", {}, ".test-class{color: red;}"],
            ]]],
          ]
        )
      end
    end
  end
end
