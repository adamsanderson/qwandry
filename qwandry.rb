#!/usr/bin/env ruby
require 'optparse'

# Informal Spec:
# 
# A User may have multiple Repositories
# A Repositories contains Packages
# 
# A User will search for a repository giving a name and optional version
# Each Repository will be scanned for matching Packages
# If only one Package matches, that Package will be opened
# If more than one Package matches, then the user will be prompted to pick one
#   While any two Packages share the same name their parent dir is appended
# If no Repository matches, then qwandry will exit with a -404 (repo not found)
#
module Qwandry

  class Repository
    def initialize(path)
      @path = path.chomp('/')
    end
  
    def scan(name)
      []
    end
  end

  # Directories look like:
  #     Repository
  #       lib-0.1
  #       lib-0.2
  class FlatRepository < Repository
    def scan(name)
      Dir["#{@path}/*"].select{|path| path if File.basename(path).start_with?(name)}
    end
  end

end

if __FILE__ == $0
  opts = OptionParser.new do |opts|    
    opts.banner = "Usage: qwandry [options] name [version]"

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
end