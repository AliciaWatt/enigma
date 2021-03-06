require 'simplecov'
SimpleCov.start

require './lib/convert'
require './lib/cipher'

describe Convert do
  before (:each) do
    @message = 'hello world!'
    @key = '02715'
    @date = '040895'
    @cipher = Cipher.new(@key, @date)
    @convert = Convert.new(@cipher)
  end

  describe 'initialize' do
    it 'exists' do
      expect(@convert).to be_a(Convert)
    end
   it 'has attributes' do
     expect(@convert.cipher).to be(@cipher)
     expect(@convert.alphabet).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y","z", " "])
   end
end

describe 'methods' do
  describe '#valid?' do
    it 'returns true if alphabet character' do
      expect(@convert.valid?("a")).to eq(true)
      expect(@convert.valid?(" ")).to eq(true)
    end
    it 'returns false if character is not in alphabet' do
      expect(@convert.valid?("!")).to eq(false)
      expect(@convert.valid?("3")).to eq(false)
      expect(@convert.valid?("$")).to eq(false)
    end
  end

  describe '#upcase?' do
    it 'returns true if character is not lowercase' do
      expect(@convert.upcase?('A')).to eq(true)
      expect(@convert.upcase?('!')).to eq(true)
    end
    it 'returns false if character is lowercase' do
      expect(@convert.upcase?('a')).to eq(false)
    end
  end

  describe '#scrub' do
    it 'removes non alphabet characters' do
      expect(@convert.scrub('he&ll*o wo0r_ld.')).to eq('hello world')
    end
    it 'returns lowercase' do
      expect(@convert.scrub('HELLO World')).to eq('hello world')
    end
    it 'returns correct message' do
      expect(@convert.scrub('he&ll*o wo0r_ld.')).to eq('hello world')
    end
  end

  describe '#build_letter_message' do
    it 'returns an array' do
      expect(@convert.build_letter_message('hey')).to be_a(Array)
    end
    it 'returns a converted array' do
      message = 'hey! 3D'
      expect(@convert.build_letter_message(message)).to eq(['h', 'e', 'y', ' ', 'd'])
    end
  end
  describe '#build_index_message' do
    it 'returns an array' do
      expect(@convert.build_index_message('hey')).to be_a(Array)
    end
      it "returns a converted array" do
        message = 'hey! 3D'
        expect(@convert.build_index_message(message)).to eq([7, 4, 24, 26, 3])
      end
    end

    describe '#shift' do
      it 'retruns an array' do
        expect(@convert.shift([0,0,0,0,0,0,0,0])).to be_a(Array)
      end
      it 'returns an array of integers' do
        expect(@convert.shift([0,0,0,0,0,0,0,0]).all?{|v|v.class == Integer}).to eq(true)
      end
      it 'retruns correctly shifted array of integers' do
        expected = [3, 0, 19, 20, 3, 0, 19, 20]
        expect(@convert.shift([0,0,0,0,0,0,0,0])).to eq(expected)
      end
    end

    describe '#unshift' do
      it 'returns an array' do
        expect(@convert.unshift([0,0,0,0,0,0,0,0])).to be_a(Array)
      end
      it 'returns an array of integers' do
        expect(@convert.unshift([0,0,0,0,0,0,0,0]).all?{|v|v.class == Integer}).to eq(true)
      end
      it 'returns correct shifted array of integers' do
        expected = [24, 0, 8, 7, 24, 0, 8, 7]
        expect(@convert.unshift([0,0,0,0,0,0,0,0])).to eq(expected)
      end
    end

    describe '#finish_message' do
      it 'returns a string' do
        expect(@convert.finish_message('keder ohulw!', @message)).to be_a(String)
      end
      it 'returns a string with correct uppercase' do
        expect(@convert.finish_message('keder ohulw!',"Hello world")).to eq('Keder ohulw')
      end
      it 'returns a string with original punctuation' do
        expect(@convert.finish_message('keder ohulw', 'hello world!')).to eq('keder ohulw!')
      end
      it 'returns a string with og punctuation and uppercase letters' do
        expect(@convert.finish_message('keder ohulw', 'He_llo W0orld.')).to eq('Ke_der O0hulw.')
      end
    end

    describe '#encrypt' do
      it 'returns a string' do
        expect(@convert.encrypt('hello world!')).to be_a(String)
      end
      it 'returns an encrypted string' do
      expect(@convert.encrypt('hello world')).to eq('keder ohulw')
      end
    end

    describe '#decrypt' do
      it 'returns a string' do
        expect(@convert.decrypt('keder ohulw')).to be_a(String)
      end
      it 'returns a decrypted string' do
        expect(@convert.decrypt('keder ohulw')).to eq('hello world')
      end
    end
    describe '#encrypt_message' do
      it 'returns a string' do
        expect(@convert.encrypt_message('He_llo W0orld.')).to be_a(String)
      end
      it 'returns encrypted string' do
        expect(@convert.encrypt_message('hello world!')).to eq('keder ohulw')
        expect(@convert.encrypt_message('He_llo W0orld.')).to eq('Ke_der O0hulw.')
      end
    end
    describe '#decrypt_message' do
      it 'returns a string' do
        expect(@convert.decrypt_message('He_llo W0orld..')).to be_a(String)
      end
      it 'returns decrypted string' do
        expect(@convert.decrypt_message('keder ohulw')).to eq('hello world')
        expect(@convert.decrypt_message('Ke_der O0hulw.')).to eq('He_llo W0orld.')
      end
    end
  end
end
