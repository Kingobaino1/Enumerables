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

end

p %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
p %w[ant bear cat].my_any?(/d/)                        #=> false
p [nil, true, 99].my_any?(Integer)                     #=> true
p [nil, true, 99].my_any?                              #=> true
p [].my_any?                                           #=> false

# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                        #=> false
# p [3, 3, 3].my_all?(3)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].all?                                           #=> true

# my_array = [1,2,3,3,7]
# a = my_array.my_select do |i|
  #  i == 0
# end
# p a

# b = [1,2,3,3,7].my_each_with_index do |value, index|
#  p value => index
# end

arr = [1,2,3,4]
a = arr.my_each 
p a