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