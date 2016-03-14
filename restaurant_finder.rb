require 'csv'
require './restaurant.rb'

class ResturantFinder

  CSV_FILE_NAME = "process.csv"

  attr_accessor :input_file_name, :food_items, :food_item_data, :restaurants_list

  def initialize data
    @input_file_name = data.shift
    # @quantity is the quantity of each food item
    @quantity = data.each_with_object(Hash.new(0)) { |item,counts| counts[item] += 1 }
    @food_items = data.uniq
    @food_item_data = {}
  end

  def minimum_price_restaurant
    begin
      if valid_csv?
        collect_matching_data
        return display "nil" if available_restaurants.empty?
        find_restaurant
      else
        display "Unformatted CSV"
      end
    ensure
      File.truncate(CSV_FILE_NAME, 0)
    end
  end

  def valid_csv?
    valid = true
    CSV.open(CSV_FILE_NAME, "wb") do |csv|
      csv << [ 'id', 'price', 'item' ]
      CSV.foreach(input_file_name, converters: [:integer,:float]) do |row|
        if valid_row row
          csv << [ row[0], row[1], row[2..-1] ]
        else
          valid = false
          break
        end
      end
    end
    valid
  end

  def valid_row row
    !row.empty? and row[0].is_a?(Integer) and (row[1].is_a?(Float) || row[1].is_a?(Integer))
  end

  def collect_matching_data
    csv = CSV.read(CSV_FILE_NAME, { headers: true, converters: [:integer, :float] })
    # food_items is list of ordered food from command line
    # food_item_data is a Hash containg the data(restaurant_id,price,food_name) of each food_items
    food_items.each do |food_item|
      food_item_data[food_item] = csv.select { |row| row['item'].include? food_item } 
    end
  end

  def available_restaurants
    restaurants_for = {}
    # Logic to sort out restaurants which have all the ordered food_items
    food_item_data.each { |item,value| restaurants_for[item] = value.map{ |i| i['id'] } } 
    @restaurants_list = restaurants_for.values.inject { |a,b| a & b }
  end

  def find_restaurant
    set_restaurants_data
    print_restaurant cheap_restaurant
  end

  def set_restaurants_data
    restaurants_list.collect! { |id| Restaurant.new id }
    add_dishes_to_restaurant
    checkout_sum
  end

  def add_dishes_to_restaurant
    restaurants_data = food_item_data.values.flatten
    restaurants_list.each do |restaurant|
      dishes = restaurants_data.select { |data| data['id'] == restaurant.id }
      restaurant.add_dish dishes
    end
  end

  def checkout_sum
    restaurants_list.each { |restaurant| restaurant.checkout_sum @quantity }
  end

  def cheap_restaurant
    restaurants_list.min { |i,j| i.dishes_cost <=> j.dishes_cost} 
  end

  def print_restaurant restaurant
    display "#{restaurant.id}, #{restaurant.dishes_cost}"
  end

  def display result
    puts result
  end

end
