# Default recipe, adds ruby sources to Qwandry.

# Ensure that rubygems is on the path so we can search it
require 'rubygems'

class Qwandry::Default < Qwandry::Recipe
  name        "Default"
  description "Searches the ruby standard library and ruby gems"
  
  def configure(qw)
    # Get all the paths on ruby's load path:
    paths = $:

    # Reject binary paths, we only want ruby sources:
    paths = paths.reject{|path| path =~ /#{RUBY_PLATFORM}$/}

    # Add ruby standard libraries:
    paths.grep(/lib\/ruby/).each do |path|
      qw.add :ruby, path, Qwandry::LibraryRepository
    end

    # Add gem repositories:
    ($:).grep(/gems/).map{|p| p[/.+\/gems\//]}.uniq.each do |path|
      qw.add :gem, path
    end
  end
end