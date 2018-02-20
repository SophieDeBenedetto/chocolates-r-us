class RedemptionCalculator
  REDEEMABLE_MAP = {
    "milk" => ["milk", "sugar free"],
    "white" => ["white", "sugar free"],
    "sugar free" => ["sugar free", "dark"],
    "dark" => ["dark"]
  }

  CHOCOLATES = ["milk", "dark", "white", "sugar free"]

  def self.calculate(order)
    new(order).calculate_redemption
  end

  attr_reader :chocolates, :order

  def initialize(order)
    @order      = order
    @chocolates = CHOCOLATES.each_with_object({}) do |chocolate, map|
      map[chocolate] = 0
    end
  end

  def calculate_redemption(num_pieces_purchased=(order.cash / order.price), type=order.type)
    @chocolates[type] += num_pieces_purchased
    if num_pieces_purchased > order.wrappers_needed
      num_redeemed = num_pieces_purchased / order.wrappers_needed
      apply_redemption(type, num_redeemed)
      num_pieces_purchased = @chocolates[order.type] - order.wrappers_needed
      if (num_pieces_purchased / order.wrappers_needed) > 0
        apply_redemption(type, num_pieces_purchased / order.wrappers_needed)
      end
        REDEEMABLE_MAP[type].each do |related_type|
        if related_type != order.type && @chocolates[related_type] >= order.wrappers_needed
          apply_redemption(related_type, @chocolates[related_type] / order.wrappers_needed)
        end
      end
    end
    @chocolates
  end

  def apply_redemption(type, num_redeemed)
    num_redeemed.times do
      REDEEMABLE_MAP[type].each do |related_type|
        @chocolates[related_type] += 1
      end
    end
  end
end
