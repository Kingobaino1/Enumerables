require './enumerables.rb'

describe Enumerable do
  let(:array) { [1, 2, 3, 4, 5] }
  let(:range) { (0..5) }
  let(:hash) { { a: 1, b: 2, c: 3 } }
  let(:my_proc) { proc { |num| num + 1 } }
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

  describe '#my_all' do
    it 'return true when all value on the array accomplish condition' do
      expect(array.my_all? {|n| n > 2}).to eql FALSE
    end

    it 'return false when none value on the array accomplish condition' do
      expect(array.my_all? {|n| n > 6}).to eql FALSE
    end

    it 'return false when some value on the range did not accomplish condition' do
      expect(range.my_all? {|n| n > 2}).to eql FALSE
    end

    it 'return false when all value on the range accomplish condition' do
      expect(range.my_all? {|n| n < 6}).to eql TRUE
    end

    it 'return true when all value on the hash accomplish condition' do
      expect(hash.my_all? {|k, v| v < 7}).to eql TRUE
    end

    it 'return false when any value on the hash do not accomplish condition' do
      expect(hash.my_all? {|k, v| v > 3}).to eql FALSE
    end
  end

  describe '#my_any?' do
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

  describe '#my_none?' do
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

  describe '#my_count' do
    it 'returns the length of the array if no block and no argument are given' do
      expect(array.my_count).to eql(5)
    end

    it 'returns the number of elements in a range if no block and no argument are given' do
      expect(range.my_count).to eql(6)
    end

    it 'returns the number of elements in a hash if no block and no argument are given' do
      expect(hash.my_count).to eql(3)
    end

    it 'returns the number of elements satisfying the block condition' do
      expect(array.my_count { |num| num == 2 }).to eql(1)
    end

    it 'returns the number of elements that are equal to the argument value' do
      expect(array.my_count(1)).to eql(1)
    end
  end

  describe '#my_map' do
    it 'returns a new array for any given operation on each element of an array' do
      expect(array.my_map { |num| num * 2 }).to eql([2, 4, 6, 8, 10])
    end

    it 'returns a new array for any given operation on each element of a range' do
      expect(range.my_map { |num| num * 2 }).to eql([0, 2, 4, 6, 8, 10])
    end

    it 'returns Enumerator when block is not given' do
      expect(array.my_map).to be_an(Enumerator)
    end

    it 'accepts a proc' do
      expect(array.my_map(&my_proc)).to eql([2, 3, 4, 5, 6])
    end
  end

  describe '#my_inject' do
    it 'should return the final sum accumulator of all array numbers' do
      expect(array.my_inject(:+)).to eql 15
    end

    it 'should return the final sum accumulator of all array numbers with initial value and symbol given' do
      expect(array.my_inject(0, :+)).to eql 15
    end

    it 'should return the final multiple accumulator of all array numbers' do
      expect(array.my_inject(:*)).to eql 120
    end

    it 'should return the final multiple accumulator of all array numbers with initial value and symbol given' do
      expect(array.my_inject(1, :*)).to eql 120
    end

    it 'should return block accumulator of all array numbers' do
      expect(array.my_inject {|sum, num| sum + num}).to eql 15
    end

    it 'should return block accumulator for a range' do
      expect(range.my_inject {|sum, num| sum + num}).to eql 15
    end

    it 'returns enumerator when no block or argument given' do
      expect(range.my_inject).to be_an(Enumerator)
    end
  end
end
