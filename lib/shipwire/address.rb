module Shipwire
  class Address

    ADDRESS_FIELDS = {
      name: :Name,
      company: :Company,
      address1: :Address1,
      address2: :Address2,
      address3: :Address3,
      city: :City,
      state: :State,
      country: :Country,
      zip: :Zip,
      commercial: :Commercial,
      pobox: :PoBox
    }

    def initialize fields={}
      @fields = {}

      ADDRESS_FIELDS.keys.each do |field|
        @fields[field] = fields[field] unless fields[field].nil?
      end
    end

    def to_xml
      raise InvalidAddressError.new('Address line 1 is required') if @fields[:address1].nil?
      raise InvalidAddressError.new('City is required') if @fields[:city].nil?
      raise InvalidAddressError.new('Country is required') if @fields[:country].nil?

      xml = Builder::XmlMarkup.new indent: 2, initial: 2
      xml.AddressInfo(type: :ship) do |address|
        @fields.each do |field, value|
          address.tag!(ADDRESS_FIELDS[field], value) unless @fields[field].nil?
        end
      end
      xml.target!
    end

    def method_missing method, *args, &block
      if method.to_s[-1] == '='
        method = method.to_s[0..-2].to_sym
        set = true
      else
        set = false
      end

      if ADDRESS_FIELDS.keys.include?(method)
        if set
          @fields[method] = args[0]
        else
          @fields[method]
        end
      else
        super
      end
    end
  end
end
