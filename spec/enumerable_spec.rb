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
      expect(array.my_each_with_index { |num, _idx| num > 2 }).to eql(array)
    end

    it 'accepts a range' do
      expect(range.my_each_with_index { |num, _idx| num > 2 }).to eql(range)
    end

    it 'accepts a hash' do
      expect(hash.my_each_with_index { |num, _idx| num }).to eql(hash)
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
      expect(hash.my_select { |_k, v| v > 2 }).to eql({ c: 3 })
    end
  end

  describe '#my_all' do
    it 'returns true when all values are true on array' do
      expect(array.my_all? { |n| n > 2 }).to eql FALSE
    end

    it 'returns false when one values is false on array' do
      expect(array.my_all? { |n| n > 6 }).to eql FALSE
    end

    it 'returns false when one values is false on range' do
      expect(range.my_all? { |n| n > 2 }).to eql FALSE
    end

    it 'returns true when all values are true on range' do
      expect(range.my_all? { |n| n < 6 }).to eql TRUE
    end

    it 'true when all values are true on hash' do
      expect(hash.my_all? { |_k, v| v < 7 }).to eql TRUE
    end

    it 'false when one values is false on range' do
      expect(hash.my_all? { |_k, v| v > 3 }).to eql FALSE
    end
  end

  describe '#my_any?' do
    it 'true when any value is true on the array' do
      expect(array.my_any? { |n| n > 2 }).to eql TRUE
    end

    it 'false when no value is true on the array' do
      expect(array.my_any? { |n| n > 6 }).to eql FALSE
    end

    it 'true when any value is true on the range' do
      expect(range.my_any? { |n| n > 2 }).to eql TRUE
    end

    it 'false when no value is true on the range' do
      expect(range.my_any? { |n| n > 6 }).to eql FALSE
    end

    it 'true when any value is true on the hash' do
      expect(hash.my_any? { |_k, v| v > 2 }).to eql TRUE
    end

    it 'false when no value is true on the hash' do
      expect(hash.my_any? { |_k, v| v > 6 }).to eql FALSE
    end
  end

  describe '#my_none?' do
    it 'true when no value is true on the array' do
      expect(array.my_none? { |n| n > 6 }).to eql TRUE
    end

    it 'false when any value is true on the array' do
      expect(array.my_none? { |n| n > 2 }).to eql FALSE
    end

    it 'true when no value is true on the range' do
      expect(range.my_none? { |n| n > 6 }).to eql TRUE
    end

    it 'false when any value is true on the range' do
      expect(range.my_none? { |n| n > 2 }).to eql FALSE
    end

    it 'true when no value is true on the hash' do
      expect(hash.my_none? { |_k, v| v > 6 }).to eql TRUE
    end

    it 'true when all value is false on the hash' do
      expect(hash.my_none? { |_k, v| v > 6 }).to eql TRUE
    end
  end

  describe '#my_count' do
    it 'length of the array if no block and no argument are given' do
      expect(array.my_count).to eql(5)
    end

    it 'number of elements in a range if no block and no argument are given' do
      expect(range.my_count).to eql(6)
    end

    it 'number of elements in a hash if no block and no argument are given' do
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
    it 'a new array for any given operation on each element of an array' do
      expect(array.my_map { |num| num * 2 }).to eql([2, 4, 6, 8, 10])
    end

    it 'a new array for any given operation on each element of a range' do
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
    it 'inject array with symbol' do
      expect(array.my_inject(:+)).to eql 15
    end

    it 'inject array with initial value and symbol' do
      expect(array.my_inject(0, :+)).to eql 15
    end

    it 'inject array with symbol' do
      expect(array.my_inject(:*)).to eql 120
    end

    it 'inject array with initial value and symbol' do
      expect(array.my_inject(1, :*)).to eql 120
    end

    it 'inject array when block is given' do
      expect(array.my_inject { |sum, num| sum + num }).to eql 15
    end

    it 'inject range when block is given' do
      expect(range.my_inject { |sum, num| sum + num }).to eql 15
    end

    it 'returns enumerator when no block or argument given' do
      expect(range.my_inject).to be_an(Enumerator)
    end
  end
end
