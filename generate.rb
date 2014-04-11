#!/usr/bin/env ruby

require_relative 'lib/class.Person'
require 'trollop'

opts = Trollop::options do
  opt :export, "Export to CSV"
end

do_export = !!opts[:export]

timestamp = Time.now.strftime '%Ymd-%H%M'
export = File.open("output/export-#{timestamp}.csv", 'a') if do_export

25.times do |i|
  person = Person.new

  export.write "#{person.to_csv}\n" if do_export
  puts person.to_s
end

export.close if do_export
