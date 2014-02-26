module Shipwire
  class Api
    include HTTParty
    format :xml


    URL_BASE = {
      sandbox: 'https://api.beta.shipwire.com',
      production: 'https://api.shipwire.com'
    }

    def initialize
      @config = Shipwire::Config.instance
    end

    def rate orders

      orders = [orders] unless orders.is_a? Array

      xml = build_rate orders

      options = {
        body: xml
      }

      perform '/exec/RateServices.php', 'RateResponse', options

    end

    private

      def perform path, root, options

        begin
          response = self.class.post "#{base_url}#{path}", options

          if response[root]['Status'] == 'OK'
            return response.parsed_response
          else
            raise ApiError.new(response[root])
          end
        rescue HTTParty::Error => e
          raise ApiError.new(e.message)
        end
      end

      def base_url
        URL_BASE[@config.environment]
      end

      def build_rate orders
        xml = Builder::XmlMarkup.new indent: 2
        xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
        xml.declare! :DOCTYPE, :RateRequest, :SYSTEM, "http://www.shipwire.com/exec/download/RateRequest.dtd"

        xml.RateRequest do |xml_rate_request|
          xml_rate_request.Username @config.username
          xml_rate_request.Password @config.password

          orders.each do |order|
            xml_rate_request.Order do |xml_order|
              xml_order.AddressInfo(type: :ship) do |xml_address|

                order.address.each do |k,v|
                  xml_address.tag! k.to_s.capitalize, v
                end
              end

              order.items.each_with_index do |item, index|
                xml_order.Item(num: index) do |xml_item|
                  xml_item.Code item.sku
                  xml_item.Quantity item.qty
                end
              end
            end
          end
        end

        print xml.target! if @config.debug

        return xml.target!
      end
  end
end
