module Lupin
  class Pipable(T)
    getter value

    def initialize(@value : T)
    end

    def pipe(plugin : Lupin::Plugin)
      plugin.exec(@value.as(T))
    end
  end
end
