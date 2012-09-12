class Demo
end

puts "Enter method name"
m_name = gets.chomp
puts "Enter its content"
m_body = gets.chomp

Demo.instance_eval do 
	def cre_m(name, body)
		define_method(name) do 
			eval (body)
		end
	end
end

Demo.cre_m(m_name, m_body)
puts Demo.new.send(m_name)
