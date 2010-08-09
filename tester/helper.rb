require 'tester'
require 'rubygems'
require 'minitest/spec'
require 'rr'
MiniTest::Unit.autorun

module HelperMethods
	def hello
		false
	end
end

class MiniTest::Spec
	include HelperMethods
  include RR::Adapters::RRMethods
end
