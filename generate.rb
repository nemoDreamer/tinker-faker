#!/usr/bin/env ruby

require_relative 'lib/class.Person'
require 'trollop'

opts = Trollop::options do
  opt :export, "Export to CSV"
end

if opts[:export]
  timestamp = Time.now.strftime '%Ymd-%H%M'

  File.open("output/export-#{timestamp}.csv", 'a') do |export|

    25.times do |i|
      person = Person.new
      export.write "#{person.to_csv}\n"
      puts [
        person.full_name.ljust(32),
        person.username.ljust(32),
        person.password
      ].join ' '
    end

  end

else

  10.times do |i|
    person = Person.new
    puts person.to_s
  end

end

