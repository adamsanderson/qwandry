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

# If defined, Qwandry will use XDG_CONFIG_HOME as the xdg spec. If not it 
# will check for an existing `~/.qwandry`.  Finally it will fall back to
# `~/.config/qwandry`.
# 
# Returns either the path the +config_dir+ or +nil+ if HOME is not defined.
# 
# XDG Spec:
#   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# 
def Qwandry.config_dir
  subdir = '/.qwandry/'
  if ENV['XDG_CONFIG_HOME']
    File.join(ENV['XDG_CONFIG_HOME'], subdir)
  elsif File.exist? File.join(ENV['HOME'], subdir)
    File.join(ENV['HOME'], subdir)
  elsif ENV['HOME']
    File.join(ENV['HOME'],'.config', subdir)
  else
    nil
  end
end