describe DSL do
  subject { Class.new { include DSL }.new }

  describe '#svg' do
    it 'returns a Victor::SVG.instance' do
      expect(subject.svg).to be_a Victor::SVG
    end
  end

  describe '#setup' do
    it 'forwards the call to the svg object' do
      expect(subject.svg).to receive(:setup).with(attrib: :utes)
      subject.setup attrib: :utes
    end
  end

  describe '#build' do
    it 'forwards the call to the svg object' do
      expect(subject.svg).to receive(:build)
      subject.build
    end
  end

  describe '#save' do
    it 'forwards the call to the svg object' do
      expect(subject.svg).to receive(:save).with('filename')
      subject.save 'filename'
    end
  end

  describe '#render' do
    it 'forwards the call to the svg object' do
      expect(subject.svg).to receive(:render)
      subject.render
    end
  end

  describe '#css' do
    it 'forwards the call to the svg object' do
      expect(subject.svg).to receive(:css)
      subject.css
    end
  end
end
