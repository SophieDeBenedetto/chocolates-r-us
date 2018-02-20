require_relative "./concerns/order_validator"

class Order
  include OrderValidator
  INTEGER_ATTRIBUTES = ["cash", "price", "wrappers_needed"]
  attr_accessor :cash, :price, :wrappers_needed, :type, :errors

  def self.create(attributes)
    new(attributes).tap(&:validate)
  end

  def initialize(attributes)
    attributes.each do |attr, value|
      attribute = attr.strip.gsub(' ', '_')
      if self.class::INTEGER_ATTRIBUTES.include?(attribute)
        value = value.to_i
      else
        value = value.strip.gsub("'", "")
      end
      send("#{attribute}=", value)
    end
    set_initial_errors
  end

  class OrderValidationError < StandardError;end
end
