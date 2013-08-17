module DurableDecorator
  class DecoratorGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :subdirectory, :type => :string
    argument :full_method_name, :type => :string

    def ensure_decorator_existence
      ensure_file
      ensure_method
    end

  private

    def namespaces
      filesystem_parts[0..-2]
    end

    def parts
      target.match(receiver_separator_regex)[1..3]
    end

    def receiver_separator_regex
      /(.*)(\.|#)(.*)/
    end

    def target
      filesystem_parts.last
    end

    def class_name
      parts[0]
    end

    def full_class_name
      full_method_name.match(receiver_separator_regex)[1]
    end

    def separator
      parts[1]
    end

    def method_name
      parts[2]
    end

    def namespace_dirs
      namespaces.map(&:underscore)
    end

    def filename
      "#{class_name.underscore}_decorator.rb"
    end

    def filesystem_parts
      full_method_name.split('::')
    end

    def dir_structure
      "app/#{subdirectory}/#{namespace_dirs.join('/')}"
    end

    def full_path
      "#{dir_structure}/#{filename}"
    end

    def ensure_file
      template "decorator.rb.erb", full_path unless File.exists?(full_path)
    end

    def ensure_method
      append_decoration unless method_decorated?
    end

    def append_decoration
      contents = File.read(full_path).sub("\n", redefinition_template)
      File.open(full_path, 'wb') { |file| file.write(contents) }
    end

    def redefinition_template
      "  \n\n" +
      redefinition_body +
      "  \n" 
    end

    def redefinition_body
      "  durably_decorate :#{method_name}, mode: 'strict', sha: '#{existing_sha}' do #{decoration_args}\n" +
      "  end"
    end

    def existing_sha
      DurableDecorator::Base.determine_sha full_method_name
    end

    def decoration_args
      "|#{minimum_arity.times.map{|n| "arg#{n}"}.join(', ')}|" if minimum_arity > 0
    end

    def minimum_arity
      arity = DurableDecorator::Base.determine_arity(full_method_name)
      if arity < 0
        (arity+1).abs
      else
        arity
      end
    end

    def method_decorated? 
      existing_contents.match /durably_decorate :#{method_name}/
    end

    def existing_contents
      File.read(full_path)
    end
  end
end
