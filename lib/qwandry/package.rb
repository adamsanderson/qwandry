module Qwandry
  class Package
    attr_reader :name
    attr_reader :paths
    attr_reader :repository
  
    def initialize(name, paths, repository)
      @name = name
      @repository = repository
      @paths = paths
    end
  end
end