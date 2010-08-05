require 'rubygems'
require 'minitest/spec'
require 'rr'
MiniTest::Unit.autorun

class MiniTest::Spec
  include RR::Adapters::RRMethods
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'tester'
