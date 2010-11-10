class Qwandry::Recipe
  class << self
    
    def name(v=nil)
      if v
        @name = v
      else
        @name || self.to_s
      end
    end
  
    def description(v=nil)
      if v
        @description = v
      else
        @description || ""
      end
    end
  end
  
  
  # Recipes should implement the `configure` method.
  def configure(qw)
    
  end
  
  
  def self.load_recipes
    # Load all required recipes:
    built_in_path = File.dirname(__FILE__) + '/recipes/*.rb'
    custom_path   = ENV['HOME'] + '/.qwandry/*.rb' if ENV['HOME']

    Dir[built_in_path, custom_path].compact.map do |recipe_path|      
      require recipe_path
      class_name = File.basename(recipe_path,'.rb').split('_').map{|w| w.capitalize}.join
      begin
        Qwandry.const_get(class_name)
      rescue Exception => e
        STDERR.puts "Could not load recipe '#{recipe_path}'"
        STDERR.puts e
      end
    end
  end
end