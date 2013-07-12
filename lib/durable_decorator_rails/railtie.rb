require 'durable_decorator_rails'
require 'rails'

module DurableDecoratorRails
 class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/durable_decorator_rails.tasks'
    end
  end 
end
