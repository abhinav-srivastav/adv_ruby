puts "Enter your statement \nblank to execute \nq to exit"
q = ""
p = ""
l = lambda do |a| 
	if a.eql?("\n") || a.eql?("q\n")
		puts eval(p) 
		p = ""
	else
		p += a
	end 
end
until q.eql?("q\n")
	q = gets
	l.call(q)
end