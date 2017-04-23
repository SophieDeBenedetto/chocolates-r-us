require "spec_helper"

describe RedemptionCalculator do 
  describe ".calculate" do 
    context "type milk chocolate" do
      it "calculates the correct order" do 
        order  = Order.new({"cash" => 12, "price" => 2, "wrappers_needed" => 5, "type" => "milk"})
        result = RedemptionCalculator.calculate(order)
        expect(result).to eq({"milk" => 7, "dark" => 0, "white" => 0, "sugar free" => 1})

        order  = Order.new({"cash" => 14, "price" => 2, "wrappers_needed" => 6, "type" => "milk"})
        result = RedemptionCalculator.calculate(order)
        expect(result).to eq({"milk" => 8, "dark" => 0, "white" => 0, "sugar free" => 1})
      end
    end
    context "type dark chocolate" do 
      it "calculates the correct order" do 
        order  = Order.new({"cash" => 12, "price" => 4, "wrappers_needed" => 4, "type" => "dark"})
        result = RedemptionCalculator.calculate(order)
        expect(result).to eq({"milk" => 0, "dark" => 3, "white" => 0, "sugar free" => 0})
      end
    end
    context "type sugar free chocolate" do
      it "calculates the correct order" do 
        order  = Order.new({"cash" => 6, "price" => 2, "wrappers_needed" => 2, "type" => "sugar free"})
        result = RedemptionCalculator.calculate(order)
        expect(result).to eq({"milk" => 0, "dark" => 3, "white" => 0, "sugar free" => 5})
      end 
    end
    context "type white chocolate" do 
      it "calculates the correct order" do 
        order  = Order.new({"cash" => 6, "price" => 2, "wrappers_needed" => 2, "type" => "white"})
        result = RedemptionCalculator.calculate(order)
        expect(result).to eq({"milk" => 0, "dark" => 1, "white" => 5, "sugar free" => 3})
      end
    end
  end
end
