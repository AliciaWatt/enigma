require 'simplecov'
SimpleCov.start

require './lib/helper_method'
include HelperMethod

describe HelperMethod do
  describe '#today' do
    it 'returns a string' do
      expect(today).to be_a(String)
    end
    it 'returns a six digit date' do
      expect(today.chars.count).to eq(6)
    end
  end

  describe 'random_key' do
    it 'generates a string' do
      expect(random_key).to be_a(String)
    end
    it 'generates a 5 character string' do
      expect(random_key.chars.count).to eq(5)
    end
  end
end
