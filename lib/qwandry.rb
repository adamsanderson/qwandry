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
# If no Repository matches, then qwandry will exit with a 404 (repo not found)
#
module Qwandry
  autoload :Launcher,       "qwandry/launcher"
  autoload :Repository,     "qwandry/repository"
  autoload :FlatRepository, "qwandry/flat_repository"
  autoload :Package,        "qwandry/package"
end

if __FILE__ == $0
  @qwandry = Qwandry::Launcher.new
  load('~/.qwandry/repositories.rb') if File.exists?('~/.qwandry/repositories.rb')
  
  opts = OptionParser.new do |opts|    
    opts.banner = "Usage: qwandry [options] name [version]"
    opts.separator ""
    
    opts.separator "Known Repositories: #{@qwandry.repositories.keys.join(", ")}"
    opts.on("-e", "--editor EDITOR", "Use EDITOR to open the package") do |editor|
      @qwandry.editor = editor
    end
    
    opts.on_tail("-h", "--help", "Show this message") do
      puts opts
      exit
    end
  end

  opts.parse! ARGV

  if ARGV.length != 1
    puts opts
    exit(1)
  end
  
  name = ARGV.pop
  packages = @qwandry.find(name)

  package = nil
  case packages.length
  when 0
    puts "No packages matched '#{name}'"
    exit 404 # Package not found -- hehe, super lame.
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
  
  @qwandry.launch(package) if package
end