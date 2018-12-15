require 'spec_helper'

describe SVGBase do
  it "does not define #method_missing" do
    expect{ subject.polygon }.to raise_error NoMethodError
  end
end