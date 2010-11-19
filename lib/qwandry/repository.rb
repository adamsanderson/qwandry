module Qwandry
  class Repository
    attr_reader :name
    attr_reader :path
    attr_reader :options
  
    def initialize(name, path, options={})
      @name = name
      @path = path.chomp('/')
      @options = options
      
    end
    
    def scan(name)
      []
    end
    
    def all_paths
      paths = Dir["#{@path}/*"]
      paths = paths.select(&matcher(options[:accept])) if options[:accept]
      paths = paths.reject(&matcher(options[:reject])) if options[:reject]
      paths
    end
  
    def package(name, paths=[])
      Package.new(name, paths, self)
    end
    
    private
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