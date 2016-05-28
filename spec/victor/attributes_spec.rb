require 'spec_helper'

describe Attributes do

  it "makes attributes accessible hash-style" do
    subject = Attributes.new
    subject[:hello] = :world
    expect(subject[:hello]).to eq :world
  end

  describe '#to_s' do
    it "converts to xml attributes" do
      subject = Attributes.new duke: :nukem, vanilla: :ice
      expect(subject.to_s).to eq 'duke="nukem" vanilla="ice"'
    end

    it "converts nested attributes to style" do
      subject = Attributes.new dudes: { duke: :nukem, vanilla: :ice }
      expect(subject.to_s).to eq 'dudes="duke:nukem; vanilla:ice"'
    end

    it "converts array to space delimited string" do
      subject = Attributes.new points: [1, 2, 3, 4]
      expect(subject.to_s).to eq 'points="1 2 3 4"'
    end
  end

  describe '#to_style' do
    it "converts to style compatible string" do
      subject = Attributes.new duke: :nukem, vanilla: :ice
      expect(subject.to_style).to eq 'duke:nukem; vanilla:ice'
    end
  end

end