# Shipwire Gem

A Ruby interface to the Shipwire API.

## Installation

    gem install shipwire

## Documentation
View detailed documentation on [rdoc.info][documentation]

[documentation]: http://rdoc.info/gems/shipwire


### Configuration

Setup your username and password before use


```ruby
Shipwire.config do |config|
  config.username    = "email@example.com"
  config.password    = "000000000"
end
```

### Rate Request

```ruby
# create an order
order = Shipwire::Order.new
# add an address
order.address = {address1: '', city: '', country: 'GB'}
# add an item
o.add_item Shipwire::OrderItem.new('SKU0001', 1)
```
