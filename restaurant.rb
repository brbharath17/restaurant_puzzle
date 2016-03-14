require './dish.rb'

class Restaurant

  attr_accessor :id, :dishes, :dishes_cost

  def initialize id
    @id = id
    @dishes = []
    @dishes_cost = 0
  end

  def add_dish dishes
    @dishes << dishes.collect! { |dish| Dish.new(dish['item'], dish['price'].to_f) }
    @dishes.flatten!
  end

  def checkout_sum dish_quantity
    dish_quantity.each do |item,count|
      unit_cost = @dishes.select { |dish| dish.name.include? item }.map(&:price).min
      @dishes_cost += unit_cost * count
    end
  end

end