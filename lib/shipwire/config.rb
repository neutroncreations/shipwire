require 'singleton'

module Shipwire
  class Config
    include Singleton

    attr_accessor :debug
    @debug = (defined? Rails ? Rails.env.development? : false)

    attr_accessor :username

    attr_accessor :password

    attr_writer :environment

    attr_accessor :default_shipping
    @default_shipping = 'GD'

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
