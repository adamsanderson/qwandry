module Qwandry
  class Package
    attr_accessor :name
    attr_accessor :paths                  
    attr_reader   :repository
  
    def initialize(name, paths, repository)
      @name = name
      @repository = repository
      @paths = paths
    end
  end
end