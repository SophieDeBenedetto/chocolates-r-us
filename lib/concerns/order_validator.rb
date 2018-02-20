module OrderValidator

  def validate
    order_has_enough_money && valid_chocolate_type && has_required_fields && has_required_fields
  end

  def valid?
    errors.values.flatten.length == 0
  end

  private

  def set_initial_errors
    @errors = {
      cash: [],
      type: [],
      wrappers_needed: [],
      price: []
    }
  end

  def order_has_enough_money
    errors[:cash] << "you do not have enough money" unless cash > price
  end

  def valid_chocolate_type
    errors[:type] << "invalid chocolate type" unless CHOCOLATES.include?(type)
  end

  def has_required_fields
    validates_prescence_of_type && validates_prescence_of_cash && validates_prescence_of_price && validates_prescence_of_wrappers_needed
  end

  def validates_prescence_of_type
    errors[:type] << "type is required" unless type
  end

  def validates_prescence_of_cash
    errors[:cash] << "cash is required" unless cash
  end

  def validates_prescence_of_price
    errors[:price] << "price is required" unless price
  end

  def validates_prescence_of_wrappers_needed
    errors[:wrappers_needed] << "wrappers_needed is required" unless wrappers_needed
  end
end
