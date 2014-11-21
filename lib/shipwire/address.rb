module Shipwire
  class Address

    ADDRESS_FIELDS = {
      name: :Name,
      email: :Email,
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

    # @param [Boolean] validate perform validation of the address
    def initialize fields={}, validate = true
      @validate = validate

      @fields = {}

      ADDRESS_FIELDS.keys.each do |field|
        @fields[field] = fields[field] unless fields[field].nil?
      end
    end

    def to_api_hash
      raise InvalidAddressError.new('Address line 1 is required') if @validate && @fields[:address1].nil?
      raise InvalidAddressError.new('City is required') if @validate && @fields[:city].nil?
      raise InvalidAddressError.new('Country is required') if @validate && @fields[:country].nil?

      {
        name: @fields[:name],
        email: @fields[:email],
        address1: @fields[:address1],
        address2: @fields[:address2] || "",
        address3: @fields[:address3] || "",
        city: @fields[:city] || "",
        region: @fields[:state] || "",
        postalCode: @fields[:zip] || "",
        country: @fields[:country]
        # isCommercial: @fields[:commercial] ? 1 : 0,
        # isPoBox: @fields[:pobox] ? 1 : 0
      }
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
