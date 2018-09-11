module Lupin
  class Command
    getter name, args, full

    def initialize(@name : String, @args : Array(String), @full : String)
    end
  end
end
