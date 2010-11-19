module Qwandry
  # Directories look like:
  #     lib1.rb
  #     lib1/...
  #     lib2.py
  #     lib2/...
  class LibraryRepository < Qwandry::Repository
    def scan(pattern)
      results = Hash.new{|h,k| h[k] = package(k)}
      all_paths.select do |path|
        basename = File.basename(path)
        if File.fnmatch?(pattern, basename)
          # strip any file extension
          basename.sub! /\.\w+$/,'' unless File.directory?(path)
          results[basename].paths << path
        end
      end
      
      results.values.sort_by{|package| package.name}
    end
  end
end