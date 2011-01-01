module Qwandry
  # The LibraryRepository assumes that the search path contains files in the root mixed with
  # directories of the same name which should be opened together.  Ruby's date library is a good
  # example of this:
  # 
  #     date.rb
  #     date/
  # 
  class LibraryRepository < Qwandry::Repository
    
    # Returns Packages that may contain one or more paths if there are similar
    # root level files that should be bundled together.
    def scan(pattern)
      results = Hash.new{|h,k| h[k] = package(k)}
      all_paths.select do |path|
        basename = File.basename(path)
        if File.fnmatch?(pattern, basename, File::FNM_CASEFOLD)
          # strip any file extension
          basename.sub! /\.\w+$/,'' unless File.directory?(path)
          results[basename].paths << path
        end
      end
      
      results.values.sort_by{|package| package.name}
    end
  end
end