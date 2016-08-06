#!/usr/bin/env ruby

def usage_message(status = 1)
  puts "usage:\n" \
       "\n" \
       "bump {major|minor|patch} [version_file_name]\n" \
       "\t- version_file_name default = 'VERION'\n" \
       "\t- version file ex:\n" \
       "\t\t0.0.0"
  exit status
end

level = ARGV[0]
usage_message if level.nil?

version_file = ARGV[1] || 'VERSION'
version = File.read(version_file).split('.') rescue usage_message
usage_message if version.any?(&:nil?)

version.map! do |v|
  Integer(v) rescue usage_message
end

index = ['major', 'minor', 'patch'].find_index(level)
usage_message if index.nil?

puts "#{level} bump"
version[index] += 1
File.write(version_file, version.join('.'))
