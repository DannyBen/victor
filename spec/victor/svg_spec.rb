require 'spec_helper'

describe SVG do
  let(:svg) { SVG.new }

  describe '#new' do
    it "sets default attributes" do
      expect(svg.svg_attributes[:height]).to eq "100%"
      expect(svg.svg_attributes[:width]).to eq "100%"
    end

    it "accepts initialization attributes" do
      svg = SVG.new height: '90%', width: '80%', viewBox: "0 0 100 200"
      expect(svg.svg_attributes[:height]).to eq "90%"
      expect(svg.svg_attributes[:width]).to eq "80%"
      expect(svg.svg_attributes[:viewBox]).to eq "0 0 100 200"
    end

    it "converts nested attributes to style" do
      svg = SVG.new dudes: { duke: :nukem, vanilla: :ice }
      expect(svg.svg_attributes.to_s).to match(/dudes="duke:nukem; vanilla:ice"/)
    end
  end

  context 'append' do
    let(:svg) { SVG.new }
    let(:fire) { SVG.new }
    let(:earth) { SVG.new }
    let(:water) { SVG.new }

    before do
      fire.circle color: 'red'
      earth.triangle color: 'green'
      water.rect color: 'blue'
    end

    describe '#<<' do
      it "pushes stringable objects as content" do
        svg << fire
        svg << earth
        svg << water

        expect(svg.to_s).to eq "<circle color=\"red\"/>\n<triangle color=\"green\"/>\n<rect color=\"blue\"/>"
      end
    end

    describe '#append' do
      it "pushes stringable objects as content" do
        svg.append fire
        svg.append earth
        svg.append water

        expect(svg.to_s).to eq "<circle color=\"red\"/>\n<triangle color=\"green\"/>\n<rect color=\"blue\"/>"
      end
    end
  end

  describe '#element' do
    it "generates xml without attributes" do
      svg.element 'anything'
      expect(svg.content).to eq ['<anything />']
    end

    it "generates xml with attributes" do
      svg.element 'anything', at: 'all'
      expect(svg.content).to eq ['<anything at="all"/>']
    end

    it "converts snake attributes to kebabs" do
      svg.element 'text', font_family: 'arial'
      expect(svg.content).to eq ['<text font-family="arial"/>']
    end

    context 'with hashed attributes' do
      it "converts attributes to style syntax" do
        svg.element 'cool', dudes: { vanilla: 'ice', duke: 'nukem' }
        expect(svg.content).to eq ['<cool dudes="vanilla:ice; duke:nukem"/>']
      end
    end

    context "with a block" do
      it "generates nested elements" do
        svg.build do
          universe do
            world do
              me
            end
          end
        end
        expect(svg.content).to eq ["<universe>", "<world>", "<me />", "</world>", "</universe>"]
      end
    end

    context "with a content argument" do
      it "generates a container element" do
        svg.element 'prison', 'inmate', number: '6'
        expect(svg.content).to eq ["<prison number=\"6\">", "inmate", "</prison>"]
      end
    end
  end

  describe '#method_missing' do
    it "calls #element" do
      expect(svg).to receive(:element).with(:anything)
      svg.anything
    end

    it "passes arguments to #element" do
      expect(svg).to receive(:element).with(:anything, {:at=>"all"})
      svg.anything at: 'all'
    end
  end

  describe '#build' do
    it "evaluates in context" do
      svg.build { rect x: 10, y: 10 }
      expect(svg.content).to eq ['<rect x="10" y="10"/>']
    end
  end

  describe '#template' do
    context 'with a symbol' do
      it "loads a built in template" do
        svg.template = :html
        svg.circle of: 'trust'
        expect(svg.render).to eq "<svg width=\"100%\" height=\"100%\"\n  xmlns=\"http://www.w3.org/2000/svg\"\n  xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n\n\n<circle of=\"trust\"/>\n\n</svg>"
      end
    end

    context 'with a path' do
      let(:path) { 'spec/fixtures/custom_template.svg' }

      it "loads a custom template" do
        svg.template = path
        svg.circle of: 'trust'
        expect(svg.render).to eq "<!-- Custom Template -->\n<svg width=\"100%\" height=\"100%\">\n<circle of=\"trust\"/>\n</svg>"
      end
    end
  end

  describe '#render' do
    it "generates full xml" do
      svg.circle radius: 10
      expect(svg.render).to match(/DOCTYPE svg PUBLIC/)
      expect(svg.render).to match(/svg width="100%" height="100%"/)
      expect(svg.render).to match(/<circle radius="10"\/>/)
    end

    context "with css elements" do
      before do
        @css = {}
        @css['.main'] = {
          stroke: "green",
          stroke_width: 2,
        }
      end

      it "includes a css block" do
        svg.css = @css
        expect(svg.render).to match(/.main \{/)
        expect(svg.render).to match(/stroke: green;/)
        expect(svg.render).to match(/stroke-width: 2;/)
      end
    end
  end

  describe '#to_s' do
    it "returns svg xml as string" do
      svg.circle radius: 10
      expect(svg.to_s).to eq '<circle radius="10"/>'
    end
  end

  describe '#save' do
    let(:filename) { 'test.svg' }

    before do
      File.unlink filename if File.exist? filename
    end

    it "saves to a file" do
      svg.circle radius: 10
      expect(File).not_to exist filename
      svg.save filename
      expect(File).to exist filename
    end

    it "saves xml" do
      svg.circle radius: 10
      svg.save filename
      content = File.read filename
      expect(content).to match(/<circle radius="10"\/>/)
    end
  end

end