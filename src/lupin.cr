# TODO: Write documentation for `Lupin`

require "./lupin/*"
require "./lupin/plugins/*"
require "epilog"
require "dir"

module Lupin
  VERSION = "0.1.0"
  @@debug = false
  @@tasks = [] of Lupin::Task
  @@logger = Epilog::Logger.new

  # Creates a new task
  def self.task(name : String, *params)
    task = Lupin::Task.new(name, params.at(0))
    @@tasks.push(task.as(Lupin::Task))

    self._debug("Task '#{name}' created.")

    task
  end

  # Override for tasks that do not start from nil
  # This includes: commands, directory structures (files)
  def self.task(name : String, param : String, mode = "w")
    mode = self._get_mode(param)
    task = self.task(name, {"mode" => mode})

    if mode == "directory"
      task.pipable = self.src(param, mode)
      self._debug("Detected directory: #{param}")
    end

    task
  end

  # Determines the task mode by the given param
  def self._get_mode(param)
    if param.includes?("/")
      "directory"
    elsif param.includes?(" ")
      "command"
    else
      "default"
    end
  end

  # Debugging utility
  def self._debug(message)
    if @@debug
      @@logger.debug message
    end
  end

  def self.set_debug(debug)
    @@debug = debug
  end

  # Load files with the given mode, according to the given path
  def self.src(path, mode)
    files = Dir.glob(path).map do |file_path|
      File.open(file_path, "w+")
    end

    Lupin::Pipable.new files
  end

  # Run a task
  def self.run(name : String)
    @@tasks.each do |task|
      if name == task.name
        @@logger.info("Running Task '#{name}'..")
        task.run
        @@logger.success("Task '#{name}' finished successfully.")
      end
    end
  end

  # Override to run multiple tasks
  # To be used for default tasks.
  def self.run(tasks : Array)
    tasks.each do |task|
      self.run(task)
    end
  end
end

Lupin.set_debug true

Lupin.task("Append hello world to all files", "test/*.txt", mode: "a")
  .pipe(Lupin::Plugins::HelloWorld.new)

Lupin.run("Append hello world to all files")
