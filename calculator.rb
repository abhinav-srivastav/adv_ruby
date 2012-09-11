def calculate(num1, oper, num2)
	num1.to_f.send oper, num2.to_f
end

puts "Enter fist operand"
num1 = gets.chomp
puts "Enter second operand"
num2 = gets.chomp
puts "Enter operator"
oper = gets.chomp.to_sym

puts calculate(num1,oper,num2)