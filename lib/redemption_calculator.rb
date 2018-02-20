class RedemptionCalculator
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

  def calculate_redemption
    total = order.cash / order.price
    @chocolates[order.type] += total
    calculate(order.type)
    calculate_redemption_for_related_type
    @chocolates
  end

  def apply_redemption(type, num_redeemed)
    REDEEMABLE_MAP[type].each do |related_type|
      @chocolates[related_type] += num_redeemed
    end
  end

  def calculate_redemption_for_related_type(type=order.type)
    REDEEMABLE_MAP[type].each do |related_type|
      if (related_type != type) && @chocolates[related_type] >= order.wrappers_needed
        calculate(related_type)
        calculate_redemption_for_related_type(related_type)
      end
    end
  end

  def calculate(type)
    free     = @chocolates[type] / order.wrappers_needed
    leftover = (@chocolates[type] % order.wrappers_needed) + free
    apply_redemption(type, free)
    while leftover >= order.wrappers_needed
      free     = leftover / order.wrappers_needed
      leftover = (@chocolates[type] % order.wrappers_needed) + free
      apply_redemption(type, free)
    end
  end
end
