#!/usr/bin/env ruby

require_relative 'lib/class.Person'
require 'trollop'

opts = Trollop::options do
  opt :export, "Export to CSV"
  opt :lines, "Number of Lines", default: 25
end

track = Time.new

if opts[:export]

  # --------------------------------------------------
  # CSV Export
  # --------------------------------------------------

  folder = 'output'
  timestamp = Time.now.strftime '%Ymd-%H%M'
  file_name = "export-#{timestamp}.csv"

  Dir.chdir(folder)

  File.open(file_name, 'a') do |export|

    # CSV header row
    # --------------------------------------------------
    export.write "#{Person::SCHEMA.to_csv}\n"


    # CSV table body
    # --------------------------------------------------
    opts[:lines].times do |i|
      person = Person.new
      export.write "#{person.to_csv}\n"
      puts [
        person.full_name.ljust(64),
        person.ccis_username.ljust(32),
        person.ccis_password
      ].join ' '
    end

  end

  # keep latest for quick cat'ing
  IO.copy_stream(file_name, 'latest.csv')

else

  # --------------------------------------------------
  # Simple to_s
  # --------------------------------------------------

  opts[:lines].times do |i|
    person = Person.new
    puts person.to_s
  end

end

puts "#{opts[:lines]} rows, executed in #{Time.now - track} seconds."
