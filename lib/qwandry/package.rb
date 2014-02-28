module Qwandry
  class Package
    attr_accessor :name
    attr_accessor :paths                  
    attr_reader   :repository
  
    def initialize(name, paths, repository)
      @name = name
      @repository = repository
      @paths = paths
    end

    # Look for matched paths inside the package
    def deep_scan(pattern)
      packages = []

      paths.each do |path|
        Dir.glob("#{path}/**/*").each do |matched_path|
          # Match against the full path from the package root
          package_path = matched_path.gsub(%r{^#{Regexp.escape path}/}, '')

          if File.fnmatch("*#{pattern}*", package_path)
            # Wrap the matched paths in a new Package, adding the original package name
            packages << Package.new("#{name}/#{package_path}", [ matched_path ], repository)
          end
        end
      end

      packages
    end
  end
end
