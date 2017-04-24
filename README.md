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

Tests are written in RSpec. To run the test suite, run `rspec` from the command line. 