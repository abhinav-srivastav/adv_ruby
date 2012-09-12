class ShoppingList 
  def initialize
    @shop = Hash.new(0)
  end
  def to_s
    @shop.each do |k, v|
     puts "#{k.ljust(15,'-')}#{v}"
    end
    ""
  end
  def add(item, quan)
    @shop[item] += quan
  end
  def items(&block)
    instance_eval &block
  end
end

sl = ShoppingList.new

sl.items do
 add("Toothpaste",2)
 add("Computer",1)
end
puts sl
