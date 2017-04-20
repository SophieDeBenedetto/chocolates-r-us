class OutputGenerator
  OUTPUT_FILE = File.join("/Users/SophieDeBenedetto/Desktop/chocolates-r-us", "output/output.csv")
  
  def self.generate(result, line, output_file=OUTPUT_FILE)
    line == 1 ? write_row_with_headers(output_file, result) : write_row(output_file, result)
  end

  def self.write_row_with_headers(output_file, result)
    headers = result.keys.map {|header| "#{header} N"}
    CSV.open(output_file, 'a+', headers: headers) do |csv|
      csv << headers
      csv << result.values
    end
  end

  def self.write_row(output_file, result)
    CSV.open(output_file, 'a+') do |csv|
      csv << result.values
    end
  end
end