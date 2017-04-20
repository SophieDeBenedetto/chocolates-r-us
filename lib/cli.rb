class Cli 
  DEFAULT_INPUT = File.join("/Users/SophieDeBenedetto/Desktop/chocolates-r-us", "orders/input.csv")
  
  def self.run
    welcome
    interact
  end

  def self.interact
    help
    input  = gets.chomp
    result = process_input(input)
    return result if result == "exit"
    interact
  end

  def self.welcome
    puts "Welcome to Chocolates 'R Us!\n"
    puts "a great and totally real chocolate emporium.\n"
    puts "just like Willy Wonka's place except for all of the terrifying near-death experiences!\n"
  end

  def self.help
    puts "You can:\n"
    puts "1. Enter the path to the file of orders you want to process\n"
    puts "2. Enter 'default' to process the default file, `inputs.csv`\n"
    puts "3. Enter 'exit' to leave the chocolate store\n"
    puts "4. Enter 'help' to see this menu again\n"
  end

  def self.process_input(input)
    case input
    when "default"
      process_orders
    when "help"
      help
    when "exit"
      exit
    else
      process_orders
    end
  end

  def self.exit
    puts "Goodbye!"
    "exit"
  end

  def self.process_orders(orders_csv=DEFAULT_INPUT)
    puts "processing orders..."
    OrderProcessor.process(orders_csv)
  end
end