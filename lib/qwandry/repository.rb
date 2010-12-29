module Qwandry
  # A Repository's primary responsibility is to return a set of Packages that
  # match the search criteria used in Repository#scan.
  # 
  # Subclasses are expected 
  class Repository
    attr_reader :name
    attr_reader :path
    attr_reader :options
    
    # Creates a Repository with a give name, search path, and options.
    def initialize(name, path, options={})
      @name = name
      @path = path.chomp('/')
      @options = options
    end
    
    # Given a name, scan should an array with 0 or more Packages matching the
    # name.
    def scan(name)
      raise NotImplementedError, "Repositories must return an Array of matching packages."
    end
    
    # Returns all paths that should be tested by Qwandry#scan.
    def all_paths
      paths = Dir["#{@path}/*"]
      paths = paths.select(&matcher(options[:accept])) if options[:accept]
      paths = paths.reject(&matcher(options[:reject])) if options[:reject]
      paths
    end
  
    private
    # Helper for assembling a new package which may be launched by the Launcher
    def package(name, paths=[])
      Package.new(name, paths, self)
    end
    
    # Helper for generating a predicate methods
    def matcher(pattern)
      case pattern
      when Regexp then lambda{|p| p =~ pattern}
      when String then lambda{|p| File.fnmatch?(pattern, p)}
      when Proc   then pattern
      else raise ArgumentError, "Expected a Regexp, String, or Proc"
      end
    end
  end
end