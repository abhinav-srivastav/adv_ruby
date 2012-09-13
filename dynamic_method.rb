class Dynamic_method < String
  def exclude?(other)
   return nil if self.include? other
   return true
  end
  def reverse_sentence()
   self.split().reverse.join(" ")
  end
  def append_word(other)
    self.gsub(" "," #{other} ")
  end
end

puts "Create an Object as Dynamic_method.new 'string' "
input = gets.chomp
obj = eval(input)
puts "Methods avialable to execute are :"
Dynamic_method.instance_methods(false).each do |func|
  args = Dynamic_method.instance_method(func).arity
  puts "#{func}(##{args} string args)"
end
input = "obj."+gets.chomp
puts eval(input)  
