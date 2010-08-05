#!/usr/bin/env ruby
require 'optparse'

puts "Qwandry; a qwestionable tool"
opts = OptionParser.new do |opts|    
  opts.banner = "Usage: qwandry [options] [type] repository-name"

  opts.separator ""
  opts.separator "Known Repositories:"
  # ...
end

opts.parse! ARGV

if ARGV.length != 1
  puts opts
  exit(-1)
end

load('repositories.rb')

name = ARGV.pop
candidates = []

@repositories.each do |set, repos|
  repos.each do |repo|
    Dir["#{repo}/*"].each{|path| candidates << path if File.basename(path).start_with?(name)}
  end
end

candidates.each_with_index do |path, index|
  puts " #{index+1}. #{File.basename path}"
end

print ">> "
index = gets
path = candidates[index.to_i-1]
`mate #{path}`