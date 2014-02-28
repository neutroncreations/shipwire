require 'httparty'
require 'builder'

require 'shipwire/errors'

require 'shipwire/api'
require 'shipwire/config'
require 'shipwire/address'
require 'shipwire/order'
require 'shipwire/order_item'
require 'shipwire/version'

module Shipwire

  def self.config
    yield Shipwire::Config.instance
  end

end
