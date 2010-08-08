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
      ARGV.map do |name|
        @name = name.gsub(/[A-Z]/) {|x| '_' + x.downcase }.sub(/^_/,'').gsub(/\/_/,'/')
        filename = "tester/features/#{@name}_spec.rb"
        empty_directory File.dirname(filename)
        template "feature_spec.rb", filename
      end
    end
  end
end
