# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Style/RedundantSelf, Style/GuardClause, Style/IfUnlessModifier, Metrics/BlockNesting, Metrics/ModuleLength

module Enumerable
  def my_each
    array = self if self.class == Array
    array = self.to_a if self.class == Range or self.class == Hash
    i = 0
    while i < array.length
      if block_given?
        yield array[i]
      else
        return to_enum(:my_each)
      end
      i += 1
    end
    self
  end

  def my_each_with_index
    array = self if self.class == Array
    array = self.to_a if self.class == Range or self.class == Hash
    value = 0
    while value < array.length
      if block_given?
        yield(array[value], value)
      else
        return to_enum(:my_each_with_index)
      end
      value += 1
    end
    array
  end

  def my_select
    arr = self if self.class == Array
    arr = self.to_a if self.class == Range
    array = []
    i = 0
    while i < arr.length
      if block_given?
        if yield arr[i]
          array.push(arr[i])
        end
      else
        return to_enum(:my_select)
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
      i = 0
      while i < self.length
        if block_given?
          if yield self[i]
            return true
          end
        else
          return true
        end
        i += 1
      end
    else
      j = 0
      while j < self.length
        if args[0] == self[j]
          return true
        end

        j += 1
      end

    end
    false
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
          true
        end

        j += 1
      end
    end
    true
  end

  def my_count(*num)
    array = self if self.class == Array
    array = self.to_a if self.class == Range
    count = 0
    if num.length.zero?
      i = 0
      while i < array.length
        if block_given?
          if yield array[i]
            count += 1
          end
        else
          return array.length
        end
        i += 1
      end
    elsif num.length == 1
      i = 0
      while i < array.length
        if num[0] == array[i]
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
end

def multiply_els(arr)
  arr.my_inject { |result, element| result * element }
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Style/RedundantSelf, Style/GuardClause, Style/IfUnlessModifier, Metrics/BlockNesting, Metrics/ModuleLength
