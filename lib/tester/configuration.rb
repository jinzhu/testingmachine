require 'yaml'

module Tester
  class Configuration
    class << self
      attr_accessor :types, :root

      def root
				test_path = File.expand_path('tester')
        @root ||= (rails_root? && File.exist?(test_path)) ? test_path : File.expand_path('.')
      end

      def config
        ['config', '../config'].map do |f|
          config_file = File.join( root, f, 'tester.yml')
          return YAML.load_file(config_file) if File.exist?(config_file)
        end
        return {}
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

			protected
			def rails_root?
				File.exist?('config/application.rb')
			end
    end
  end
end
