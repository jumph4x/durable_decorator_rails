require 'spec_helper'
require 'example/app/models/example_model.rb'
require 'example/lib/example_lib.rb'
require 'example/lib/namespaced/and_again/example_lib.rb'

describe DurableDecoratorRails::ClassTypeExtractor do
  let(:singleton){ DurableDecoratorRails::ClassTypeExtractor }

  context 'on .decorator_path' do
    context 'when given the fully qualified method name' do
      it 'returns the correct Rails decorator path' do
        singleton.decorator_path("ExampleModel#methud").should == 'app/models'
      end
    end

    context 'when given a namespaced file' do
      it 'takes into account the namespace' do
        singleton.decorator_path("Namespaced::AndAgain::ExampleLib.methud").should == 'lib/namespaced/and_again'
      end
    end
  end

  context 'on .determine_class_type' do
    context 'when given the fully qualified method name' do
      it 'returns the correct Rails class type' do
        singleton.determine_class_type("ExampleModel.methud").should == 'models'
        singleton.determine_class_type("ExampleModel#methud").should == 'models'
        singleton.determine_class_type("ExampleLib#methud").should == 'lib'
      end
    end

    context 'when given a namespaced file' do
      it 'pulls through' do
        singleton.determine_class_type("Namespaced::AndAgain::ExampleLib.methud").should == 'lib'
      end
    end
  end
end
