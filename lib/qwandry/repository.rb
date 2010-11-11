module Qwandry
  class Repository
    attr_reader :name
    attr_reader :path
  
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