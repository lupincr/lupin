module Lupin
  class Task
    getter name
    setter pipable

    def initialize(@name : String, *params)
      @pipe_classes = [] of Lupin::Plugin

      # Task mode can be the following:
      # default: Task starts out with nil
      # directory: Task starts out with an array of files according to the given path
      # command: Task starts out with the given command being executed and its exit code returned
      task_mode = "default"

      if params.size > 0
        task_mode = params.at(0).fetch("mode")
      end

      if task_mode == "directory"
        @pipable = Lupin::Pipable(Array(File)).new([] of File)
      elsif task_mode == "command"
        @pipable = Lupin::Pipable(Int32).new(0)
      else
        @pipable = Lupin::Pipable(Nil).new(nil)
      end
      @logger = Epilog::Logger.new
    end

    def run
      previous_value = @pipable.value
      @pipe_classes.each do |instance|
        instance.on("pre_execution")
        previous_value = instance.exec(previous_value)
        instance.on("after_execution")
        if previous_value.is_a?(Nil)
          @logger.error("Pipe '#{instance.class.name}' failed for task '#{@name}'")
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
