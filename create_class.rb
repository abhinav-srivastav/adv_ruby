require 'csv'

puts "Enter the csv file name "
file_name = gets.chomp

emp = CSV.read(file_name) 
q = file_name.gsub(".csv","").capitalize
s = "class #{q}\nend"
eval(s)
cls = eval(q)
func_list = emp[0]


cls.instance_eval do 
  func_list.each do |func|
    var = "@#{func}"
    define_method(func) do 
      instance_variable_get(var)
    end
	  define_method("#{func}=") do |val|
      instance_variable_set(var, val)
    end
  end
  define_method('print_row') do
    func_list.each do |atr|
      value = eval("#{atr}")
      puts "#{atr} : #{value}"
    end
  end
end

obj = []
1.upto(emp.length - 1) do |i|
  obj[i -1] = cls.new
  x = 0
  emp[i].each do |var|
    eval("obj[i - 1].#{func_list[x]} = var")
    x += 1
  end 
end

obj.each_index do |i|
  puts "Record no:#{i+1}"
  obj[i].print_row  
end