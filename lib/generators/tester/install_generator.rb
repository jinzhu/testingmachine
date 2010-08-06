require 'rails/generators'

module Tester
  class InstallGenerator < Rails::Generators::Base
    source_root File.join(File.dirname(__FILE__), 'templates')

    desc <<-DESC
Description:
    Sets up WebTester for your Rails project.
    `rails generate tester:install`
DESC

    def manifest
      empty_directory 'tester/features'
      empty_directory 'tester/tables'
      copy_file       'tester.yml', 'config/tester.yml'
      copy_file       'helper.rb', 'tester/helper.rb'
    end
  end
end
