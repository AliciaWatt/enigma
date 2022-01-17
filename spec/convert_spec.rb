require './lib/convert'
require './lib/cipher'

describe Convert do
  before (:each) do
    @message = 'hello world'
    @key = '02715'
    @date = '040895'
    @cipher = Cipher.new(@key, @date)
    @convert = Convert.new(@message, @cipher)
  end

  describe 'initialize' do
    expect(@convert).to be_a(Convert)
  end
  it 'has attributes' do
    expect(@convert.message).to eq(@message)
    expect(@convert.cipher).to be(Cipher)
    expect(@convert.index_message).to be(Array)
    expect(@convert.letter_message).to be(Array)
    expect(@convert.alphabet).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y","z", " "])
  end
  it 'initializes letter_message array' do
    expected = ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"]
    expect(@convert.letter_message).to eq(expected)
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

  describe '#scrub' do
    it 'removes non alphabet characters' do
      expect(@convert.scrub('h&ll* w0r_ld.')).to eq('hello world')
    end
    it 'returns lowercase' do
      expect(@convert.scrub('HELLO World')).to eq('hello world')
    end
    it 'returns correct message' do
      expect(@convert.scrub('h&Ll* w0r_ld.')).to eq('hello world')
    end
  end

  describe '#letter_message' do
    it 'returns an array' do
      expect(@convert.letters_to_array('hey')).to be_a(Array)
    end
    it 'returns a converted array' do
      message = 'hey! 3D'
      expect(@convert.letters_to_array(message)).to eq(['h', 'e', 'y', ' ', 'd'])
    end
  end
  describe '#index_message' do
    it 'returns an array' do
      expect(@convert.index_message('hey')).to be_a(Array)
      it "returns a converted array" do
        message = 'hey! 3D'
        expect(@convert.index_message(message)).to eq([7, 4, 24, 26, 3])
      end
    end

    describe '#shift' do
      it 'retruns an array' do
        expect(@convert.shift(@convert.index_message)).to be_a(Array)
      end
      it 'returns an array of integers' do
        expect(@convert.shift(@convert.index_message.all?{|v|v.class == Integer})).to eq(true)
      end
      it 'retruns correctly shifted array of integers' do
        expected = [10, 4, 3, 4, 17, 26, 14, 14, 20, 11, 22]
        expect(@convert.shift(@convert.index_message)).to eq(expected)
      end
    end

    describe '#finish_message' do
      it 'returns a string' do
        expect(@convert.finish_message('keder ohulw!')).to be_a(String)
      end
      it 'returns a string with correct uppercase' do
        @convert_2 = Convert.new('Hello World')
        expect(@convert.finish_message('keder ohulw')).to eq('keder ohulw!')
      end
      it 'returns a string with original punctuation' do
        convert_2 = Convert.new('hello world!')
        expect(@convert.finish_message('keder ohulw')).to eq('keder ohulw!')
      end
      it 'returns a string with og punctuation and uppercase letters' do
        expect(convert_2 = Convert.new('H_llo W0rld.')).to eq('Ke_der O0hulw.')
      end
    end

    describe '#encrypt' do
      it 'returns a string' do
        expect(@convert.encrypt).to eq('keder ohulw')
      end
    end

    describe '#decrypt' do
      it 'returns a string' do
        expect(@convert.decrypt).to eq('hello world')
      end
    end
  end
end
