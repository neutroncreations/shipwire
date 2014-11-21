module Shipwire
  class Api
    include HTTParty
    format :json


    URL_BASE = {
      sandbox: 'https://api.beta.shipwire.com',
      production: 'https://api.shipwire.com'
    }

    def initialize
      @config = Shipwire::Config.instance
    end

    def rate order

      json = {
        order: {
          shipTo: order.address.to_api_hash,
          items: []
        }
      }

      order.items.each do |item|
        json[:order][:items].push({
          sku: item.sku,
          quantity: item.qty
        })
      end

      perform :post, '/api/v3/rate', {body: json.to_json}

    end

    def order! order

      json = {
        orderNo: order.id,
        shipTo: order.address.to_api_hash,
        items: []
      }

      order.items.each do |item|
        json[:items].push({
          sku: item.sku,
          quantity: item.qty
        })
      end

      perform :post, '/api/v3/orders', {body: json.to_json}

    end

    private

      def perform method, path, options

        options[:timeout] = @config.timeout

        begin
          response = self.class.send method, "#{base_url}#{path}", options.merge(headers)

          if response['status'] == 200
            return response.parsed_response
          else
            raise ApiError.new(response.parsed_response)
          end
        rescue HTTParty::Error => e
          raise ApiError.new(e.message)
        rescue Net::OpenTimeout => e
          raise ApiTimeout.new(e.message)
        end
      end

      def base_url
        URL_BASE[@config.environment]
      end

      def headers
        {
          headers: {
            'Content-Type' => 'application/json'
          },
          basic_auth: {
            username: @config.username,
            password: @config.password
          }
        }
      end

  end
end
