require 'terminal-table'

class MenuItem
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
  
end


class Order
  def initialize()
    @items = []
  end

  def << (menu_item)
    @items << menu_item
  end

  def total
    total = 0
    @items.each do |item|
      total += item.price
    end
    "$#{total}"
  end

  def bill
    table = Terminal::Table.new headings: ['Name', 'Price'] do |t|
      @items.each do |item|
        t << [item.name, "$#{item.price}"]
      end
      t.add_separator
      t << ['TOTAL', total]
    end
    table
  end
end


MENU_ITEMS = [
  MenuItem.new('Steak', 20),
  MenuItem.new('Parma', 15),
  MenuItem.new('Eggplant Casserole', 15),
  MenuItem.new('Chips', 7),
  MenuItem.new('Beer', 7),
  MenuItem.new('Soft drink', 3.50)
]


# Show menu
def display_menu
  MENU_ITEMS.each_with_index do |menu_item, index|
    user_index = index + 1
    # Display item with index first, then name and price
    puts "#{user_index}. #{menu_item.name}: #{menu_item.price}"
  end
  puts
  puts "press any key to go back to main menu"
  choice = gets
  return main_menu([]) if choice

end

# Add menu items
def order_items
  MENU_ITEMS.each_with_index do |menu_item, index|
    user_index = index + 1
    # Display item with index first, then name and price
    puts "#{user_index}. #{menu_item.name}: #{menu_item.price}"
  end

  order = Order.new

  loop do
    puts 'What would you like?'
    choice = gets.chomp
    # Stop looping if user pressed just enter
    break if choice == ""

    # User must choose an index number
    user_index = choice.to_i

    # If the user entered in an invalid choice
    if user_index < 1 || user_index > 6 
      puts "Invalid choice, please try again"
      next # Loop through and ask again
    end

    index = user_index - 1 # Convert to zero-based index
    menu_item = MENU_ITEMS[index]

    # Add item to order
  order << menu_item
  end
  return main_menu(order)
end


def show_bill(order)
  system 'clear'
  puts order.bill
  sleep 2
end


def main_menu(order)
  system 'clear'
  loop do
    puts 'Please choose an option'
    puts '1. Show menu'
    puts '2. Order items'
    puts '3. Ask for bill'
    puts 'x. Exit'
    choice = gets.chomp
    case choice
        when '1'
          system 'clear'
          display_menu
        when '2'
          system 'clear'
          order_items
        when '3'
          system 'clear'
          show_bill(order)
        when 'x'
          break
        else
          puts "Invalid choice: #{choice}"
      end

      sleep 1
  end
end
order = []
main_menu(order)