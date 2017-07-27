require 'terminal-table'

class MenuItem
  attr_accessor :name, :price, :description

  def initialize(name, price, description)
    @name = name
    @price = price
    @description = description
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
    total
  end



  def total_with_surcharge
    total + (total * 0.015)
  end

  def bill
    loop do
      puts "Will you be paying by cash or card?"
      choice = gets.chomp
      if choice == 'cash'
        table = Terminal::Table.new headings: ['Name', 'Price'] do |t|
          @items.each do |item|
            t << [item.name, "$#{item.price}"]
          end
          t.add_separator
          t << ['TOTAL', "$#{total}"]
        end
        return table
      elsif choice == 'card'
        table = Terminal::Table.new headings: ['Name', 'Price'] do |t|
          @items.each do |item|
            t << [item.name, "$#{item.price}"]
          end
          t.add_separator
          t << ['Sub Total', total]
          t.add_separator
          t << ['Surcharge', '1.5%']
          t.add_separator
          t << ['TOTAL', total_with_surcharge]
        end
        return table
      else 
        puts 'invalid entry, please try again'
        next
      end
    end
  end
end


MENU_ITEMS = [
  Entree.new('Skewers', 8, 'Yummy chicken skewers'),
  Entree.new('Eggplant stew', 9, 'Gooey eggplant'), 
  Main.new('Steak', 30, 'T-bone steak cooked to perfection'),
  Main.new('Burger', 20, 'Southern fried chiken burger'),
  Dessert.new('Gelato', 8, 'Delicious home mage gelato'),
  Dessert.new('Waffle', 9, 'Authentic Belgian wallfe'),
  Drink.new('Shandy', 7, 'Locally made beer and lemonade'),
  Drink.new('Sex on the beach', 8, 'Yummy cocktail'),
  Drink.new('Cosmopolitan', 8, 'very trendy'),
  Drink.new('Espresso Martini', 9, 'bit of coffee'),
  Drink.new('Mojito', 10, 'very rummy'),
  Drink.new('Margarita', 10, 'tequilaaaaaaaaaa')
]


def menu_choice
  menu_choice = gets.chomp
  system 'clear'
  case menu_choice
    when "1"
      puts "1. #{MENU_ITEMS[0].name}: #{MENU_ITEMS[0].price}"
      puts "     #{MENU_ITEMS[0].description}"
      puts
      puts "2. #{MENU_ITEMS[1].name}: #{MENU_ITEMS[1].price}"
      puts "     #{MENU_ITEMS[1].description}"
      puts
    when "2"
      puts "1. #{MENU_ITEMS[2].name}: #{MENU_ITEMS[2].price}"
      puts "     #{MENU_ITEMS[2].description}"
      puts
      puts "2. #{MENU_ITEMS[3].name}: #{MENU_ITEMS[3].price}"
      puts "     #{MENU_ITEMS[3].description}"
      puts
    when "3"
      puts "1. #{MENU_ITEMS[4].name}: #{MENU_ITEMS[4].price}"
      puts "     #{MENU_ITEMS[4].description}"
      puts
      puts "2. #{MENU_ITEMS[5].name}: #{MENU_ITEMS[5].price}"
      puts "     #{MENU_ITEMS[5].description}"
      puts
    when "4"
      puts "1. #{MENU_ITEMS[6].name}: #{MENU_ITEMS[6].price}"
      puts "     #{MENU_ITEMS[6].description}"
      puts
      puts "2. #{MENU_ITEMS[7].name}: #{MENU_ITEMS[7].price}"
      puts "     #{MENU_ITEMS[7].description}"
      puts
      puts "3. #{MENU_ITEMS[8].name}: #{MENU_ITEMS[8].price}"
      puts "     #{MENU_ITEMS[8].description}"
      puts
      puts "3. #{MENU_ITEMS[9].name}: #{MENU_ITEMS[9].price}"
      puts "     #{MENU_ITEMS[9].description}"
      puts
      puts "3. #{MENU_ITEMS[9].name}: #{MENU_ITEMS[9].price}"
      puts "     #{MENU_ITEMS[9].description}"
      puts
      puts "3. #{MENU_ITEMS[10].name}: #{MENU_ITEMS[10].price}"
      puts "     #{MENU_ITEMS[10].description}"
      puts
      puts "3. #{MENU_ITEMS[11].name}: #{MENU_ITEMS[11].price}"
      puts "     #{MENU_ITEMS[11].description}"
      puts
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
  puts "4. Drinks"
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
    puts 'Please tell us how we can customise your meal'
    edit = gets.chomp
    

    # User must choose an index number
    user_index = choice.to_i

    # If the user entered in an invalid choice
    if user_index < 1 || user_index > 11
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