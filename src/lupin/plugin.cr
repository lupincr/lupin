module Lupin
  abstract class Plugin
    def exec
    end

    def on(event_type : String)
    end
  end
end
