module Qwandry
  class Package
    attr_reader :name
    attr_reader :repository
    attr_reader :paths
  
    def initialize(name, paths, repository)
      @name = name
      @repository = repository
      @paths = paths
    end
  end
end