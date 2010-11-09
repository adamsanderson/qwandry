# Default recipe, adds ruby sources to Qwandry.

# Ensure that rubygems is on the path so we can search it
require 'rubygems'

# Get all the paths on ruby's load path:
paths = $:

# Reject binary paths, we only want ruby sources:
paths = paths.reject{|path| path =~ /#{RUBY_PLATFORM}$/}

# Add ruby standard libraries:
paths.grep(/lib\/ruby/).each do |path|
  add :ruby, path, Qwandry::LibraryRepository
end

# Add gem repositories:
($:).grep(/gems/).map{|p| p[/.+\/gems\//]}.uniq.each do |path|
  add :gem, path
end