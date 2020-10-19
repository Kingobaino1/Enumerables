require './enumerables.rb'

describe Enumerable do
  let(:array) { [1, 2, 3, 4, 5] }
  let(:range) { (0..5) }
  let(:hash) { { key: 'value' } }
  describe '#my_each' do
    it 'does not mutate array' do
      expect(array.my_each { |num| num > 2 }).to eql(array)
    end

    it 'accepts a range' do
      expect(range.my_each { |num| num > 2 }).to eql(range)
    end

    it 'accepts a hash' do
      expect(hash.my_each { |num| num }).to eql(hash)
    end

    it 'returns Enumerator when block is not given' do
      expect(array.my_each).to be_an(Enumerator)
    end
  end
end
