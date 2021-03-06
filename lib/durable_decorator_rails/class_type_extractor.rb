module DurableDecoratorRails
  class ClassTypeExtractor
    class << self
      def decorator_path method_name
        type = determine_class_type method_name
        
        dir = if type == 'lib'
          type
        else
          "app/#{type}"
        end

        suffix = namespace method_name
        dir += "/#{suffix}" if suffix

        dir
      end

      def determine_class_type method_name
        class_location_directory method_name
      end
      
      def class_location_directory method_name
        method_source(method_name).gsub(class_location(method_name), '').split('/').last
      end

      def method_source name
        DurableDecorator::Base.extract_method(name).source_location[0]
      end

      def path_parts name
        method_source(name).split('/')
      end
      
      def filename name
        path_parts(name)[-1]
      end

      def class_name method_name
        method_name.match(receiver_separator)[1]
      end

      def namespaces method_name
        parts = class_name(method_name).underscore.split('/')[0..-2] || []
        "/#{parts.join('/')}" unless parts.empty?
      end

      def class_location method_name
        "#{namespaces(method_name)}/#{filename method_name}"
      end

      def namespace method_name
        namespace = method_name.match(receiver_separator)[1].split('::')[0..-2].join('/').underscore
        namespace.presence
      end

      def receiver_separator
        /(.*)(\.|#)(.*)/
      end
    end
  end
end
