#!/usr/bin/env ruby
require_relative 'lib/class.Person'

I18n.enforce_available_locales = false # avoid pescy deprecation warning...

10.times do |i|
  person = Person.new
  puts person.to_s
end
