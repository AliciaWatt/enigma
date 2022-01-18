require 'simplecov'
SimpleCov.start

require './lib/enigma'
# require './lib/message'
require './lib/cipher'
require './lib/convert'

 RSpec.describe Enigma do
 	before(:each) do
 		@enigma = Enigma.new
 	end
    it 'exists' do
     expect(@enigma).to be_instance_of(Enigma)
    end
 	  it 'has attributes' do
 	  end


  describe 'methods' do
    before(:each) do
      @message = 'hello world'
      @key = '02715'
      @date = '040895'
      @cyphertext = double('cyphertext')
      allow(@cyphertext).to receive(:decrypt).and_return(@message)
    end


    describe '#encrypt' do
      it 'returns a hash' do
        expect(@enigma.encrypt(@message, @key, @date)).to eq(Hash)
      end
      it 'returns a hash with correct keys' do
        expected = [:encryption, :key, :date]
        expect(@enigma.encrypt(@message, @key, @date).keys).to eq(expected)
      end
      it 'returns correct key' do
        expect(@enigma.encrypt(@message, @key, @date)[:key]).to eq(@key)
      end
      it 'returns correct date' do
        expect(@enigma.encrypt(@message, @key, @date)[:date]).to eq(@date)
      end
      it 'returns string as encryption' do
        expect(@enigma.encrypt(@message, @key, @date)[:encryption]).to be_a(String)
      end
      it 'returns correct encryption' do
        message_1 = 'Hello World!'
        expect(@enigma.encrypt(message_1, @key, @date)[:encryption]).to eq('Keder Ohulw')
      end
      it "can use the default date of today" do
        allow(@enigma).to receive(:today).and_return("170122")
        message_1 = 'Hello World!'
        expect(@enigma.encrypt(message_1, @key)[:encryption]).to eq('')
      end
    end

    describe '#decrypt' do
      it 'returns a hash' do
        expect(@enigma.decrypt(@cyphertext, @key, @date)).to be_a(Hash)
      end
      it 'returns a has with correct keys' do
        expected = [:decryption, :key, :date]
        expect(@enigma.decrypt(@cyphertext, @key, @date).keys).to eq(expected)
      end
      it 'returns correct key' do
        expect(@enigma.decrypt(@cyphertext, @key, @date)[:key]).to eq(@key)
      end
      it 'returns correct date' do
        expect(@enigma.decrypt(@cyphertext, @key, @date)[:date]).to eq(@date)
      end
      it 'returns a string as decryption' do
        expect(@enigma.decrypt(@cyphertext, @key, @date)[:decryption]).to be_a(String)
      end
      it 'returns correct decryption' do
        expect(@enigma.decrypt(@cyphertext, @key, @date)[:decryption]).to eq(@message)
      end
    end
  end
end
