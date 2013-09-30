# DurableDecoratorRails

This integrates [durable_decorator](https://github.com/jumph4x/durable_decorator) with Rails.

## Installation

Add this line to your application's Gemfile:

    gem 'durable_decorator_rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install durable_decorator_rails

## Usage
This gem will generate the correct file structure, place (or append to) the correct decorator and even insert the correct seal for you. Use:
```shell
rails g decorator [FULL_METHOD_NAME]
```

For example, let us decorate the existing ```#deleted?``` instance method from the gem that is namespaced under ```Spree``` in a file that is a *model* called ```Product```. Just run:
```shell
rails g decorator Spree::Product#deleted?
```

The gem will create the ```app/models/spree/product_decorator.rb``` file for you to start with, and it will have the following contents:
```ruby
Spree::Product.class_eval do  

  durably_decorate :deleted?, mode: 'strict', sha: '9dc99742ed3ebbdd5b2cbd7c3c93d730e5244e72' do 
  end  

end

```

Otherwise, you may access the SHA of any method in memory with:
```shell
rake durable_decorator:determine_sha[Spree::Product#deleted?]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
