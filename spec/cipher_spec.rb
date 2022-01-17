require './cipher'

describe Cipher do
  before(:each) do
    @key = '02715'
    @date = '040895'
    @cipher = Cipher.new(@key, @date)
  end

  describe 'initialize' do
    it 'exists' do
      expect(@cipher).to be_a(Cipher)
    end
    it 'has attributes' do
      expect(@cipher.key).to eq(@key)
      expect(@cipher.date).to eq(@date)
      expect(@cipher.shifts).to be_a(Array)
    end
    it 'initializes an array of shifts' do
      allow(@enigma).to receive(:calc_shifts).and_return([1,2,3,4])
      expect(@cipher.shifts).to eq(@enigma.calc_shifts)
    end
  end

  describe 'methods' do
    before(:each) do
    end
    describe '#keys_from_key' do
      it 'returns an array' do
        expect(@cipher.keys_from_key).to be_a(Array)
      end
      it 'returns an array of integers' do
        expect(@cipher.keys_from_key.all?{|v|v.class = Integer}).to eq(true)
      end
      it 'returns correct offsets' do
        expect(@cipher.keys_from_key).to eq([2,27,71,15])
      end
    end

    describe '#calc_offsets' do
      it 'returns an array' do
        expect(@cipher.calc_offsets).to be_a(Array)
      end
      it 'returns an array of integers' do
        expect(@cipher.calc_offsets.all?{|v|v.class = Integer}).to eq(true)
      end
      it 'returns correct offsets' do
        expect(@cipher.calc_offsets).to eq([6,6,4,1])
      end
    end
    describe '#calc_shifts' do
      it 'returns an array' do
        expect(@cipher.calc_shifts).to be_a(Array)
      end
      it 'returns an array of integers' do
        expect(@cipher.calc_shifts.all?{|v|v.class = Integer}).to eq(true)
      end
      it 'returns correct offsets' do
        expect(@cipher.calc_shifts).to eq([8,33,75,16])
      end
    end
  end
end
