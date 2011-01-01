# Launcher is the core Qwandry class, it coordinates finding and launching
# a package.  It is driven externaly by a UI, for instance the `bin/qw`.
module Qwandry 
  class Launcher
    # The default editor to be used by Qwandry#launch.
    attr_accessor :editor 
    
    # Searches all of the loaded repositories for `name`
    def find(*pattern)
      # Create a glob pattern from the user's input, for instance
      # ["rails","2.3"] => "rails*2.3*"
      pattern = pattern.join('*')
      pattern << '*' unless pattern =~ /\*$/
      
      packages = []
      repositories = Qwandry::Configuration.repositories
      repositories.each do |repo|
        packages.concat(repo.scan(pattern))
      end
      
      differentiate packages
      packages
    end
    
    def differentiate(packages)
      named_groups = Hash.new{|h,k| h[k] = []}
      packages.each{|p| named_groups[p.name] << p }
      named_groups.each do |name, packages| 
        if packages.length > 1
          packages.each{|p| p.name = "#{p.name} (#{p.paths.first})"} 
        end
      end
    end
  
    # Launches a Package or path represented by a String. Unless `editor` will
    # check against the environment by default.
    def launch(package, editor=nil)
      editor ||= @editor || ENV['VISUAL'] || ENV['EDITOR']
      
      if (!editor) || (editor =~ /^\s*$/) # if the editor is not set, or is blank, exit with a message:
        puts "Please either set EDITOR or pass in an editor to use"
        exit 1
      end
      
      paths = package.is_a?(String) ? [package] : package.paths
      # Editors may have options, 'mate -w' for instance
      editor_and_options = editor.strip.split(/\s+/)
      
      # Launch the editor with its options and any paths that we have been passed
      system(*(editor_and_options + paths))
    end
        
  end
end
