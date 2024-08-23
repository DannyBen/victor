require 'yaml'

describe Victor::SVG do
  subject do
    described_class.new viewBox: '0 0 10 100' do
      text 'Hello world'
      rect x: 0, y: 0, width: 10, height: 100
      css['*'] = { font_family: 'Assistant' }
    end
  end

  describe 'YAML marshaling' do
    it 'serializes and deserializes correctly using YAML' do
      yaml_data = YAML.dump subject
      restored_object = YAML.unsafe_load yaml_data

      expect(restored_object).to be_a described_class
      expect(restored_object.render).to eq subject.render
    end
  end

  describe 'Ruby marshaling' do
    it 'serializes and deserializes correctly using Marshal' do
      marshaled_data = Marshal.dump subject
      restored_object = Marshal.load marshaled_data

      expect(restored_object).to be_a described_class
      expect(restored_object.render).to eq subject.render
    end
  end  
end
