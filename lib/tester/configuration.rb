require 'yaml'

module Tester
  class Configuration
    class << self
      attr_accessor :types

      def root
        File.expand_path('.')
      end

      def config
        config_file = File.join( root, 'config', 'tester.yml')
        File.exist?(config_file) ? YAML.load_file(config_file) : {}
      end

      def load_setting_for_types(types=[])
        types = types.to_a.unshift(:all)
        types.map do |type|
          config = self.config['types'] && self.config['types'][type.to_s]
          load_config(config)
        end
      end

      def load_config(config)
        ## load configuration for Capybara
        capybara_config = config && config['capybara']
        capybara_config.map { |f| Capybara.send((f[0] + '=').to_sym, f[1]) } if capybara_config
      end
    end
  end
end
