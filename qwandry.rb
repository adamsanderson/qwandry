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

##
class Repository
  def initialize(path)
    @path = path.chomp('/')
  end
  
  def scan(name)
    []
  end
end

class FlatRepository < Repository
  def scan(name)
    Dir["#{@path}/*"].select{|path| path if File.basename(path).start_with?(name)}
  end
end

##
load('repositories.rb')

name = ARGV.pop
candidates = []

@repositories.each do |set, repos|
  repos.each do |repo|
    candidates.concat(repo.scan(name))
  end
end

candidates.each_with_index do |path, index|
  puts " #{index+1}. #{File.basename path}"
end

print ">> "
index = gets.to_i-1
path = candidates[index]
`mate #{path}`