require './enumerables.rb'

describe Enumerable do
  let(:array) { [1, 2, 3, 4, 5] }
  let(:range) { (0..5) }
  let(:hash) { { a: 1, b: 2, c: 3 } }
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

  describe '#my_each_with_index' do
    it 'does not mutate array' do
      expect(array.my_each_with_index { |num, idx| num > 2 }).to eql(array)
    end

    it 'accepts a range' do
      expect(range.my_each_with_index { |num, idx| num > 2 }).to eql(range)
    end

    it 'accepts a hash' do
      expect(hash.my_each_with_index { |num, idx| num }).to eql(hash)
    end

    it 'returns Enumerator when block is not given' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns Enumerator when block is not given' do
      expect(array.my_select).to be_an(Enumerator)
    end

    it 'returns a filter array' do
      expect(array.my_select { |num| num > 3 }).to eql([4, 5])
    end

    it 'returns a filter array for a range' do
      expect(range.my_select { |num| num < 3 }).to eql([0, 1, 2])
    end

    it 'returns a filter array for a hash' do
      expect(hash.my_select { |k, v| v > 2 }).to eql({ c: 3 })
    end
  end

  describe "#my_any?" do
    it 'return true when any value on the array accomplish condition' do
      expect(array.my_any? {|n| n > 2}).to eql TRUE
    end

    it 'return false when none value on the array accomplish condition' do
      expect(array.my_any? {|n| n > 6}).to eql FALSE
    end

    it 'return true when any value on the range accomplish condition' do
      expect(range.my_any? {|n| n > 2}).to eql TRUE
    end

    it 'return false when none value on the range accomplish condition' do
      expect(range.my_any? {|n| n > 6}).to eql FALSE
    end

    it 'return true when any value on the hash accomplish condition' do
      expect(hash.my_any? {|k, v| v > 2}).to eql TRUE
    end

    it 'return false when none value on the hash accomplish condition' do
      expect(hash.my_any? {|k, v| v > 6}).to eql FALSE
    end
  end

  describe "#my_none?" do
    it 'return false when none value on the array accomplish condition' do
      expect(array.my_none? {|n| n > 2}).to eql FALSE
    end

    it 'return true when any value on the array accomplish condition' do
      expect(array.my_none? {|n| n > 6}).to eql TRUE
    end

    it 'return false when none value on the range accomplish condition' do
      expect(range.my_none? {|n| n > 2}).to eql FALSE
    end

    it 'return true when any value on the range accomplish condition' do
      expect(range.my_none? {|n| n > 6}).to eql TRUE
    end

    it 'return false when none value on the hash accomplish condition' do
      expect(hash.my_none? {|k, v| v > 2}).to eql FALSE
    end

    it 'return true when any value on the hash accomplish condition' do
      expect(hash.my_none? {|k, v| v > 6}).to eql TRUE
    end
  end
end