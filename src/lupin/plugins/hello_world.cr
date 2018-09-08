# Simple test plugin that writes hello world to all given files.

module Lupin::Plugins
  class HelloWorld < Lupin::Plugin
    # TODO
    def run(files)
      files.as(Array(Lupin::InputFile)).each do |file|
        file.contents = "Hello World."
      end

      files
    end
  end
end
