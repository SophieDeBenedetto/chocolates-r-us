class Order
  attr_accessor :cash, :price, :wrappers_needed, :type

  def initialize(attributes)
    attributes.each do |attr, value|
      send("#{attr.strip.gsub(' ', '_')}=", value)
    end
  end
end