class OrderProcessor
  def self.process(csv_file)
    CSV.foreach(csv_file, headers: true).with_index do |row, i|
      next if row.empty?
      order = Order.new(row)
      result = RedemptionCalculator.calculate(order)
      OutputGenerator.generate(result, i)
    end
  end
end