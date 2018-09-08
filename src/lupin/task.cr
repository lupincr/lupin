module Lupin
  class Task
    getter name
    setter pipe

    def initialize(@name : String, *params)
      @pipe_classes = [] of Lupin::Plugin

      # Task mode can be the following:
      # default: Task starts out with nil
      # directory: Task starts out with an array of files according to the given path
      # command: Task starts out with the given command being runuted and its exit code returned
      task_mode = "default"
      debug_task = false

      if params.size > 0
        params_hash = params.at(0)
        task_mode = params_hash.fetch("mode")

        # TODO
        # if params_hash.has?("debug")
        #   debug_task = true
        # end
      end

      if task_mode == "directory"
        @pipe = Lupin::Pipe(Array(String)).new([] of String)
      elsif task_mode == "command"
        @pipe = Lupin::Pipe(Int32).new(0)
      else
        @pipe = Lupin::Pipe(Nil).new(nil)
      end
      @logger = Epilog::Logger.new
    end

    def run
      previous_value = @pipe.value
      @pipe_classes.each do |instance|
        instance.on("pre_runution")
        previous_value = instance.run(previous_value)

        # TODO
        # if debug_task
        #   pp previous_value
        # end

        instance.on("after_runution")
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
