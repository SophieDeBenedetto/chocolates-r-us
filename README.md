# Chocolates R' Us!

## Usage

*Remember to `bundle install` before you get started!*

Run the program by executing the exutable file:

```
$ ruby bin/process_orders
```

This will start up the command line interface which will prompt you to enter the path of a file to process, or to enter the default command to process the default file, `input/orders.csv`. 

To skip the (super fun) bells and whisltes of the CLI, you can comment out line 7 of the executable file and comment line 11. Then, execute the file again, with and argument to specify a particular file of orders to process, or without an argument to process the default file, `input/orders.csv`

```
$ ruby bin/process_orders /path/to/file
```

or

```
$ ruby bin/process_orders 
```

Your processed orders will be written to the `output/` directory. 

## Testing

Tests are written with RSpec. To run the test suite, run `rspec` from the command line. 

## Overview

The `OrderProcessor` class is designed as the public-facing API of this program.

```ruby
OrderProcessor.process
```

The call to `.process` is wrapped up in a nifty CLI, but the `OrderProcessor` class stands on its own and does the heavy lifting of this application. 

The driving force behind `OrderProcessor` is the `RedemptionCalculator` class. This is a service class whose responsibility it is to apply super sweet (pun intended) deals to a customers orders and calculate their final chocolate order. 

`OrderProcessor` also relies on the `OutputGenerator` class, which writes successive lines to the resulting CSV file. 

The `Order` class produces objects describing an initial order, before processing. 

The list of available chocolates and the rules describing free chocolates per order are stored in, and read from, YAML files. This ensures that we are keeping this data in one central location, so it will be easy to update in the future. It also keeps the applicatio in line with the Single Responsibility Principle––it is not the job of the `Order` class to know what chocolates are on offer, or what redemption rules to apply to a given order, nor is it the job of the `RedemptionCalculator` whose sole responsibility it is to _calculate_ final orders. 

The test suite focuses the public-facing `OrderProcessor.process` method, and thouroughly tests the `RedemptionCalculator`, since that is the class the does most of the heavy lifting. The test suite aims to focus on testing desired behavior, not implementation. Consequently, the `OutputGenerator` class is _not_ tested since it is not a stand-alone class. It functions only within the context of the `OrderProcessor` class. Successfull `OrderProcessor` tests ensure that the `OutputGenerator` is behaving as expected. 







