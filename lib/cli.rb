class Cli 
  
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
    puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    puts "Welcome to Chocolates 'R Us!                                                            ".white.on_blue
    puts "A great and totally real chocolate emporium.                                            ".white.on_blue
    puts "Just like Willy Wonka's place except for all of the terrifying near-death experiences!  ".white.on_blue
    puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

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
    when "default"
      process_orders
    else
      process_orders(input)
    end
  end

  def self.exit
    puts "Goodbye!".red
    "exit"
  end

  def self.process_orders(orders_csv=nil)
    processor = orders_csv ? OrderProcessor.process(orders_csv) : OrderProcessor.process
    if processor.success
      puts "Done!".green
    else
      processor.errors.each do |type, message| 
        puts "#{type}: #{message}".red
      end
    end
  end

  def file_not_found
    puts "File #{orders_csv} not found"
  end
end