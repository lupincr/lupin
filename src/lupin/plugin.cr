module Lupin
  abstract class Plugin
    def run
    end

    def on(event_type : String)
    end
  end
end
