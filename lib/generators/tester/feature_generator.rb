require 'rails/generators'

module Tester
  class FeatureGenerator < Rails::Generators::Base
    source_root File.join(File.dirname(__FILE__), 'templates')

    desc <<-DESC
Description:
    Sets up WebTester for your Rails project.
    `rails generate tester:feature filename`
DESC

    def manifest
      template       'feature.feature', 'tester/features/'
    end
  end
end
