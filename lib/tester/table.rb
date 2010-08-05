module Tester
  class Table
    def self.[] test_file, name
      parse_format = Tester::Configuration.config['table_format'] || 'plain_text'

      table_file = test_file.sub(/_spec\.rb$/,'').sub(/^#{Tester::Configuration.root}\/features\//) do
        Tester::Configuration.root + '/tables/'
      end + '.table'

      parse_format = parse_format.capitalize.gsub(/_(\w)/) { $1.capitalize }

      return Tester::Parse.const_get(parse_format)[table_file, name]
    end
  end
end
