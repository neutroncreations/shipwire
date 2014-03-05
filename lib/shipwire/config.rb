require 'singleton'

module Shipwire

  # Configuration class
  #
  #   Shipwire.config do |config|
  #     config.username    = "email@example.com"
  #     config.password    = "000000000"
  #   end
  class Config
    include Singleton

    # Should debug output be genereated
    #
    # Defaults to false, or true if we're running in a rails development environment
    attr_accessor :debug
    @debug = (defined? Rails ? Rails.env.development? : false)

    attr_accessor :username

    attr_accessor :password

    # What environment should we be working in
    #
    # :production or :sandbox (defualt)
    attr_writer :environment

    # The default shipiping method, GD
    attr_accessor :default_shipping
    @default_shipping = 'GD'

    # The default warehouse to use for orders
    #
    # 00 - Use best available
    attr_accessor :default_warehouse
    @default_warehouse = '00'

    # The timeout for requests to the API, in seconds
    #
    # Any request taking longer that this will raise a Shipwire::Timeout Error
    #
    # Defaults to 10
    attr_accessor :timeout
    @timeout = 10

    attr_accessor :debug
    @debug = (defined? Rails ? Rails.env.development? : false)

    def environment
      case @environment
      when :live, :production
        :production
      else
        :sandbox
      end
    end
  end
end
