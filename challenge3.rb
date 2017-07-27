require 'terminal-table'

class MenuItem
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
  
end

class Entree < MenuItem
end

class Main < MenuItem
end

class Dessert < MenuItem
end

class Drink < MenuItem
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
  Entree.new('Skewers', 8),
  Entree.new('Eggplant stew', 9), 
  Main.new('Steak', 30),
  Main.new('Burger', 20),
  Dessert.new('Gelato', 8),
  Dessert.new('Waffle', 9),
]


def menu_choice
  menu_choice = gets.chomp
  system 'clear'
  case menu_choice
    when "1"
      puts "1. #{MENU_ITEMS[0].name}: #{MENU_ITEMS[0].price}"
      puts "2. #{MENU_ITEMS[1].name}: #{MENU_ITEMS[1].price}"
    when "2"
      puts "1. #{MENU_ITEMS[2].name}: #{MENU_ITEMS[2].price}"
      puts "2. #{MENU_ITEMS[3].name}: #{MENU_ITEMS[3].price}"
    when "3"
      puts "1. #{MENU_ITEMS[4].name}: #{MENU_ITEMS[4].price}"
      puts "2. #{MENU_ITEMS[5].name}: #{MENU_ITEMS[5].price}"
    when "x"
      main_menu([])
  end
end

def sub_menu
  system 'clear'
  puts "Please choose from a sub menu"
  puts "1. Entree"
  puts "2. Mains"
  puts "3. Desserts"
  puts "x. Back to main menu"

  menu_choice

  puts "press any key to go back to previous menu"
  choice = gets
  return display_menu if choice
end

# Show menu
def display_menu
  sub_menu

  puts "press any key to go back to main menu"
  choice = gets
  return main_menu([]) if choice

end

# Add menu items
def order_items

  MENU_ITEMS.each_with_index do |menu_item, index|
    user_index = index + 1
    # Display item with index first, then name and price
    puts "#{user_index}. #{menu_item.class} #{menu_item.name}: #{menu_item.price}"
  end

  order = Order.new

  loop do
    puts 'What would you like?'
    choice = gets.chomp
    puts "You ordered #{MENU_ITEMS[choice.to_i - 1].name}"
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