describe Victor::Component do
  describe '#body' do
    it 'raises a NotImplementedError' do
      expect { subject.body }.to raise_error(NotImplementedError)
    end
  end

  describe '#height' do
    it 'raises a NotImplementedError' do
      expect { subject.height }.to raise_error(NotImplementedError)
    end
  end

  describe '#width' do
    it 'raises a NotImplementedError' do
      expect { subject.width }.to raise_error(NotImplementedError)
    end
  end

  describe '#style' do
    it 'returns an empty hash' do
      expect(subject.style).to eq({})
    end
  end

  describe '#x' do
    it 'returns 0' do
      expect(subject.x).to eq 0
    end
  end

  describe '#y' do
    it 'returns 0' do
      expect(subject.y).to eq 0
    end
  end

  context 'when all required methods are implemented' do
    let(:svg) do
      double save: true, render: true, content: true, element: true, tag: true, to_s: true
    end

    before do
      allow(subject).to receive_messages(body: nil, width: 100, height: 100)
      allow(subject).to receive(:svg).and_return(svg)
    end

    describe '#save' do
      it 'delegates to SVG' do
        expect(svg).to receive(:save).with('filename')
        subject.save 'filename'
      end
    end

    describe '#render' do
      it 'delegates to SVG' do
        expect(svg).to receive(:render).with(template: :minimal)
        subject.render template: :minimal
      end
    end

    describe '#content' do
      it 'delegates to SVG' do
        expect(svg).to receive(:content)
        subject.content
      end
    end

    describe '#tag' do
      it 'delegates to SVG' do
        expect(svg).to receive(:tag).with(:rect)
        subject.tag :rect
      end
    end

    describe '#element' do
      it 'delegates to SVG' do
        expect(svg).to receive(:element).with(:rect)
        subject.element :rect
      end
    end

    describe '#to_s' do
      it 'delegates to SVG' do
        expect(svg).to receive(:to_s)
        subject.to_s
      end
    end

    describe '#append' do
      let(:component) { double svg: 'mocked_svg', merged_css: { color: 'red' } }
      let(:svg_instance) { double append: true }
      let(:merged_css) { double merge!: true }

      it 'appends another component and merges its css' do
        allow(subject).to receive_messages(svg_instance: svg_instance, merged_css: merged_css)
        expect(svg_instance).to receive(:append).with('mocked_svg')
        expect(merged_css).to receive(:merge!).with({ color: 'red' })

        subject.append component
      end
    end

    describe '#embed' do
      it 'is an alias to #append' do
        expect(subject.method(:embed)).to eq subject.method(:append)
      end
    end
  end
end
