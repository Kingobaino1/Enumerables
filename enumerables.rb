# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/AbcSize, Style/RedundantSelf, Style/GuardClause, Style/IfUnlessModifier, Style/For, Style/IfUnlessModifier, Metrics/BlockNesting, Metrics/ModuleLength

module Enumerable
  def my_each
    array = self if self.class == Array
    array = self.to_a if self.class == Range
    i = 0
    while i < array.length
      if block_given?
        yield array[i]
      else
        return "\#<Enumerator: #{self}:my_each>"
      end
      i += 1
    end
    self
  end

  def my_each_with_index
    array = self if self.class == Array
    array = self.to_a if self.class == Range
    value = 0
    while value < array.length
      if block_given?
        yield(array[value], value)
      else
        return "\#<Enumerator: #{self}:my_each_with_index>"
      end
      value += 1
    end
    array
  end

  def my_select
    array = []
    i = 0
    while i < self.length
      if yield self[i]
        array.push(self[i])
      end
      i += 1
    end
    array
  end

  def my_all?(*args)
    if args.length.zero?
      i = 0
      while i < self.length
        if block_given?
          if yield(self[i]) == false
            return false
          end
        elsif self[i].nil?
          return false
        else
          return true
        end
        i += 1
      end
    else
      return false
    end
    true
  end
  

  def my_any?(*args)
    if args.length.zero?
      for i in self do
        if block_given?
          if yield i
            return true
          end
        elsif i.nil?
          return true
        else
          return false
        end
      end
      false
    else
      for i in self do
        if i == args[0]
          return true
        end

      end
      false
    end
  end

  def my_none?(*args)
    if args.length.zero?
      i = 0
      while i < self.length
        if block_given?
          if yield self[i]
            return false
          end
        elsif self[i]
          return false
        end
        i += 1
      end
    else
      j = 0
      while j < self.length
        if self[j] == args[0]
          return false
        else
          return true
        end
        j += 1
      end

    end
    true
  end

  def my_count(*num)
    count = 0
    if num.length.zero?
      i = 0
      while i < self.length
        if block_given?
          if yield self[i]
            count += 1
          end
        else
          return self.length
        end
        i += 1
      end
    elsif num.length == 1
      i = 0
      while i < self.length
        if num[0] == self[i]
          count += 1
        end
        i += 1
      end
    end
    count
  end

  def my_map(my_proc = nil)
    result = []
    i = 0
    while i < self.length
      if block_given?
        result.push yield self[i]
      else
        result.push my_proc.call(self[i])
      end
      i += 1
    end
    result
  end

  def my_inject(my_proc = nil)
    reduce = nil
    first_element = self.shift
    self.unshift(first_element)
    i = 1
    while i < self.length
      if block_given?
        block_value = yield first_element, self[i]
        reduce = block_value
        first_element = reduce
      elsif my_proc == :+
        proc_symbol = first_element + self[i]
        reduce = proc_symbol
        first_element = reduce
      elsif my_proc == :*
        proc_symbol = first_element * self[i]
        reduce = proc_symbol
        first_element = reduce
      elsif my_proc == :-
        proc_symbol = first_element - self[i]
        reduce = proc_symbol
        first_element = reduce
      elsif my_proc == :/
        proc_symbol = first_element / self[i]
        reduce = proc_symbol
        first_element = reduce
      end
      i += 1
    end
    reduce
  end

  def multiply_els(arr)
    arr.my_inject { |result, element| result * element }
  end
end

p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_all?(/t/)                        #=> false
p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
p [nil, true, 99].my_all?                              #=> false
p [].my_all?                                           #=> true

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Metrics/AbcSize, Style/RedundantSelf, Style/GuardClause, Style/IfUnlessModifier, Style/For, Style/IfUnlessModifier, Metrics/BlockNesting