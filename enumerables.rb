module Enumerable
  def my_each
    array = self if self.class == Array
    array = self.to_a if self.class == Range
    i = 0
    while i < array.length 
      if block_given?
        yield array[i]
      else
        return "\#<Enumerator: #{self}:each>"
      end
      i += 1
    end
    self
  end
end

arr = [1,2,3,4]
a = arr.my_each 
p a