require "spec_helper"
describe OrderProcessor do
  describe ".process" do
    before(:each) do
      allow($stdout).to receive(:puts)
    end
    after(:each) do
      FileUtils.rm_rf Dir.glob("#{OUTPUT_DIR}/*")
    end

    context "success" do
      context "given a file" do
        let(:input_file) { "my_orders.csv" }
        let(:output_file){ "my_orders.csv" }

        it "writes to the correct output file" do
          OrderProcessor.process(INPUT_DIR + input_file)
          expect(read_csv_to_hash(OUTPUT_DIR + output_file)).to eq([{
            "milk N"=>"8",
            "dark N"=>"0",
            "white N"=>"0",
            "sugar free N"=>"1"
          }])
        end
        it "is successfull" do
          processor = OrderProcessor.process(INPUT_DIR + input_file)
          expect(processor.success).to eq(true)
        end
      end

      context "not given a file" do
        let(:output_file) { "orders.csv" }
        it "writes to the correct output file" do
          OrderProcessor.process
          expect(read_csv_to_hash(OUTPUT_DIR + output_file)).to eq([
            {"milk N"=>"7", "dark N"=>"0", "white N"=>"0", "sugar free N"=>"1"},
            {"milk N"=>"0", "dark N"=>"3", "white N"=>"0", "sugar free N"=>"0"},
            {"milk N"=>"0", "dark N"=>"3", "white N"=>"0", "sugar free N"=>"5"},
            {"milk N"=>"0", "dark N"=>"1", "white N"=>"5", "sugar free N"=>"3"}
          ])
        end
        it "is successfull" do
          processor = OrderProcessor.process
          expect(processor.success).to eq(true)
        end
      end
    end
    context "failure" do
      context "given a file that does not exist" do
        let(:processor) { OrderProcessor.process("not_a_real_file.csv") }
        it "sets the correct error" do
          expect(processor.errors).to eq({file_not_found: "File not_a_real_file.csv not found"})
        end
        it "is not successfull" do
          expect(processor.success).to_not eq(true)
        end
      end

      context "order is not valid" do
        let(:processor) { OrderProcessor.process(INPUT_DIR + "errored_input.csv") }
        it "sets the correct error" do
          expect(processor.errors["order_number_1"][:cash]).to eq(["you do not have enough money"])
        end
        it "is not successfull" do
          expect(processor.success).to_not eq(true)
        end
      end
    end
  end
end
