module SpreeAvatax
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_avatax'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
    
    def self.activate
      Dir[File.join(File.dirname(__FILE__), "../../app/models/spree/calculator/*.rb")].sort.each do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    initializer 'spree.register.calculators' do |app|
      Dir[File.join(File.dirname(__FILE__), "../../app/models/spree/calculator/avalara/*.rb")].sort.each do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      app.config.spree.calculators.tax_rates << Spree::Calculator::Avatax
    end
    
    config.to_prepare &method(:activate).to_proc

  end
end
