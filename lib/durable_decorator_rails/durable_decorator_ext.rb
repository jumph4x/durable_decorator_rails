module DurableDecorator
  Util.class_eval do
    def logger
      Rails.logger
    end
  end 
end
