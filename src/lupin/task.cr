module Lupin
  class Task
    getter name
    setter pipe

    def initialize(@name : String, params, @debug = false)
      @pipe_classes = [] of Plugin
      # TODO discuss starting value
      @pipe = Pipe(Bool).new(false)
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
          raise LupinException.new("Pipe '#{instance.class.name}' failed for task '#{@name}'. Possible nil return?")
        end
      end
    end

    # Load files with the given mode, according to the given path
    def src(path, mode = "w")
      @mode = "file"
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
      if @pipe.type != Array(InputFile)
        raise LupinException.new("dist may only be used on Array(Lupin::InputFile)")
      end

      @pipe.value.as(Array(InputFile)).each do |file|
        file.path = out_path

        if !Dir.exists?(out_path)
          Dir.mkdir_p(out_path)
        end

        file.write
      end

      self
    end

    def watch(dir)
      raise LupinException.new("Not implemented.")
    end

    def pipe(plugin : Plugin)
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
