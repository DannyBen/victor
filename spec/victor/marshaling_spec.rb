describe Victor::Marshaling do
  subject do
    Class.new do
      include Victor::Marshaling
    end.new
  end

  describe '#marshaling' do
    it 'raises a NotImplementedError' do
      expect { subject.marshaling }.to raise_error(NotImplementedError)
    end
  end
end
