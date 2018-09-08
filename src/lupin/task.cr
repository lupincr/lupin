module Lupin
  class Task
    getter name
    setter pipe

    def initialize(@name : String, params, @debug = false)
      @pipe_classes = [] of Lupin::Plugin

      # Task mode can be the following:
      # default: Task starts out with nil
      # directory: Task starts out with an array of files according to the given path
      # command: Task starts out with the given command being runuted and its exit code returned
      task_mode = "default"

      if params.size > 0
        task_mode = params.fetch("mode")
      end

      if task_mode == "directory"
        @pipe = Lupin::Pipe(Array(Lupin::InputFile)).new([] of Lupin::InputFile)
      elsif task_mode == "command"
        @pipe = Lupin::Pipe(Int32).new(0)
      else
        @pipe = Lupin::Pipe(Nil).new(nil)
      end
      @logger = Epilog::Logger.new
    end

    def run
      previous_value = @pipe.value
      self.debug(previous_value)

      @pipe_classes.each do |instance|
        instance.on("pre_run")
        previous_value = instance.run(previous_value)
        self.debug(previous_value)

        instance.on("after_run")
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

    private def debug(value)
      if @debug
        @logger.log "Previous value of pipeline: #{value.to_s}"
      end
    end
  end
end
