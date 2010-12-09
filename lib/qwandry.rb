#!/usr/bin/env ruby
require 'optparse'
require 'set'
require 'fileutils'

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
  autoload :Launcher,                   "qwandry/launcher"
  autoload :Repository,                 "qwandry/repository"
  autoload :FlatRepository,             "qwandry/flat_repository"
  autoload :LibraryRepository,          "qwandry/library_repository"
  autoload :Package,                    "qwandry/package"
end

def Qwandry.config_dir
  subdir = '/.qwandry/'
  
  case
    # If available, use XDG_CONFIG_HOME
    #   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
    when ENV['XDG_CONFIG_HOME'] then File.join(ENV['XDG_CONFIG_HOME'], subdir)
      
    # Otherwise fallback to qwandry's default and use the standard home dir
    when ENV['HOME']            then File.join(ENV['HOME'], subdir)
    
    # If HOME isn't defined, all bets are off.
    else nil 
  end
end