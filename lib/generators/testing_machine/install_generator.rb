require 'rails/generators'

module TestingMachine
  class InstallGenerator < Rails::Generators::Base
    source_root File.join(File.dirname(__FILE__), 'templates')

    desc <<-DESC
Description:
    Sets up WebTM for your Rails project.
    `rails generate testing_machine:install`
DESC

    def manifest
      empty_directory 'testingmachine/features'
      empty_directory 'testingmachine/tables'
      copy_file       'config.yml', 'config/testingmachine.yml'
      copy_file       'helper.rb', 'testingmachine/helper.rb'
    end
  end
end
