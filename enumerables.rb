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
end
b = [1,2,3,3,7].my_each_with_index do |value, index|
 p value => index
end

arr = [1,2,3,4]
a = arr.my_each 
p a