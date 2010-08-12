$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'minitest/spec'
require 'tm/configuration'
require 'tm/parse'
require 'tm/table'

Capybara.default_driver = :selenium
MiniTest::Unit.autorun

module TM
  def self.should_run?(tags=nil, name=nil)
    should_run_tags?(tags) && should_run_name?(name)
  end

  protected
  def self.should_run_tags?(tags)
    return true  if TM::Configuration.tags.nil?
    return false if tags.nil?
    tags = tags.to_a.map(&:to_s)
    (tags - TM::Configuration.tags) != tags
  end

  def self.should_run_name?(name)
    return true if TM::Configuration.names.nil?
    TM::Configuration.names.to_a.include?(name)
  end
end

class MiniTest::Spec
  include Capybara

	class << self
		def scenario desc, opts = {}, &block
      return unless TM.should_run?(opts[:tag], desc)
      TM::Configuration.load_setting_for_tags(opts[:tag])
      test_file = File.expand_path(caller[0].sub(/:.*$/,''))

      it desc do
        data_table = TM::Table[test_file, desc]

        if !data_table.empty?
          data_table.map do |example|
            instance_variable_set("@_headers", example.headers)
            example.headers.map do |header|
              instance_variable_set("@#{header}", example.send(header.to_sym))
            end
            self.instance_exec(&block)
          end
        else
          self.instance_exec(&block)
        end
      end
    end
    alias :Scenario :scenario

    def background type = :each, opts = {}, &block
      return unless TM.should_run?(opts[:tag])

      before type do
        self.instance_exec(&block)
      end
		end
		alias :Background :background
	end
end

module Kernel
  def feature desc, opts = {}, &block
    describe desc, &block
  end
  alias :Feature :feature
end
