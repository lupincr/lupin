# Simple test plugin that writes hello world to all given files.

module Lupin::Plugins
  class HelloWorld < Lupin::Plugin
    # TODO
    def run(data)
      true
    end
  end
end
