$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'minitest/spec'
require 'tester/parse'
require 'tester/table'
Capybara.default_driver = :selenium
MiniTest::Unit.autorun

class MiniTest::Spec
  include Capybara

	class << self
		def scenario desc, &block
			it desc, &block
		end
		alias :Scenario :scenario

		def background type = :each, &block
			before type, &block
		end
		alias :Background :background
	end
end

module Kernel
	def feature desc, &block
		describe desc, &block
	end
	alias :Feature :feature
end
