# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Style/GuardClause, Metrics/BlockNesting, Metrics/ModuleLength

module Enumerable
  def my_each
    array = to_a
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < array.length
      yield array[i]

      i += 1
    end
    self
  end

  def my_each_with_index
    array = to_a
    return to_enum(:my_each_with_index) unless block_given?

    value = 0
    while value < array.length
      yield(array[value], value)

      value += 1
    end
    self
  end

  def my_select
    arr = to_a
    h = {}
    return to_enum(:my_select) unless block_given?

    array = []
    i = 0
    while i < arr.length
      array.push(arr[i]) if yield arr[i]
      i += 1
    end
    if self.class == Array || self.class == Range
      array
    elsif self.class == Hash
      a = array.flatten
      a.my_each_with_index do |v, i|
        if i.even?
          h[v] = a[i + 1]
        end

      end
      h
    end
  end

  def my_all?(args = nil)
    array = to_a
    if args.nil?
      i = 0
      while i < array.size
        if block_given? && !(yield array[i])
          return false
        elsif !block_given? && (array[i].nil? || !array[i])
          return false
        end

        i += 1
      end
    elsif !args.nil?
      j = 0
      while j < array.size
        if !array[j].is_a?(Float) && args == Float
          return false
        elsif !array[j].is_a?(Integer) && args == Integer
          return false
        elsif !array[j].is_a?(Numeric) && args == Numeric
          return false
        elsif (args.is_a?(Numeric) || args.is_a?(String)) && array[j] != args
          return false
        end

        j += 1
      end

    end
    if !args.nil? && args.is_a?(Regexp)
      i = 0
      while i < size
        return false unless array[i].match?(args)

        i += 1
      end
    end
    true
  end

  def my_any?(args = nil)
    array = to_a
    if args.nil?
      i = 0
      while i < array.size
        if block_given? && (yield array[i])
          return true
        elsif !block_given? && (array[i])
          return true
        end

        i += 1
      end
    elsif !args.nil?
      j = 0
      while j < array.size
        if array[j].is_a?(Float) && args == Float
          return true
        elsif array[j].is_a?(Integer) && args == Integer
          return true
        elsif array[j].is_a?(Numeric) && args == Numeric
          return true
        elsif (args.is_a?(Numeric) || args.is_a?(String)) && array[j] == args
          return true
        end

        j += 1
      end
    end
    if !args.nil? && args.is_a?(Regexp)
      i = 0
      while i < size
        return true if array[i].match?(args)

        i += 1
      end
    end
    false
  end

  def my_none?(args = nil)
    array = to_a
    if args.nil?
      i = 0
      while i < array.size
        if block_given? && (yield array[i])
          return false
        elsif !block_given? && (array[i])
          return false
        end

        i += 1
      end
    elsif !args.nil?
      j = 0
      while j < array.size
        if array[j].is_a?(Float) && args == Float
          return false
        elsif array[j].is_a?(Integer) && args == Integer
          return false
        elsif array[j].is_a?(Numeric) && args == Numeric
          return false
        elsif (args.is_a?(Numeric) || args.is_a?(String)) && array[j] == args
          return false
        end

        j += 1
      end
    end
    if !args.nil? && args.is_a?(Regexp)
      i = 0
      while i < size
        return false if array[i].match?(args)

        i += 1
      end
    end
    true
  end

  def my_count(*num)
    array = to_a
    count = 0
    if num.length.zero?
      i = 0
      while i < array.length
        if block_given?
          count += 1 if yield array[i]
        else
          return array.length
        end
        i += 1
      end
    elsif num.length == 1
      i = 0
      while i < array.length
        count += 1 if num[0] == array[i]
        i += 1
      end
    end
    count
  end

  def my_map(my_proc = nil)
    array = to_a
    return to_enum(:my_map) unless block_given? || my_proc

    result = []
    if my_proc
      i = 0
      while i < array.length
        result.push my_proc.call(array[i])
        i += 1
      end
    else
      j = 0
      while j < array.size
        result.push(yield array[j])
        j += 1
      end
    end
    result
  end

  def my_inject(*args)
    array = to_a
    reduce = nil
    first_element = array.shift
    array.unshift(first_element)
    if args.size.zero? || (args.size == 1 && block_given?)
      if args.size == 1
        first_element = args[0]
        i = 0
      else
        i = 1
      end
      while i < array.length
        if block_given?
          block_value = yield first_element, array[i]
          reduce = block_value
          first_element = reduce
        elsif !block_given? || !args.size.zero?
          return self.to_enum(:my_inject)
        end
        i += 1
      end
    elsif args.size == 1
      j = 1
      while j < array.length
        operator = args[0].to_s
        proc_symbol = (first_element.send operator, array[j])
        reduce = proc_symbol
        first_element = reduce
        j += 1
      end
    elsif args.size == 2
      j = 1
      reduce_b = nil
      operator = args[1].to_s
      while j < array.length
        proc_symbol = (first_element.send operator, array[j])
        reduce_b = proc_symbol
        first_element = reduce_b
        j += 1
      end
      reduce_b = args[0].send operator, reduce_b
    end
    if args.size.zero? || args.size == 1
      reduce
    else
      reduce_b
    end
  end
end

def multiply_els(arr)
  arr.my_inject { |result, element| result * element }
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Style/GuardClause, Metrics/BlockNesting, Metrics/ModuleLength
