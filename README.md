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

See [DurableDecorator#Usage](https://github.com/jumph4x/durable_decorator#usage)

This gem is useful for determining SHAs of existing method definitions, for the express purpose of sealing your decorators. For that, simply run this in console:

```shell
rake durable_decorator:determine_sha[SomeClazz#some_method]
7c62cf476a2458d5eb401588d6f10db8bbecc8a6
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
