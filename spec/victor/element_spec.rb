require 'spec_helper'

describe Element do

  describe '::new' do
    context "with name only" do
      subject { described_class.new "circle" }

      it "properly sets all instance variables" do
        expect(subject.name).to eq "circle"
        expect(subject.attributes).to be_an Attributes
        expect(subject.value).to be_nil
        expect(subject.escape).to be true
      end
    end

    context "with name, value" do
      subject { described_class.new "circle", "round" }

      it "properly sets all instance variables" do
        expect(subject.name).to eq "circle"
        expect(subject.attributes.attributes).to eq({})
        expect(subject.value).to eq "round"
        expect(subject.escape).to be true
      end
    end

    context "with name, value, attributes" do
      subject { described_class.new "circle", "round", border: 1 }

      it "properly sets all instance variables" do
        expect(subject.name).to eq "circle"
        expect(subject.attributes[:border]).to eq 1
        expect(subject.value).to eq "round"
        expect(subject.escape).to be true
      end
    end

    context "with name, attributes" do
      subject { described_class.new "circle", border: 1 }

      it "properly sets all instance variables" do
        expect(subject.name).to eq "circle"
        expect(subject.attributes[:border]).to eq 1
        expect(subject.value).to be_nil
        expect(subject.escape).to be true
      end
    end

    context "with a name that ends with !" do
      subject { described_class.new "circle!" }

      it "sets escape to false" do
        expect(subject.escape).to be false
      end

      it "removes the ! from the name" do
        expect(subject.name).to eq "circle"
      end
    end
  end

  describe '#render' do
    context "with a value" do
      subject { described_class.new "circle", "round" }

      it "returns an array of element parts" do
        expect(subject.render).to eq ["<circle>", "round", "</circle>"]
      end
    end

    context "with a block" do
      subject { described_class.new "circle" }

      it "returns an array of element parts" do
        expect(subject.render { ["inside content"] }).to eq ["<circle>", "inside content", "</circle>"]
      end
    end

    context "without a block or a value" do
      subject { described_class.new "circle", border: 1 }

      it "returns an array of element parts" do
        expect(subject.render).to eq ['<circle border="1"/>']
      end
    end
  end

end
