module Lupin
  class Pipable(T)
    def initialize(@value : T)
    end

    def pipe(plugin : Lupin::Plugin)
      plugin.on("pre_execution")
      plugin.exec(@value)
    end
  end
end
