module Qwandry
  class Configuration
    class << self
      # Regsisters a new Qwandry configuration.  Use in conjunction with Configuration#add like so:
      # 
      #     register 'projects' do
      #       add '~/Projects/personal'
      #       add '~/Projects/work'
      #       add '~/Experiments'
      #     end
      # 
      def register name, &block
        name = name.to_sym
        builders[name] << block
      end
      
      # Registers a configuration is a specific binary is available.  If `binary` is not specified,
      # it is assumed to be the same as the configuration name.
      def register_if_present name, binary=nil, &block
        binary ||= name
        register(name, &block) if present? binary
      end
      
      # Returns true if executable `name` is present.
      def present? name
        ENV['PATH'].split(File::PATH_SEPARATOR).any? do |pathDir|
          File.executable?(File.join pathDir, name.to_s)
        end
      end
      
      # Sets the default configuration to launch, if no `configurations` are passed
      # in, it returns their names.
      def default(*configurations)
        if configurations.empty?
          @default ||= []
        else
          @default = configurations
        end
      end
      
      # Returns the registered configurations
      def configurations
        builders.keys
      end
      
      # Loads a configuration file, and executes it in the context of the Qwandry::Configuration
      # class.  See `configuration/default.rb` for an example, or run:
      # 
      #     qw --customize
      # 
      # For a sample customization file.
      def load_configuration(path)
        if File.exist?(path)
          begin
            eval IO.read(path), nil, path, 1
          rescue Exception=>ex
            STDERR.puts "Warning: error in configuration file: #{path.inspect}"
            STDERR.puts "Exception: #{ex.message}"
            STDERR.puts ex.backtrace
          end
        end
      end
      
      # Loads the Qwandry default configuration and then the user's custom 
      # configuration file if it is present.
      def load_configuration_files
        # load default configuration files
        system_config_dir = File.join(File.dirname(__FILE__), 'configuration')
        Dir[system_config_dir+"/*.rb"].each do |path|
          load_configuration path
        end
        
        # load user custom init files
        if config_dir = Qwandry.config_dir
          custom_path = File.join(config_dir, 'init.rb')
          load_configuration(custom_path)
        end
      end
            
      # Loads the repositories for `names` if no names are given, it loads the defaults
      def repositories(*names)
        names = default if names.empty?
        repositories = []
        
        names.each do |name|
          name    = name.to_sym
          raise ArgumentError, "Unknown Repository type '#{name}'" unless builders.has_key? name
        
          builder = builders[name]
          repositories += builder.repositories
        end
        
        repositories
      end
        
      private
      
      def builders
        @builders ||= Hash.new{|h,name| h[name] = self.new(name) }
      end
      
    end
    
    # Creates a new Configuration for building a set of Repositories, this 
    # should probably only be invoked by Configuration.build, it only exists 
    # to make the customization DSL relatively easy to work with.
    def initialize(name)
      @name = name
      @blocks = []
      @repositories = []
    end
    
    def << (block)
      @blocks << block
    end
    
    def repositories
      @blocks.each{|block| instance_eval(&block) }
      @blocks.clear
      
      @repositories
    end
    
    # Adds a new Repository to the current configuration.
    # 
    # The `options` can be used to customize the repository.
    # 
    # [:class]        Repository class, defaults to Qwandry::FlatRepository
    # [:accept]       Filters paths, only keeping ones matching the accept option
    # [:reject]       Filters paths, rejecting any paths matching the reject option
    # 
    # `:accept` and `:reject` take patterns such as '*.py[oc]', procs, and regular expressions.
    # 
    #  Examples:
    #     # Add all my little ruby scripts in the scratch directory
    #     add '~/scratch', :accept => '*.rb'
    #     # Add log files in common locations for easy access, but ignore the zipped ones
    #     add ['/var/log/', '/usr/local/var/log/'], :reject => '*.bz2'
    # 
    def add(paths, options={})
      paths = [paths] if paths.is_a?(String)
      paths.each do |path|
        repository_class = options[:class] || Qwandry::FlatRepository
        @repositories << repository_class.new(@name, File.expand_path(path), options)
      end
    end
    
  end
end
