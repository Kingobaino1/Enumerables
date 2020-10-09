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

 def my_all?(args = nil)
    array = self if self.class == Array
    array = self.to_a if self.class == Range
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
    elsif args != nil
      j = 0 
      while j < array.size
       if !array[j].is_a?(Float) && args == Float
        return false
       elsif !array[j].is_a?(Integer) && args == Integer
        return false
       elsif !array[j].is_a?(Numeric) && args == Numeric
        return false 
       elsif args.is_a?(Numeric) && array[j] != args
        return false  
      end
      j += 1
      end
      
    end
    if args != nil && args.is_a?(Regexp)
      i = 0
      while i < self.size
        if !array[i].match?(args)
          return false
        end
        i += 1
      end 
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
    array = self if self.class == Array
    array = self.to_a if self.class == Range 
    result = []
    i = 0
    while i < array.length
          if block_given? && my_proc != nil
          result.push my_proc.call(array[i])
        elsif my_proc.nil?
          result.push yield array[i]
       else
         return to_enum(:my_map)
       end
      i += 1
    end
    result
  end

  def my_inject(my_procs = nil, my_proc = nil)
    array = self if self.class == Array
    array = self.to_a if self.class == Range 
    reduce = nil
    first_element = array.shift
    array.unshift(first_element)
    i = 1
    while i < array.length
      if block_given?
        block_value = yield first_element, array[i]
        reduce = block_value
        first_element = reduce
      elsif my_proc == :+
        proc_symbol = first_element + array[i]
        reduce = proc_symbol
        first_element = reduce
      elsif my_proc == :*
        proc_symbol = first_element * array[i]
        reduce = proc_symbol
        first_element = reduce
      elsif my_proc == :-
        proc_symbol = first_element - array[i]
        reduce = proc_symbol
        first_element = reduce
      elsif my_proc == :/
        proc_symbol = first_element / array[i]
        reduce = proc_symbol
        first_element = reduce
    
    end
      i += 1
    end 
    if my_procs == "" && my_proc == :+
     return my_procs.to_i + my_proc
    end
    reduce + my_procs.to_i
  end
end

def multiply_els(arr)
  arr.my_inject { |result, element| result * element }
end
p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
p %w[ant bear cat].my_all?(/a/)                        #=> false
p [1, 2, 3].my_all?(Integer)                       #=> true
p [false, true, 99].my_all?                              #=> false
p [].my_all?{|num| num == 0}   
arr = [1,2,3,4]
                                    #=> true
# my_proc = proc {|num| num * 2}
# my_procs = arr.my_map( &my_proc )
# my_procs = arr.my_map {|num| num ** 2}   
# my_procs = arr.my_map(&my_proc) {|num| num ** 2}  
# p (1..5).my_inject(:+)
#  p my_procs
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Style/RedundantSelf, Style/GuardClause, Style/IfUnlessModifier, Metrics/BlockNesting, Metrics/ModuleLength
