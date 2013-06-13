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
  
    # Launches a Package or path represented by a String. Unless `editor` will
    # check against the environment by default.
    def launch(package, editor=nil)
      editor ||= @editor || ENV['QWANDRY_EDITOR'] || ENV['VISUAL'] || ENV['EDITOR']
      
      if (!editor) || (editor =~ /^\s*$/) # if the editor is not set, or is blank, exit with a message:
        puts "Please set QWANDRY_EDITOR, VISUAL or EDITOR, or pass in an editor to use (-e editor)"
        if STDOUT.tty?
          print "Or, select an editor now: "
          editor = gets 
        else
          exit 1
        end
      end
      
      paths = package.is_a?(String) ? [package] : package.paths
      # Editors may have options, 'mate -w' for instance
      editor_and_options = editor.strip.split(/\s+/)
      
      Dir.chdir(File.dirname paths.first) do
        # Launch the editor with its options and any paths that we have been passed
        system(*(editor_and_options + paths))
      end
    end
    
    private
    
    # If there are multiple packages named the same, append their path to the name.
    # This could later be handled in other ways, for instance by merging the paths.
    def differentiate(packages)
      named_groups = Hash.new{|h,k| h[k] = []}
      packages.each{|p| named_groups[p.name] << p }
      named_groups.each do |name, packages| 
        if packages.length > 1
          packages.each{|p| p.name = "#{p.name} (#{p.paths.first})"} 
        end
      end
    end
    
  end
end
