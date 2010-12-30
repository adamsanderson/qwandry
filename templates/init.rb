# ~/.qwandry/init.rb
#
# This file lets you configure where and how Qwandry looks for packages to open.
# 
# To learn more about Qwandry, take a look at the source with qwandry!
#     qw qwandry
#
# You can uncomment the indented code to try it out.
# If you get confused, just delete this file and run the customize command again.
#
# == Adding Personal Projects
# 
# If you keep all your projects in the home directory under projects,
# you can tell Qwandry to search there.
# 
#     register 'projects' do
#       add '~/Projects/personal'
#       add '~/Projects/work'
#       add '~/Experiments'
#     end
# 
# This will tell Qwandry that you want to create a `projects` configuration
# 
# For more advanced examples, try `qw qwandry` and take a look at 
# `configuration/default.rb`.

# == Setting Defaults
# To make `projects` a default search path, activate `projects`:
# 
#   default :projects
#
# You can also set multiple configurations to be the default:
# 
#   default :python, :projects