module Qwandry
  class Repository
    attr_reader :name
  
    def initialize(name, path)
      @name = name
      @path = path.chomp('/')
    end

    def scan(name)
      []
    end
  
    def package(name, paths=[])
      Package.new(name, paths, self)
    end
  end
end