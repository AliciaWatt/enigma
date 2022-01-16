require 'simplecov'
Simplecov.start

require './lib/enigma'

 RSpec.describe Enigma do
 	before(:each) do
 		@enigma = Enigma.new
 	end

  it 'exists' do
    expect(@enigma).to be_instance_of(Enigma)
  end

 	it 'has attributes' do
 		expect(@enigma.message).to eq("hello world")
    expect(@enigma.key).to eq('')
    expect(@enigma.date).to eq('')
 	end
 end
