module Shipwire
  class Order

    attr_accessor :shipping
    attr_accessor :warehouse
    attr_reader   :id
    attr_reader   :address
    attr_reader   :items

    # Creates a new Shipwire::Order
    #
    # @param [String] id the order id to be passed to the Shipwire API
    def initialize id=nil
      @config = Shipwire::Config.instance

      @warehouse = @config.default_warehouse
      @shipping = @config.default_shipping

      @id = id
      @items = []
    end

    # set the address for the order
    #
    # The shipwire API
    #
    # @param [Shipwire::Address] adddress the address to set for this order
    # @return [Shipwire::Order] this Shipwire::Order object
    def address= address

      raise InvalidAddressError.new unless address.is_a? Shipwire::Address

      @address = address

      self
    end

    # add an item to the order
    #
    # @param [Shipwire::OrderItem] item the item to be added to the order
    def add_item item
      raise new InvalidItemError unless item.is_a? Shipwire::OrderItem

      @items << item
    end
  end
end
