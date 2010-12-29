module Qwandry
  # The FlatRepository assumes that each file or directory in the search path
  # is a stand alone Package.  For instance:
  # 
  #     rails-2.3.2
  #     rails-3.0.1
  #     thin
  # 
  class FlatRepository < Qwandry::Repository
    # Returns a Package for each matching file or directory.
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