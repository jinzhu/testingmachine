module Tester
	module Parse
		class PlainText
			@@data = {}
			attr_accessor :file, :name, :headers

			def initialize(file, name)
				self.file, self.name = file, name
				@@data[file] ||= {}
				@@data[file][name] ||= []
			end

			def self.[](file, name)
				parse(file) unless @@data[file]
				@@data[file][name]
			end

			def add_row(values)
				values = values.sub(/^\|/,'').sub(/\|\s*$/,'').split(' | ').map(&:strip)
				return(set_header(values)) if headers.nil?

				@@data[file][name].push PlainText::Row.new(values, headers)
			end

			protected
			def self.parse(file)
				table = nil

				File.read(file).each_line do |line|
					if line =~ /^== (.*)$/
						table = self.new(file, $1)
					end

					if table && line =~ /^\|\s/
						table.add_row(line)
					end
				end
			end

			def set_header(values)
				## hash has no order
				self.headers = values
			end
		end

		class PlainText::Row
			attr_accessor :values, :headers

			def initialize(values, headers)
				self.values, self.headers = [], headers

				[values, headers].transpose.map do |value, header|
					self.instance_eval <<-EOF
						def #{header}
							#{value} rescue #{value.inspect}
						end
          EOF

					self.values.push PlainText::Attribute.new(value, header)
				end
			end

			# def method_missing(method_name, *args, &block)
			# 	self.values.send(method_name, *args, &block)
			# end
		end

		class PlainText::Attribute
			attr_accessor :value, :header

			def initialize(value, header)
				self.value, self.header = value, header
			end
			alias :to_s :value
		end
	end
end
