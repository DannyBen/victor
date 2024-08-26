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
    before do
      allow(subject).to receive(:body)
      allow(subject).to receive(:width).and_return 100
      allow(subject).to receive(:height).and_return 100
    end

    describe '#save' do
      it 'delegates to SVG' do
        expect(subject.svg).to receive(:save).with('filename')
        subject.save 'filename'
      end
    end

    describe '#render' do
      it 'delegates to SVG' do
        expect(subject.svg).to receive(:render).with(template: :minimal)
        subject.render template: :minimal
      end
    end

    describe '#vector' do
      it 'returns an SVG object' do
        expect(subject.vector).to be_a Victor::SVG
      end
    end

    describe '#add' do
      it 'is an alias to #vector' do
        expect(subject.add).to equal subject.vector
      end
    end

    describe '#css' do
      it 'returns a duplicate of #style' do
        expect(subject.css).to eq subject.style
        expect(subject.css).not_to equal subject.style
      end
    end

    describe '#append' do
      let(:component) { double(:Component, svg: 'mocked_svg', css: { color: 'red' }) }

      it 'appends another component and merges its css' do
        expect(subject.vector).to receive(:append).with('mocked_svg')
        expect(subject.css).to receive(:merge!).with({ color: 'red' })

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
