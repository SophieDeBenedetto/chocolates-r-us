class OrderProcessor
  DEFAULT_INPUT = "orders.csv"

  attr_reader :output_filename

  def self.process(input=INPUT_DIR + DEFAULT_INPUT)
    self.new(input).tap {|processor| processor.process}
  end

  attr_reader :errors, :success

  def initialize(input)
    @input_file      = input
    @output_filename = input.split("/").last
    @errors          = {}
  end

  def process
    CSV.foreach(@input_file, headers: true).with_index do |row, i|
      next if row.empty?
      order  = Order.create(row)
      if order.valid?
        result = RedemptionCalculator.calculate(order)
        OutputGenerator.generate(result, i, @output_filename)
      else
        @errors["order_number_#{i + 1}"] = order.errors
        raise Order::OrderValidationError
      end
    end
  rescue Errno::ENOENT
    @errors[:file_not_found] = "File #{@output_filename} not found"
  rescue Order::OrderValidationError
  end

  def success
    !errors.any?
  end
end
