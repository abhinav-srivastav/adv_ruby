def calculate(num1, oper, num2)
	num1.to_i.send oper, num2.to_i
end

puts "Enter the Expression"
exp = gets.chomp
oper = exp.gsub(/[\d]*/,"")
num1 = exp[0..exp.index(oper)-1]
num2 = exp[exp.index(oper)+1..exp.length-1]
oper = oper.to_sym
puts calculate(num1,oper,num2)