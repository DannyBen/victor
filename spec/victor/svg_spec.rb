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

    context "when a block is given" do
      it "builds with the block" do
        svg = SVG.new do
          circle cx: 10, cy: 10, r: 20
        end

        expect(svg.to_s).to eq "<circle cx=\"10\" cy=\"10\" r=\"20\"/>"
      end
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

  describe '#setup' do
    it "updates attributes" do
      subject.setup width: '80%', anything: 'ok'
      expect(subject.svg_attributes.to_s).to eq 'width="80%" anything="ok" height="100%"'
    end

    it "sets default template" do
      subject.setup width: '80%'
      expect(subject.template).to eq :default
    end

    context "when the provided attributes contain :template" do
      before { subject.template = :something_non_default }

      it "sets template to the provided value" do
        subject.setup width: '80%', template: :minimal
        expect(subject.template).to eq :minimal
      end
    end

    context "when template is set in advance" do
      before { subject.template = :html }

      it "does not alter the template value" do
        subject.setup width: '80%'
        expect(subject.template).to eq :html
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

    context "with a plain text value" do
      it "generates a container element" do
        svg.element 'prison', 'inmate', number: '6'
        expect(svg.content).to eq ["<prison number=\"6\">", "inmate", "</prison>"]
      end

      it "escapes XML" do
        svg.element 'text', 'For Dumb & Dumber, 2 > 3'
        expect(svg.content).to eq ["<text>", "For Dumb &amp; Dumber, 2 &gt; 3", "</text>"]
      end

      context "when the element is an underscore" do
        it "generates a tagless element" do
          svg.element '_', 'You are (not) surrounded!'
          expect(svg.content).to eq ["You are (not) surrounded!"]
        end

        it "escapes XML" do
          svg.element '_', 'For Dumb & Dumber, 2 > 3'
          expect(svg.content).to eq ["For Dumb &amp; Dumber, 2 &gt; 3"]
        end

        context "when the element is _!" do
          it "does not escape XML" do
            svg.element '_!', 'For Dumb & Dumber, 2 > 3'
            expect(svg.content).to eq ["For Dumb & Dumber, 2 > 3"]
          end
        end
      end

      context "when the element name ends with !" do
        it "does not escape XML" do
          svg.element 'text!', 'For Dumb & Dumber, 2 > 3'
          expect(svg.content).to eq ["<text>", "For Dumb & Dumber, 2 > 3", "</text>"]
        end
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
    before do
      svg.circle radius: 10
    end

    it "generates full xml" do
      expect(svg.render).to match_fixture('svg/full')
    end

    context "with template argument" do
      it "uses the provided template" do
        expect(svg.render template: :minimal).to match_fixture('svg/minimal')
      end
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
        expect(svg.render).to match_fixture('svg/css')
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
      expect(File).not_to exist filename
      svg.circle radius: 10
    end

    it "saves to a file" do
      svg.save filename
      expect(File).to exist filename
    end

    it "saves xml" do
      svg.save filename
      expect(File.read filename).to match_fixture('svg/full')
    end

    context "with template argument" do
      it "uses the provided template" do
        svg.save filename, template: :minimal
        expect(File.read filename).to match_fixture('svg/minimal')
      end
    end
  end

end
