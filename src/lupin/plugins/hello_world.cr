# Simple test plugin that writes hello world to all given files.

module Lupin::Plugins
  class HelloWorld < Lupin::Plugin
    def exec(files)
      files.as(Array(File)).each do |file|
        File.write(file.path, "Hello World.")
        file.close
      end

      files
    end
  end
end
