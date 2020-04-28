require 'spec_helper'

describe 'victor/script' do
  subject { File.read 'spec/fixtures/dsl-script.rb' }

  it "includes Victor" do
    expect { eval subject }.to output("Victor::SVG\nVictor::SVG\ntrue\n").to_stdout
  end
end