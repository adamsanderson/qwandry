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
    attr_reader :name
    
    def initialize(name, path)
      @name = name
      @path = path.chomp('/')
    end
  
    def scan(name)
      []
    end
    
    def package(name, paths)
      Package.new(name, paths, self)
    end
  end

  # Directories look like:
  #     Repository
  #       lib-0.1
  #       lib-0.2
  class FlatRepository < Repository
    def scan(name)
      results = []
      Dir["#{@path}/*"].select do |path|
        if File.basename(path).start_with?(name)
          results << package(File.basename(path), [path])
        end
      end
      
      results
    end
  end
  
  
  class Package
    attr_reader :name
    attr_reader :repository
    attr_reader :paths
    
    def initialize(name, paths, repository)
      @name = name
      @repository = repository
      @paths = paths
    end
  end
  
  def launch(package, editor=nil)
    editor ||= ENV['VISUAL'] || ENV['EDITOR']
    system editor, *package.paths
  end
  module_function :launch
  
end

if __FILE__ == $0
  load('repositories.rb')
  load('~/.qwandry/repositories.rb') if File.exists?('~/.qwandry/repositories.rb')
  
  opts = OptionParser.new do |opts|    
    opts.banner = "Usage: qwandry [options] name [version]"

    opts.separator ""
    opts.separator "Known Repositories:"
    @repositories.keys.each do |repo_label|
      opts.separator "  #{repo_label}"
    end
    
  end

  opts.parse! ARGV

  if ARGV.length != 1
    puts opts
    exit(-1)
  end
  
  name = ARGV.pop
  packages = []

  @repositories.each do |set, repos|
    repos.each do |repo|
      packages.concat(repo.scan(name))
    end
  end
  
  package = nil
  case packages.length
  when 0
    puts "No packages matched '#{name}'"
    exit 1
  when 1
    package = packages.first
  else
    packages.each_with_index do |package, index|
      puts "%3d. %s" % [index+1, package.name]
    end

    print ">> "
    index = gets.to_i-1
    package = packages[index]
  end
  
  Qwandry.launch package if package
end