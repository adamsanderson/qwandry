module Qwandry
  # Directories look like:
  #     lib1.rb
  #       ./lib1
  #     lib2.py
  #       ./lib2
  class LibraryRepository < Qwandry::Repository
    def scan(name)
      results = Hash.new{|h,k| h[k] = package(k)}
      Dir["#{@path}/*"].select do |path|
        basename = File.basename(path)
        if basename.start_with?(name)
          # strip any file extension
          basename.sub! /\.\w+$/,'' unless File.directory?(path)
          results[basename].paths << path
        end
      end
      
      results.values.sort_by{|package| package.name}
    end
  end
end