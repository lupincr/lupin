require "watcher"

module Lupin
  class Task
    getter name, pipe, watch, dist, watch_path, dist_path, watch_block
    setter pipe

    def initialize(@name : String, params, @debug = false)
      @pipe_classes = [] of Plugin
      @pipe = Pipe(Bool).new(false)
      @commands = [] of Command
      @logger = Epilog::Logger.new
      @watch = false
      @dist = false
      @watch_path = ""
      @dist_path = ""

      @watch_block = false
    end

    def run
      @logger.start("Running Task '#{name}'..")

      @commands.each do |command|
        begin
          run_command(command.name, command.args)
        rescue
          raise LupinException.new("Command '#{command.full}' failed on task '#{@name}'.")
        end
      end

      if @watch
        @logger.log("Watching for changes in #{@watch_path}..")
        run_watch
      else
        run_pipe
      end

      @logger.success("Task '#{name}' finished successfully.")
      self
    end

    private def run_pipe
      previous_value = @pipe.value
      self.debug(previous_value)
      @pipe_classes.each do |instance|
        instance.on("pre_run")
        previous_value = instance.run(previous_value)
        self.debug(previous_value)
        instance.on("after_run")

        if previous_value.is_a?(Nil)
          raise LupinException.new("Pipe '#{instance.class.name}' failed for task '#{@name}'. Possible nil return?")
        end
      end

      run_dist if @dist
    end

    # Load files with the given mode, according to the given path
    def src(path, mode = "w")
      files = Dir.glob(path).map do |file_path|
        name = File.basename(file_path)
        path = File.dirname(file_path) + "/"
        contents = File.read(file_path)
        InputFile.new(name, path, contents)
      end

      @pipe = Pipe(Array(InputFile)).new files
      self
    end

    def dist(out_path)
      @dist = true
      @dist_path = out_path
      self
    end

    def run_dist
      @watch_block = true
      if @pipe.type != Array(InputFile)
        raise LupinException.new("dist may only be used on Array(Lupin::InputFile)")
      end

      @pipe.value.as(Array(InputFile)).each do |file|
        file.path = @dist_path
        Dir.mkdir_p(@dist_path) if !Dir.exists?(@dist_path)

        file.write
      end

      # 1.5 is the sweet spot.
      # This is implemented so the watcher doesn't pick up the changes created by .dist
      delay (1.5) { @watch_block = false }
      self
    end

    def watch(dir)
      @watch_path = dir
      src(@watch_path)
      @watch = true
      self
    end

    def run_watch
      watch @watch_path do |event|
        event.on_change do |files|
          if !@watch_block
            run_pipe
            @logger.success("Watch pipeline executed successfully.")
          end
        end
      end
    end

    def pipe(plugin : Plugin)
      @pipe_classes.push(plugin)
      self
    end

    # Process and execute raw shell commands
    def command(command)
      split_commands = command.split("&&")

      split_commands.each do |text_command|
        text_command = text_command.chomp
        command_args = command.split(" ")
        command_name = command_args.delete_at(0)
        @commands.push(Command.new(command_name, command_args, text_command))
      end

      self
    end

    private def run_command(name, args)
      status = Process.run(name, args: args)
      status.exit_code
    end

    private def debug(value)
      @logger.log "Previous value of pipeline: #{value.to_s}" if @debug
    end
  end
end
