class RedemptionCalculator
  REEDEMABLE_MAP = {
      "milk" => "sugar free",
      "sugar free" => "dark",
      "dark" => "dark",
      "white" => "sugar free"
    }

  def self.calculate(order)
    new(order).build_totals
  end

  attr_reader :original_result, :order

  def initialize(order)
    @order = order
    @original_result = {"milk" => 0, "dark" => 0, "white" => 0, "sugar free" => 0}
  end


  def build_totals
    original_result.merge(calculate_all_totals)
  end

  def calculate_all_totals(result=nil)
    result = calculate_total unless result
    return result if result.values.last < order.wrappers_needed

    current_type       = result.keys.last
    current_type_total = result[current_type]
    new_result         = result.merge(calculate_total(current_type, current_type_total)) 
    calculate_all_totals(new_result)
  end

  def calculate_total(type=order.type, total=nil, freebies=0, wrappers_left=nil)
    total         = order.cash / order.price if !total
    wrappers_left = total if !wrappers_left
    return construct_result(type, total, freebies) if wrappers_left < order.wrappers_needed
    
    add_to_type   = wrappers_left / order.wrappers_needed
    wrappers_left = (total % order.wrappers_needed) + add_to_type
    total         += add_to_type
    freebies      += add_to_type if type != associated[type]
    calculate_total(type, total, freebies, wrappers_left)
  end

  def construct_result(type, total, freebies)
    if type == associated[type]
      {"#{type}" => total}
    else
      {"#{type}" => total, "#{associated[type]}" => freebies}
    end
  end

  def associated
    self.class::REEDEMABLE_MAP
  end
end