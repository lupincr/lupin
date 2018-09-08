module Lupin
  class Pipe(T)
    getter value

    def initialize(@value : T)
    end

    def pipe(plugin : Plugin)
      plugin.run(@value.as(T))
    end

    def type
      T
    end
  end
end
