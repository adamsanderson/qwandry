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
    Dir[File.dirname(__FILE__) + '/recipes/*.rb'].map do |recipe_path|
      require recipe_path
      class_name = File.basename(recipe_path,'.rb').split('_').map{|w| w.capitalize}.join
      Qwandry.const_get(class_name)
    end
  end
end