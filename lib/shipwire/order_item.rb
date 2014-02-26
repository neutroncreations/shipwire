module Shipwire
  class OrderItem
    attr_reader :sku
    attr_reader :qty

    def initialize sku, quantity
      @sku = sku
      @qty = quantity
    end
  end
end
