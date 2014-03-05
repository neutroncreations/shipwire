module Shipwire
  class Error < StandardError; end

  class InvalidShippingError < Error; end

  class InvalidAddressError < Error; end

  class ApiError < Error; end

  class ApiTimeout < Error; end
end
