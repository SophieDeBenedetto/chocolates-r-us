class OutputGenerator
  def self.generate(result, line, output_file)
    filename = format_output_filename(output_file)
    puts "writing output to file #{filename}...".green
    line == 0 ? write_row_with_headers(filename, result) : write_row(filename, result)

  end

  def self.write_row_with_headers(output_file, result)
    clear_file(output_file)
    headers = result.keys.map {|header| "#{header} N"}
    CSV.open(output_file, 'a+', headers: headers) do |csv|
      csv << headers
      csv << result.values
    end
  end

  def self.format_output_filename(output_file)
    OUTPUT_DIR + output_file
  end

  def self.write_row(output_file, result)
    CSV.open(output_file, 'a+') do |csv|
      csv << result.values
    end
  end

  def self.clear_file(output_file)
    File.open(output_file, 'w+') {|f| f.write ''}
  end
end
