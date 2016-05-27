require 'spec_helper'
# require 'fileutils'

describe SVG do
  let(:svg) { SVG.new }

  # before do 
  #   FileUtils.rm_rf 'cache'
  # end

  describe '#new' do
    it "sets default properties" do
      expect(svg.height).to eq "100%"
      expect(svg.width).to eq "100%"
    end

    it "accepts initialization properties" do
      svg = SVG.new height: '90%', width: '80%'
      expect(svg.height).to eq "90%"
      expect(svg.width).to eq "80%"
    end
  end

  describe '#element' do
    it "generates xml without attributes" do
      result = svg.element 'anything'
      expect(result).to eq '<anything />'
    end

    it "generates xml with attributes" do
      result = svg.element 'anything', at: 'all'
      expect(result).to eq '<anything at="all"/>'
    end

    context 'with hashed attributes' do
      it "converts attributes to style syntax" do
        result = svg.element 'cool', dudes: { vanilla: 'ice', duke: 'nukem' }
        expect(result).to eq '<cool dudes="vanilla:ice; duke:nukem"/>'
      end
    end

    context "with blodk" do
      it "generates nested elements" do
        skip 'not implemented'
      end
    end
  end

  describe '#method_missing' do
    it "calls #element" do
      expect(svg).to receive(:element).with(:anything)
      svg.anything
    end

    it "passes arguments to #element" do
      expect(svg).to receive(:element).with(:anything, {:at=>"all"})
      svg.anything at: 'all'
    end
  end

  describe '#build' do
    it "evaluates in context" do
      svg.build { rect x: 10, y: 10 }
      expect(svg.content).to eq ['<rect x="10" y="10"/>']
    end
  end

  describe '#render' do
    it "generates full xml" do
      svg.circle radius: 10
      expect(svg.render).to match /DOCTYPE svg PUBLIC/
      expect(svg.render).to match /svg width="100%" height="100%"/
      expect(svg.render).to match /<circle radius="10"\/>/
    end
  end

  describe '#save' do
    let(:filename) { 'dev/test.svg' }

    before do 
      File.unlink filename if File.exist? filename
    end

    it "saves to a file" do
      svg.circle radius: 10
      expect(File).not_to exist filename
      svg.save filename
      expect(File).to exist filename
    end

    it "saves xml" do
      svg.circle radius: 10
      svg.save filename
      content = File.read filename
      expect(content).to match /<circle radius="10"\/>/
    end
  end

end