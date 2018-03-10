require 'spec_helper'

describe CSS do

  describe '#to_s' do
    it "converts css one level deep" do
      css = {}
      css['.main'] = {
        color: 'black',
        background: 'white'
      }

      subject = CSS.new css
      expect(subject.to_s).to eq fixture('css1.css')
    end

    it "converts css several levels deep" do
      css = {}
      css["@keyframes animation"] = {
        "0%" => {
          font_size: "10px"
        },
        "30%" => {
          font_size: "15px"
        }
      }

      subject = CSS.new css
      expect(subject.to_s).to eq fixture('css2.css')
    end

    it "converts array values to single lines" do
      css = {}
      css['@import'] = [
        "some url",
        "another url"
      ]

      subject = CSS.new css
      expect(subject.to_s).to eq fixture('css3.css')
    end
  end

end