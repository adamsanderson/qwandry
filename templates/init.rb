# ~/.qwandry/init.rb
#
# This file lets you configure where and how Qwandry looks for packages to open.
# 
# To learn more about Qwandry, take a look at the source with qwandry!
#     qw qwandry
# 
# You can uncomment the indented code to try it out.

# == Adding Projects
# 
# If you keep all your projects in the home directory under projects,
# you can tell Qwandry to search there.
# 
#   add :projects, "~/Projects/"

# == Setting Defaults
# To make `projects` a default search path, activate `projects`:
# 
#   activate :projects
#
# If you don't use ruby, you can de-activate it:
# 
#   deactivate :ruby

# == Common Repositories
# Below are some common configurations you might find useful, these may vary
# from system to system.

# = Haskel
# Open Cabal packages:
#   add :ghc, "~/.cabal/lib"
# Open Haskel system libraries:
#   add :ghc, "/usr/local/lib/ghc/"

# = Python
# Open python standard libraries:
#   add :python, "/usr/lib/python2.6/", Qwandry::LibraryRepository

# = Ruby
# Qwandry comes set up for ruby by default, however you may want to be able to
# quickly access the ruby sources.
# 
# If you installed ruby with `rvm`, your path might be something like this:
#   add :cruby, "~/.rvm/src/ruby-1.9.1-p378/"

# = Javascript / Node
# Edit node.js and npm managed libraries:
#   add :node, "/usr/local/lib/node/"