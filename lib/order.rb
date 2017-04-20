class Order
  INTEGER_ATTRIBUTES = ["cash", "price", "wrappers_needed"]
  attr_accessor :cash, :price, :wrappers_needed, :type

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
  end
end