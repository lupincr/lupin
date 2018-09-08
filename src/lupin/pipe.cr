module Lupin
  class Pipe(T)
    getter value

    def initialize(@value : T)
    end

    def pipe(plugin : Lupin::Plugin)
      plugin.run(@value.as(T))
    end
  end
end
