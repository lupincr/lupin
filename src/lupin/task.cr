module Lupin
  class Task
    getter name
    setter pipable

    def initialize(@name : String)
      @pipe_classes = [] of Lupin::Plugin
      @pipable = Lupin::Pipable(String).new("")
      @logger = Epilog::Logger.new
    end

    def initialize(@name : String, pipable : Lupin::Pipable)
      initialize(@name)
      @pipable = pipable
    end

    def run
      previous_value = ""

      @pipe_classes.each do |inLupince|
        inLupince.on("pre_execution")
        previous_value = inLupince.exec(previous_value)
        inLupince.on("after_execution")
        if previous_value.is_a?(Nil)
          @logger.error("Pipe '#{inLupince.class.name}' failed for task '#{@name}'")
          Process.exit(1)
        end
      end
    end

    def pipe(plugin : Lupin::Plugin)
      @pipe_classes.push(plugin)
      self
    end
  end
end
