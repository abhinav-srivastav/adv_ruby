module Filters
	@@before = []
  @@except = [[],[]]
  @@b_only = []
  @@a_only = []
  @@after =[]
  def self.included(cls)
    def cls.method_added(name)
      return if @_method_added
      @_method_added = true
      alias_method "original_#{name}", name
      before_n_after(name) 
      @_method_added = false
    end
    def cls.to_array(from_a, to)
      from_a.each do |var|
        to << var
      end
    end
    def cls.before_filter(*args)
      args.each do |name|
        if name.class == Hash
          to_array(name[:except], @@except[0])unless name[:except].nil?        
          to_array(name[:only],@@b_only) unless name[:only].nil?           
        else 
          @@before << name
        end
      end
    end
    def cls.after_filter(*args)
      args.each do |name|
        if name.class == Hash
          to_array(name[:except], @@except[1]) unless name[:except].nil?
          to_array(name[:only], @@a_only) unless name[:only].nil?    
        else 
          @@after << name
        end
      end
    end
    def test(a, name, para = 0)
      if a.empty?
        return true 
      else
        if a.include?(name.to_sym)
          return nil if para == 1
          return true if para == 0
        end
      end
      return true if para == 1
      return nil if para == 0
    end
    def cls.before_n_after(name)
      self.class_eval %{ 
        def #{name}
          puts "Before Filter functions---"
          if test(@@except[0],"#{name}", 1) && test(@@b_only, "#{name}")
            @@before.each do |met|
              eval("original_"+met.to_s) unless "#{name}".eql?met.to_s              
            end
          end
          exec = 0
          pass = 0
          puts "Called function---"
          original_#{name}
          puts "After Filter functions---"
          if test(@@a_only, "#{name}") && test(@@except[1],"#{name}", 1)
            @@after.each do |met|
              eval("original_"+met.to_s) unless "#{name}".eql?met.to_s           
            end
          end
        end
      }
    end
  end
end
class Any    
  include Filters
  before_filter :foo, :bar, :only => [:all,:test_method,:last_method]
  after_filter :foo,:except =>[:all]
  def all
    puts "this is all"
  end
	def foo
		puts "This is Foo"
	end
  def bar
    puts "This is Bar"
  end
  def test_method
    puts "This is Test method"
  end
  def last_method
    puts "This is last_method"
  end   
end
obj = Any.new
obj.last_method