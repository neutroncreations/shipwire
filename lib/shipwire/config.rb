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
