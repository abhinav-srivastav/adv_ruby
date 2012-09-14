module MyObjectStore
@@arr = []
  module InnerObject
    @@arr = []
    def validate_presence_of(fname, email)
      return nil if fname.nil? || email.nil?
      return true
    end
    def attr_accesor(*args)
      attr_accessor(*args)
      args.each do |arg|
        class_eval %{
          def self.find_by_#{arg}(val)
            match = []
            @@arr.each do |obj|
              match << obj if obj.#{arg}.eql?(val)
            end
            match         
          end 
        }  
      end
      class_eval %{
        def self.count
          puts @@arr.length
        end 
        def self.collect
          @@arr.each do |record|
            print record
            puts
          end
        end
      }
    end
  end
  def self.included(cls)
    cls.extend InnerObject
  end
  def save
   @@arr << self if self.validate
	end
end

class Play
	include MyObjectStore
  attr_accesor :age, :fname, :email
  validate_presence_of :fname, :mail 

  def validate
    if self.class.validate_presence_of self.fname, self.email
      return true
    else
      puts "Variable is null" 
    end
  end 
end
 
a = Play.new
b = Play.new
a.fname = "zoe"
a.email = "abc@zxy.com"
a.age = 24
a.save
b.fname = "moe"
b.email = "abc@zxy.com"
b.age = 32
b.save
Play.collect
Play.count
puts Play.find_by_age(24)