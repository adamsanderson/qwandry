
# Register the default ruby configuration:
register :ruby do
  # Reject binary paths, and then find only the `/lib/ruby` sources:
  paths = ($:).reject{|path| path =~ /#{RUBY_PLATFORM}$/}.grep(/lib\/ruby/)
  
  # Add ruby standard libraries using the LibraryRepository:
  add paths, :class=>Qwandry::LibraryRepository
end

# Register the default ruby gems configuration:
register_if_present :gem do
  # Get the gem paths from the ruby load paths:
  paths = ($:).grep(/gems/).map{|p| p[/.+\/gems\//]}.uniq
  
  # Add all the rubygems' paths:
  add paths
end

# Register a perl configuration:
register_if_present :perl do
  # Execute a perl script to find all of the perl load paths:
  perl_paths = `perl -e 'foreach $k (@INC){print $k,"\n";}'` rescue ''
  
  # Split on new lines, rejecting blank paths and the current directory:
  perl_paths = perl_paths.split("\n").reject{|path| path == '' || path == '.'}
  
  # Add perl paths as a LibraryRepository
  add perl_paths, :class=>Qwandry::LibraryRepository
end

# Add python repositories:
register_if_present :python do
  # Execute a python script to find all of the python load paths:
  python_paths = `python -c 'import sys;print(\"\\n\".join(sys.path))'` rescue ''
  
  # Reject all the blank paths and the current directory.  Also reject anything that looks like a binary
  python_paths = python_paths.split("\n").reject{|path| path == '' || path == '.' || path =~ /\.zip$/ || path =~/lib-dynload$/}
  
  # Add the python paths, instruct Qwandry to skip any compiled files when trying to match a file/library:
  add python_paths, :class=>Qwandry::LibraryRepository, :reject => /\.(py[oc])|(egg-info)$/
end

# Add node.js repositories:
register_if_present :node do
  # Execute a node script to find all of the load paths:
  node_script_path = File.join(File.dirname(__FILE__),'probe_node.js')
  node_paths = `node #{node_script_path}` rescue ''
  
  node_paths = node_paths.split("\n")
  # Add the node paths
  add node_paths
end

# If we can figure out where the user's ruby source directory is, add it.
register_if_present :ruby_src, :rvm do
  # If present, use the current rvm's ruby source, this will probably be MRI
  # though you never know.  We could later try to be smarter about jruby, etc.
  path = File.join(ENV['rvm_src_path'], ENV['rvm_ruby_string'])

  # Add the sources, use a LibraryRepository to bundle .h and .c files
  add path, :reject=>/\.(o|a|dylib)$/, :class=>Qwandry::LibraryRepository
end

# Qwandry is a ruby app after all, so activate ruby and gem by default.  Other defaults can be set
# with a custom init.rb
default :ruby, :gem