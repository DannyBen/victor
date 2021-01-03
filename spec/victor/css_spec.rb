require 'spec_helper'

describe CSS do
  subject { described_class.new @css }

  describe '#to_s' do
    it "converts css one level deep" do
      @css = {}
      @css['.main'] = {
        color: 'black',
        background: 'white'
      }

      expect(subject.to_s).to match_approval 'css/css1'
    end

    it "converts css several levels deep" do
      @css = {}
      @css["@keyframes animation"] = {
        "0%" => {
          font_size: "10px"
        },
        "30%" => {
          font_size: "15px"
        }
      }

      expect(subject.to_s).to match_approval 'css/css2'
    end

    it "converts array values to single lines" do
      @css = {}
      @css['@import'] = [
        "some url",
        "another url"
      ]

      expect(subject.to_s).to match_approval 'css/css3'
    end

    context "when attributes are not a hash" do
      it "returns the attributes as is" do
        @css = ".class { color: blue }"
        expect(subject.to_s).to eq @css
      end
    end
  end

  describe '#render' do
    it "returns the css string wrapped inside style tags" do
      @css = { '.main' => { color: 'black' } }
      expect(subject.render).to match_approval 'css/render'
    end

    context "when the css is empty" do
      it "returns an empty string" do
        expect(subject.render).to be_empty
      end
    end        
  end

end