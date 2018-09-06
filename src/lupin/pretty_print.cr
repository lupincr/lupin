module Lupin
  class PP < Lupin::Plugin
    def exec(data)
      pp data
      true
    end
  end
end
