require 'spec_helper'

describe Attributes do
  attrs = nil
  subject { described_class.new attrs }

  it 'makes attributes accessible hash-style' do
    attrs = { hello: :world }
    expect(subject[:hello]).to eq :world
  end

  describe '#to_s' do
    it 'converts to xml attributes' do
      attrs = { duke: :nukem, vanilla: :ice }
      expect(subject.to_s).to eq 'duke="nukem" vanilla="ice"'
    end

    it 'escapes XML' do
      attrs = { href: '/speaker?needs=an&lifier', encode_me: '<>' }
      expect(subject.to_s).to eq 'href="/speaker?needs=an&amp;lifier" encode-me="&lt;&gt;"'
    end

    it 'converts nested attributes to style' do
      attrs = { dudes: { duke: :nukem, vanilla: :ice } }
      expect(subject.to_s).to eq 'dudes="duke:nukem; vanilla:ice"'
    end

    it 'converts array to space delimited string' do
      attrs = { points: [1, 2, 3, 4] }
      expect(subject.to_s).to eq 'points="1 2 3 4"'
    end
  end

  describe '#to_style' do
    it 'converts to style compatible string' do
      attrs = { duke: :nukem, vanilla: :ice }
      expect(subject.to_style).to eq 'duke:nukem; vanilla:ice'
    end

    it 'converts underscores to dashes' do
      attrs = { heroes_of_the_storm: 10 }
      expect(subject.to_style).to eq 'heroes-of-the-storm:10'
    end
  end

  describe '#[]' do
    it 'returns an attribute value' do
      attrs = { hello: :world }
      expect(subject[:hello]).to eq :world
    end
  end

  describe '#[]=' do
    it 'sets an attribute value' do
      attrs = { hello: :world }
      subject[:hello] = :overridden
      expect(subject[:hello]).to eq :overridden
    end
  end
end
