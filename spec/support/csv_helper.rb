module CSVHelper
  def read_csv_to_hash(file)
    CSV.read(OUTPUT_DIR + output_file, headers: true).map {|r| r.to_h}
  end
end