require 'spec_helper'

describe SVG do
  describe '#new' do
    it "sets default attributes" do
      expect(subject.svg_attributes[:height]).to eq "100%"
      expect(subject.svg_attributes[:width]).to eq "100%"
    end

    context "with attributes" do
      subject { described_class.new height: '90%', width: '80%', viewBox: "0 0 100 200" }

      it "sets the attributes" do
        expect(subject.svg_attributes[:height]).to eq "90%"
        expect(subject.svg_attributes[:width]).to eq "80%"
        expect(subject.svg_attributes[:viewBox]).to eq "0 0 100 200"
      end
    end

    context "with nested attributes" do
      subject { described_class.new style: { color: 'red', anything: 10 } }

      it "converts the nested attributes to style" do
        expect(subject.svg_attributes.to_s).to match(/style="color:red; anything:10"/)
      end
    end

    context "when a block is given" do
      subject do
        described_class.new do
          circle cx: 10, cy: 10, r: 20
        end
      end

      it "builds with the block" do
        expect(subject.to_s).to eq "<circle cx=\"10\" cy=\"10\" r=\"20\"/>"
      end
    end
  end

  context 'appending SVGs' do
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
        subject << fire
        subject << earth
        subject << water

        expect(subject.to_s).to eq "<circle color=\"red\"/>\n<triangle color=\"green\"/>\n<rect color=\"blue\"/>"
      end
    end

    describe '#append' do
      it "pushes stringable objects as content" do
        subject.append fire
        subject.append earth
        subject.append water

        expect(subject.to_s).to eq "<circle color=\"red\"/>\n<triangle color=\"green\"/>\n<rect color=\"blue\"/>"
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
      subject.element 'anything'
      expect(subject.content).to eq ['<anything />']
    end

    it "generates xml with attributes" do
      subject.element 'anything', at: 'all'
      expect(subject.content).to eq ['<anything at="all"/>']
    end

    it "converts snake attributes to kebabs" do
      subject.element 'text', font_family: 'arial'
      expect(subject.content).to eq ['<text font-family="arial"/>']
    end

    context 'with hashed attributes' do
      it "converts attributes to style syntax" do
        subject.element 'cool', style: { color: 'red', anything: 10 }
        expect(subject.content).to eq ['<cool style="color:red; anything:10"/>']
      end
    end

    context "with a block" do
      it "generates nested elements" do
        subject.build do
          universe do
            world do
              me
            end
          end
        end
        expect(subject.content).to eq ["<universe>", "<world>", "<me />", "</world>", "</universe>"]
      end
    end

    context "with a plain text value" do
      it "generates a container element" do
        subject.element 'prison', 'inmate', number: '6'
        expect(subject.content).to eq ["<prison number=\"6\">", "inmate", "</prison>"]
      end

      it "escapes XML" do
        subject.element 'text', 'For Dumb & Dumber, 2 > 3'
        expect(subject.content).to eq ["<text>", "For Dumb &amp; Dumber, 2 &gt; 3", "</text>"]
      end

      context "when the element is an underscore" do
        it "generates a tagless element" do
          subject.element '_', 'You are (not) surrounded!'
          expect(subject.content).to eq ["You are (not) surrounded!"]
        end

        it "escapes XML" do
          subject.element '_', 'For Dumb & Dumber, 2 > 3'
          expect(subject.content).to eq ["For Dumb &amp; Dumber, 2 &gt; 3"]
        end

        context "when the element is _!" do
          it "does not escape XML" do
            subject.element '_!', 'For Dumb & Dumber, 2 > 3'
            expect(subject.content).to eq ["For Dumb & Dumber, 2 > 3"]
          end
        end
      end

      context "when the element name ends with !" do
        it "does not escape XML" do
          subject.element 'text!', 'For Dumb & Dumber, 2 > 3'
          expect(subject.content).to eq ["<text>", "For Dumb & Dumber, 2 > 3", "</text>"]
        end
      end
    end
  end

  describe '#css' do
    context "when no css rules were added" do
      it "returns an empty hash" do
        expect(subject.css).to eq({})
      end
    end

    context "when css rules were added" do
      before { subject.css = { fill: 'blue' } }

      it "returns the rules (hash or string)" do
        expect(subject.css[:fill]).to eq 'blue'
      end

      context "with an argument" do
        it "replaces the entire css attribute" do
          subject.css color: 'red'
          expect(subject.css).to eq({ color: 'red' })
        end
      end
    end
  end
  
  describe '#css=' do
    it "replaces the entire css attribute" do
      subject.css = { color: 'red' }
      expect(subject.css[:color]).to eq 'red'
    end
  end

  describe '#method_missing' do
    it "calls #element" do
      expect(subject).to receive(:element).with(:anything)
      subject.anything
    end

    it "passes arguments to #element" do
      expect(subject).to receive(:element).with(:anything, {:at=>"all"})
      subject.anything at: 'all'
    end
  end

  describe '#build' do
    it "evaluates in context" do
      subject.build { rect x: 10, y: 10 }
      expect(subject.content).to eq ['<rect x="10" y="10"/>']
    end
  end

  describe '#template' do
    context 'with a symbol' do
      it "loads a built in template" do
        subject.template = :html
        subject.circle of: 'trust'
        expect(subject.render).to eq "<svg width=\"100%\" height=\"100%\"\n  xmlns=\"http://www.w3.org/2000/svg\"\n  xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n\n\n<circle of=\"trust\"/>\n\n</svg>"
      end
    end

    context 'with a path' do
      let(:path) { 'spec/fixtures/custom_template.svg' }

      it "loads a custom template" do
        subject.template = path
        subject.circle of: 'trust'
        expect(subject.render).to eq "<!-- Custom Template -->\n<svg width=\"100%\" height=\"100%\">\n<circle of=\"trust\"/>\n</svg>"
      end
    end
  end

  describe '#render' do
    before do
      subject.circle radius: 10
    end

    it "generates full xml" do
      expect(subject.render).to match_approval('svg/full')
    end

    context "with template argument" do
      it "uses the provided template" do
        expect(subject.render template: :minimal).to match_approval('svg/minimal')
      end
    end

    context "with css elements" do
      let(:css) do
        {
          '.main' => {
            stroke: "green",
            stroke_width: 2
          }
        }
      end

      it "includes a css block" do
        subject.css = css
        expect(subject.render).to match_approval('svg/css')
      end
    end
  end

  describe '#to_s' do
    it "returns svg xml as string" do
      subject.circle radius: 10
      expect(subject.to_s).to eq '<circle radius="10"/>'
    end
  end

  describe '#save' do
    let(:filename) { 'test.svg' }

    before do
      File.unlink filename if File.exist? filename
      expect(File).not_to exist filename
      subject.circle radius: 10
    end

    it "saves to a file" do
      subject.save filename
      expect(File).to exist filename
    end

    it "saves xml" do
      subject.save filename
      expect(File.read filename).to match_approval('svg/full')
    end

    context "with template argument" do
      it "uses the provided template" do
        subject.save filename, template: :minimal
        expect(File.read filename).to match_approval('svg/minimal')
      end
    end

    context "when the filename does not end with .svg" do
      let(:filename) { 'test' }

      it "appends .svg to the filename" do
        subject.save filename
        expect(File).to exist "#{filename}.svg"
      end
    end
  end

end
