module Lupin
  class InputFile
    @name : String
    @path : String
    @contents : String

    getter name, path, contents
    setter name, path, contents

    def initialize(@name, @path, @contents)
    end

    def write
      File.write("#{@path}#{@name}", @contents)
    end
  end
end
