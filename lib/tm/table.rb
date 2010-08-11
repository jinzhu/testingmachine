module TM
  class Table
    def self.[] test_file, name
      parse_format = TM::Configuration.config['table_format'] || 'plain_text'
      table_file = test_file.sub(/_spec\.rb$/,'').sub(/^#{TM::Configuration.root}\/features\//,'')
      ## constantize: plain_text => PlainText
      parse_format = parse_format.capitalize.gsub(/_(\w)/) { $1.capitalize }
      return TM::Parse.const_get(parse_format)[table_file, name.strip]
    end
  end
end
