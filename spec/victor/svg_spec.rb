describe Victor::SVG do
  describe '#initialize' do
    it 'sets default attributes' do
      expect(subject.svg_attributes[:height]).to eq '100%'
      expect(subject.svg_attributes[:width]).to eq '100%'
    end

    context 'with attributes' do
      subject { described_class.new height: '90%', width: '80%', viewBox: '0 0 100 200' }

      it 'sets the attributes' do
        expect(subject.svg_attributes[:height]).to eq '90%'
        expect(subject.svg_attributes[:width]).to eq '80%'
        expect(subject.svg_attributes[:viewBox]).to eq '0 0 100 200'
      end
    end

    context 'with nested attributes' do
      subject { described_class.new style: { color: 'red', anything: 10 } }

      it 'converts the nested attributes to style' do
        expect(subject.svg_attributes.to_s).to match(/style="color:red; anything:10"/)
      end
    end

    context 'when a block is given' do
      subject do
        described_class.new do
          circle cx: 10, cy: 10, r: 20
        end
      end

      it 'builds with the block' do
        expect(subject.to_s).to eq '<circle cx="10" cy="10" r="20"/>'
      end
    end
  end

  context 'when appending SVGs' do
    let(:fire) { described_class.new }
    let(:earth) { described_class.new }
    let(:water) { described_class.new }

    before do
      fire.circle color: 'red'
      earth.triangle color: 'green'
      water.rect color: 'blue'
    end

    describe '#<<' do
      it 'pushes stringable objects as content' do
        subject << fire
        subject << earth
        subject << water

        expect(subject.to_s).to eq "<circle color=\"red\"/>\n<triangle color=\"green\"/>\n<rect color=\"blue\"/>"
      end
    end

    describe '#append' do
      it 'is an alias to #<<' do
        expect(subject.method(:append)).to eq subject.method(:<<)
      end
    end

    describe '#embed' do
      it 'is an alias to #<<' do
        expect(subject.method(:embed)).to eq subject.method(:<<)
      end
    end
  end

  describe '#setup' do
    it 'updates attributes' do
      subject.setup width: '80%', anything: 'ok'
      expect(subject.svg_attributes.to_s).to eq 'width="80%" anything="ok" height="100%"'
    end

    it 'sets default template' do
      subject.setup width: '80%'
      expect(subject.template).to eq :default
    end

    it 'sets default glue' do
      subject.setup width: '80%'
      expect(subject.glue).to eq "\n"
    end

    context 'when the provided attributes contain :template' do
      before { subject.template = :something_non_default }

      it 'sets template to the provided value' do
        subject.setup width: '80%', template: :minimal
        expect(subject.template).to eq :minimal
      end
    end

    context 'when the provided attributes contain :glue' do
      before { subject.glue = '---' }

      it 'sets glue to the provided value' do
        subject.setup width: '80%', glue: '==='
        expect(subject.glue).to eq '==='
      end
    end

    context 'when template is set in advance' do
      before { subject.template = :minimal }

      it 'does not alter the template value' do
        subject.setup width: '80%'
        expect(subject.template).to eq :minimal
      end
    end

    context 'when glue is set in advance' do
      before { subject.glue = '~~~' }

      it 'does not alter the glue value' do
        subject.setup width: '80%'
        expect(subject.glue).to eq '~~~'
      end
    end
  end

  describe '#element' do
    it 'generates xml without attributes' do
      subject.element 'anything'
      expect(subject.content).to eq ['<anything />']
    end

    it 'generates xml with attributes' do
      subject.element 'anything', at: 'all'
      expect(subject.content).to eq ['<anything at="all"/>']
    end

    it 'converts snake attributes to kebabs' do
      subject.element 'text', font_family: 'arial'
      expect(subject.content).to eq ['<text font-family="arial"/>']
    end

    context 'with hashed attributes' do
      it 'converts attributes to style syntax' do
        subject.element 'cool', style: { color: 'red', anything: 10 }
        expect(subject.content).to eq ['<cool style="color:red; anything:10"/>']
      end
    end

    context 'with a block' do
      it 'generates nested elements' do
        subject.build do
          universe do
            world do
              me
            end
          end
        end
        expect(subject.content).to eq ['<universe>', '<world>', '<me />', '</world>', '</universe>']
      end

      # This test is done since cases like this were not covered which caused
      # a passing build to actually be broken
      # https://github.com/DannyBen/victor/pull/59
      it "ignores the block's return value" do
        subject.build do
          element :group do
            element :one
            element :two
            element :three if false
          end
        end
        expect(subject.content).to eq ['<group>', '<one />', '<two />', '</group>']
      end
    end

    context 'with a plain text value' do
      it 'generates a container element' do
        subject.element 'prison', 'inmate', number: '6'
        expect(subject.content).to eq ['<prison number="6">', 'inmate', '</prison>']
      end

      it 'escapes XML' do
        subject.element 'text', 'For Dumb & Dumber, 2 > 3'
        expect(subject.content).to eq ['<text>', 'For Dumb &amp; Dumber, 2 &gt; 3', '</text>']
      end

      context 'when the element is an underscore' do
        it 'generates a tagless element' do
          subject.element '_', 'You are (not) surrounded!'
          expect(subject.content).to eq ['You are (not) surrounded!']
        end

        it 'escapes XML' do
          subject.element '_', 'For Dumb & Dumber, 2 > 3'
          expect(subject.content).to eq ['For Dumb &amp; Dumber, 2 &gt; 3']
        end

        context 'when the element is _!' do
          it 'does not escape XML' do
            subject.element '_!', 'For Dumb & Dumber, 2 > 3'
            expect(subject.content).to eq ['For Dumb & Dumber, 2 > 3']
          end
        end
      end

      context 'when the element name ends with !' do
        it 'does not escape XML' do
          subject.element 'text!', 'For Dumb & Dumber, 2 > 3'
          expect(subject.content).to eq ['<text>', 'For Dumb & Dumber, 2 > 3', '</text>']
        end
      end
    end
  end

  describe '#css' do
    context 'when no css rules were added' do
      it 'returns an empty hash' do
        expect(subject.css).to eq({})
      end
    end

    context 'when css rules were added' do
      before { subject.css = { fill: 'blue' } }

      it 'returns the rules (hash or string)' do
        expect(subject.css[:fill]).to eq 'blue'
      end

      context 'with an argument' do
        it 'replaces the entire css attribute' do
          subject.css color: 'red'
          expect(subject.css).to eq({ color: 'red' })
        end
      end
    end
  end

  describe '#css=' do
    it 'replaces the entire css attribute' do
      subject.css = { color: 'red' }
      expect(subject.css[:color]).to eq 'red'
    end
  end

  describe '#method_missing' do
    it 'calls #element' do
      expect(subject).to receive(:element).with(:anything)
      subject.anything
    end

    it 'passes arguments to #element' do
      expect(subject).to receive(:element).with(:anything, { at: 'all' })
      subject.anything at: 'all'
    end
  end

  describe '#respond_to?' do
    it 'returns true always' do
      expect(subject.respond_to? :anything).to be true
    end
  end

  describe '#build' do
    it 'evaluates in context' do
      subject.build { rect x: 10, y: 10 }
      expect(subject.content).to eq ['<rect x="10" y="10"/>']
    end
  end

  describe '#template' do
    context 'with a symbol' do
      it 'loads a built in template' do
        subject.template = :minimal
        subject.circle of: 'trust'
        expect(subject.render)
          .to eq <<~SVG.chomp
            <svg width="100%" height="100%">

            <circle of="trust"/>
            </svg>

          SVG
      end
    end

    context 'with a path' do
      let(:path) { 'spec/fixtures/custom_template.svg' }

      it 'loads a custom template' do
        subject.template = path
        subject.circle of: 'trust'
        expect(subject.render)
          .to eq "<!-- Custom Template -->\n<svg width=\"100%\" height=\"100%\">\n<circle of=\"trust\"/>\n</svg>"
      end
    end
  end

  describe '#render' do
    before do
      subject.circle radius: 10
      subject.circle radius: 20
    end

    it 'generates full xml' do
      expect(subject.render).to match_approval('svg/full')
    end

    context 'with template argument' do
      it 'uses the provided template' do
        expect(subject.render template: :minimal).to match_approval('svg/minimal')
      end
    end

    context 'with glue argument' do
      it 'uses the provided glue' do
        expect(subject.render glue: '').to match_approval('svg/glue')
      end
    end

    context 'with css elements' do
      let(:css) do
        {
          '.main' => {
            stroke:       'green',
            stroke_width: 2,
          },
        }
      end

      it 'includes a css block' do
        subject.css = css
        expect(subject.render).to match_approval('svg/css')
      end
    end
  end

  describe '#to_s' do
    before do
      subject.circle radius: 10
      subject.circle radius: 20
    end

    it 'returns svg xml as string' do
      expect(subject.to_s).to eq %[<circle radius="10"/>\n<circle radius="20"/>]
    end

    context "when glue is set to ''" do
      before { subject.glue = '' }

      it 'returns svg xml as string without newlines' do
        expect(subject.to_s).to eq '<circle radius="10"/><circle radius="20"/>'
      end
    end
  end

  describe '#save' do
    let(:filename) { 'test.svg' }

    before do
      FileUtils.rm_f filename
      expect(File).not_to exist filename
      subject.circle radius: 10
      subject.circle radius: 20
    end

    it 'saves to a file' do
      subject.save filename
      expect(File).to exist filename
    end

    it 'saves xml' do
      subject.save filename
      expect(File.read filename).to match_approval('svg/full')
    end

    context 'with template argument' do
      it 'uses the provided template' do
        subject.save filename, template: :minimal
        expect(File.read filename).to match_approval('svg/minimal')
      end
    end

    context 'with glue argument' do
      it 'uses the provided glue' do
        subject.save filename, glue: ''
        expect(File.read filename).to match_approval('svg/glue')
      end
    end

    context 'when the filename does not end with .svg' do
      let(:filename) { 'test' }

      it 'appends .svg to the filename' do
        subject.save filename
        expect(File).to exist "#{filename}.svg"
      end
    end
  end
end
