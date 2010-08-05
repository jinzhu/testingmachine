$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'minitest/spec'
require 'tester/configuration'
require 'tester/parse'
require 'tester/table'

Capybara.default_driver = :selenium
MiniTest::Unit.autorun

module Tester
  def self.should_run_type?(types)
    return true  if Tester::Configuration.types.nil?
    return false if types.nil?
    types = types.to_a.map(&:to_s)
    (types - Tester::Configuration.types) != types
  end
end

class MiniTest::Spec
  include Capybara

	class << self
		def scenario desc, opts = {}, &block
      return unless Tester.should_run_type?(opts[:type])

      Tester::Configuration.load_setting_for_types(opts[:type])
      test_file = File.expand_path(caller[0].sub(/:.*$/,''))

      ## TODO add settings
      it desc do
        @_tester_name_chain = ((@_tester_name_chain || '') + ' > ' + desc).sub(/^ > /,'')
        data_table = Tester::Table[test_file, @_tester_name_chain]

        if data_table
          data_table.map do |example|
            example.headers.map do |header|
              instance_variable_set("@#{header}", example.send(header.to_sym))
            end
            self.instance_exec(&block)
          end
        else
          ## at least run once
          self.instance_exec(&block)
        end
      end
    end
    alias :Scenario :scenario

    def background type = :each, opts = {}, &block
      return unless Tester.should_run_type?(opts[:type])
      before type do
        self.instance_exec(&block)
      end
		end
		alias :Background :background
	end
end

module Kernel
	def feature desc, opts = {}, &block
    # return unless Tester.should_run_type?(opts[:type])
    test_file = File.expand_path(caller[0].sub(/:.*$/,''))

    describe desc do
      before do
        @_tester_name_chain = ((@_tester_name_chain || '') + ' > ' + desc).sub(/^ > /,'')
        data_table = Tester::Table[test_file, @_tester_name_chain]

        if data_table
          data_table.map do |example|
            example.headers.map do |header|
              instance_variable_set("@#{header}", example.send(header.to_sym))
            end
          end
        end
      end

      self.instance_exec(&block)
    end
	end
	alias :Feature :feature
end
