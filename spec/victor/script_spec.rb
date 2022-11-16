require 'spec_helper'

describe 'victor/script' do
  subject { File.read 'spec/fixtures/dsl_script.rb' }

  it 'includes Victor and Victor::DSL' do
    expect { eval subject }.to output("Victor::SVG\nVictor::SVG\ntrue\n").to_stdout
  end
end
