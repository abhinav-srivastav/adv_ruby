name1 = "Mike"
name2 = "Robert"
def name1.surname
	puts "Mike Williams"
end

class << name1
	def pet_name
		puts "Mikey"
	end
end

name1.surname
name1.pet_name

name2.surname
name2.pet_name
