require 'minitest/spec'
require 'tester/parse'
require 'tester/table'

module Tester
end

class MiniTest::Spec
	def self.scenario desc, &block
		self.it desc, &block
	end

	def self.background type = :each, &block
		self.before type, &block
	end
end


module Kernel
	def feature desc, &block
		describe desc, &block
	end
end
