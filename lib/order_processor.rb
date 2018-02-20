class OrderProcessor
  DEFAULT_INPUT = "orders.csv"

  def self.process(input=INPUT_DIR + DEFAULT_INPUT)
    self.new(input).tap {|processor| processor.process}
  end

  attr_reader :errors, :success

  def initialize(input)
    @csv_file = input
    @errors   = {}
  end

  def process
    CSV.foreach(@csv_file, headers: true).with_index do |row, i|
      next if row.empty?
      order  = Order.new(row)
      result = RedemptionCalculator.calculate(order)
      OutputGenerator.generate(result, i, @csv_file)
    end
    @success = true
  rescue Errno::ENOENT
    errors[:file_not_found] = "File #{@csv_file} not found"
  end
end
