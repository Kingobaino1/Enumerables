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
    while value < array.length do
      if block_given?
        yield(array[value],value)
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
  while i < self.length do
    if yield(self[i])
      array.push(self[i])
    end
    i += 1
  end
  array
end

  def my_all?(*args)
    if args.length == 0
     for i in self do
      if block_given?
       if (yield i) == false
         return false
       end
      else
        if i == nil
          return false
        else
          return true
        end
       end
      end
     return true
    else
      for i in self do
        if i != args[0]
          return false
        end
        true
      end
      true
    end
  end

  def my_any?(*args)
    if args.length == 0
     for i in self do
      if block_given?
       if (yield i)
         return true
       end
      else
        if i == nil
          return true
        else
          return false
        end
       end
      end
     return false
    else
      for i in self do
        if i == args[0]
          return true
        end
        false
      end
      false
    end
  end

  def my_none?(*args)
    if args.length == 0
    i = 0
    while i < self.length
      if block_given? 
        if yield(self[i])
          return false
        end
      else 
       if self[i]
      return false
      end
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
      j =+ 1
      end
      end
    true
  end
  def my_count(*num)
    count = 0
    if num.length == 0
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
        result.push( yield self[i])
      else
        result.push(my_proc.call(self[i]))
      end
      i += 1
    end
    result
  end
 
  def my_reduce
    reduce = nil
     first_element = self.shift
      self.unshift(first_element)
  
     i = 1 
    while i < self.length
      a = yield first_element, self[i]
        reduce = a 
        first_element = reduce
      i += 1 
    end
    reduce
  end
def multiply_els(arr)
  arr.my_reduce { |result, element| result * element }
end
end
      
             