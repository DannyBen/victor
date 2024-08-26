require_relative '../fixtures/components/component_set1'

describe 'Component subclassing' do
  subject { ComponentSet1::Main.new }

  describe '#render' do
    it 'returns the expected SVG' do
      expect(subject.render).to match_approval 'component/set1/render'
    end
  end
end
