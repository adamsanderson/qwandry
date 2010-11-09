# Launcher is the core Qwandry class, it coordinates finding and launching
# a package.  It is driven externaly by a UI, for instance the `bin/qw`.
module Qwandry 
  class Launcher
    # The default editor to be used by Qwandry#launch.
    attr_accessor :editor 
  
    # Returns the repositories the Launcher will use.
    attr_reader :repositories
  
    def initialize
      @repositories = Hash.new{|h,k| h[k] = []}
    end
  
    # Adds a repository path to Qwandry's Launcher.
    # `label` is used to label packages residing in the folder `path`.
    # The `repository_type` controls the class used to index the `path`.
    def add(label, path, repository_type=Qwandry::FlatRepository)
      label = label.to_s
      @repositories[label] << repository_type.new(label, path)
    end
  
    # Searches all of the loaded repositories for `name`
    def find(name)
      packages = []
      @repositories.each do |label, repos|
        repos.each do |repo|
          packages.concat(repo.scan(name))
        end
      end
      packages
    end
  
    # Launches a `package`. Unless `editor` will check against the environment by default.
    def launch(package, editor=nil)
      editor ||= @editor || ENV['VISUAL'] || ENV['EDITOR']
      system editor, *package.paths
    end
  end
end