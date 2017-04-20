class OrderProcessor
  DEFAULT_INPUT = File.join("/Users/SophieDeBenedetto/Desktop/chocolates-r-us", "orders/input.csv")

  def self.process(input)
    csv_file = input || DEFAULT_INPUT
    CSV.foreach(csv_file, headers: true).with_index do |row, i|
      next if row.empty?
      order = Order.new(row)
      result = RedemptionCalculator.calculate(order)
      OutputGenerator.generate(result, i, input)
    end
  end
end