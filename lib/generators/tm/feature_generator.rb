require 'rails/generators'

module Tm
  class FeatureGenerator < Rails::Generators::Base
    source_root File.join(File.dirname(__FILE__), 'templates')

    desc <<-DESC
Description:
    Sets up WebTM for your Rails project.
    `rails generate tm:feature filename`
DESC

    def manifest
      ARGV.map do |name|
        @name          = name.gsub(/[A-Z]/) {|x| '_' + x.downcase }.sub(/^_/,'').gsub(/\/_/,'/')
        spec_filename  = "testingmachine/features/#{@name}_spec.rb"
        table_filename = "testingmachine/tables/#{@name}.table"
        @const_name    = File.basename(@name).capitalize.gsub(/_(\w)/) { $1.capitalize }

        empty_directory File.dirname(spec_filename)
        template "feature_spec.rb", spec_filename
        template "table.table", table_filename
      end
    end
  end
end
