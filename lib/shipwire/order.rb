module Shipwire
  class Order

    ADDRESS_FIELDS = [:name, :company, :address, :ddress, :address, :city, :state, :country, :zip, :commercial, :pobox].freeze

    attr_accessor :shipping
    attr_accessor :warehouse
    attr_reader   :id
    attr_reader   :address
    attr_reader   :items

    def initialize id
      @config = Shipwire::Config.instance

      @warehouse = @config.default_warehouse
      @shipping = @config.default_shipping

      @id = id
      @items = []
    end

    def address= address_data

      raise InvalidAddressError.new unless address_data.is_a? Hash

      raise InvalidAddressError.new('Address line 1 is required') if address_data[:address1].nil?
      raise InvalidAddressError.new('City is required') if address_data[:city].nil?
      raise InvalidAddressError.new('Country is required') if address_data[:country].nil?

      @address = address_data.select
    end

    def add_item item
      raise new InvalidItemError unless item.is_a? Shipwire::OrderItem

      @items << item
    end
  end
end
