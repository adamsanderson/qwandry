module Qwandry
  # Directories look like:
  #       ./lib-0.1
  #       ./lib-0.2
  class FlatRepository < Qwandry::Repository
    def scan(pattern)
      results = []
      all_paths.select do |path|
        if File.fnmatch?(pattern, File.basename(path))
          results << package(File.basename(path), [path])
        end
      end
      
      results
    end
  end
end