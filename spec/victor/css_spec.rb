require 'spec_helper'

describe CSS do

  describe '#to_s' do
    it "converts to a valid css" do
      css = {}
      css['.main'] = { 
        color: 'black', 
        background: 'white' 
      } 

      subject = CSS.new css
      expect(subject.to_s).to eq "  .main {\n    color: black;\n    background: white;\n  }"
    end
  end

end