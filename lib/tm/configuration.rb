require 'yaml'

module TM
  class Configuration
    class << self
      attr_accessor :tags, :names, :root

      def root
				test_path = File.expand_path('testingmachine')
        @root ||= File.exist?(test_path) ? test_path : File.expand_path('.')
      end

      def root=(path)
        @root = path if File.directory?(path)
      end

      def config
        ['config', '../config'].map do |f|
          config_file = File.join( root, f, 'testingmachine.yml')
          return YAML.load_file(config_file) if File.exist?(config_file)
        end
        return {}
      end

      def load_setting_for_tags(tags=[])
        tags = tags.to_a.unshift(:all)
        tags.map do |tag|
          config = self.config['tags'] && self.config['tags'][tag.to_s]
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
