#!/usr/bin/env ruby

def usage_message(status = 1)
  puts "usage:\n" \
       "\t./bump {major|minor|patch} [version_file_name]\n\n" \
       " - version_file_name default = 'VERSION'\n" \
       " - version file ex:\n" \
       " \t0.0.0"
  exit status
end

what_to_bump = ARGV[0]
usage_message if what_to_bump.nil?

version_file = ARGV[1] || 'VERSION'
version = File.read(version_file).split('.') rescue usage_message
usage_message if version.any?(&:nil?)

version.map! do |v|
  Integer(v) rescue usage_message
end

index = ['major', 'minor', 'patch'].find_index(what_to_bump)
usage_message if index.nil?

puts "#{what_to_bump} bump"
version[index] += 1
((index + 1)..2).each { |i| version[i] = 0 }
File.write(version_file, version.join('.'))
