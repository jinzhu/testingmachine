module Tester
  class Table
    def self.[] name
      test_file  = caller[1].sub(/:.*$/,'')
      table_file = test_file.sub(/_spec\.rb$/,'').sub(/\/features\//,'/tables/') + '.table'

      if File.exist?(table_file)
        return Tester::Parse::PlainText[table_file, name]
      end

      # TODO get caller's filename
      # caller
      # Read Configure, which parser?
      # :plain_text
      # Tester::Paser::PlainText[filename, name] => array -> before_each set var
    end
  end
end
