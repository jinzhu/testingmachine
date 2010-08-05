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
    (types - Tester::Configuration.types) != types
  end
end

class MiniTest::Spec
  include Capybara

	class << self
		def scenario desc, opts = {}, &block
      return if opts[:type] && !Tester.should_run_type?(opts[:type])

      ## add settings
			it desc do
        self.instance_exec(&block)
      end
		end
		alias :Scenario :scenario

		def background type = :each, opts = {}, &block
      return if opts[:type] && !Tester.should_run_type?(opts[:type])
			before type do
        self.instance_exec(&block)
      end
		end
		alias :Background :background
	end
end

module Kernel
	def feature desc, opts = {}, &block
    return if opts[:type] && !Tester.should_run_type?(opts[:type])
    describe desc do
      self.instance_exec(&block)
    end
	end
	alias :Feature :feature
end
