module Qwandry
  # Directories look like:
  #       ./lib-0.1
  #       ./lib-0.2
  class FlatRepository < Qwandry::Repository
    def scan(name)
      results = []
      all_paths.select do |path|
        if File.basename(path).start_with?(name)
          results << package(File.basename(path), [path])
        end
      end
      
      results
    end
  end
end