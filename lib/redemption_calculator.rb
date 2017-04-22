class RedemptionCalculator
  def self.calculate(order)
    new(order).build_totals
  end

  attr_reader :starting_chocolates, :order

  def initialize(order)
    @order = order
    @starting_chocolates = CHOCOLATES.each_with_object({}) do |chocolate, map| 
      map[chocolate] = 0
    end
  end


  def build_totals
    starting_chocolates.merge(calculate_totals)
  end

  def calculate_totals(type=order.type, total=nil, related_total=0, wrappers=nil)
    related_type      = REDEEMABLE_MAP[type]
    total             = calculate_total unless total
    wrappers          = total unless wrappers
    
    free              = wrappers / order.wrappers_needed
    leftover_wrappers = wrappers % order.wrappers_needed
    wrappers          = free + leftover_wrappers
    
    total         += free
    related_total += free if related_type
    
    result = construct_result(type, total, related_type, related_total)

    if redeemable?(wrappers)
      result.merge(calculate_totals(type, total, related_total, wrappers))
    elsif related_redeemable?(wrappers, related_type)
      result.merge(calculate_totals(related_type, related_total))
    else
      result
    end
  end

  def redeemable?(wrappers)
    wrappers >= order.wrappers_needed
  end

  def related_redeemable?(wrappers, related_type)
    wrappers < order.wrappers_needed && related_type
  end

  def calculate_total
    order.cash / order.price
  end

  def construct_result(type, total, related_type, related_total)
    if related_type
      {type => total, related_type => related_total}
    else
      {type => total}
    end
  end
end