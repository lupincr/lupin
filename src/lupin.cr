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
    task = Lupin::Task.new(name, params.at(0), @@debug)
    @@tasks.push(task.as(Lupin::Task))

    self.debug("Task '#{name}' created.")

    task
  end

  # Override for tasks that do not start from nil
  # This includes: commands, directory structures (files)
  def self.task(name : String, param : String, mode = "w")
    mode = self.get_mode(param)
    task = self.task(name, {"mode" => mode})

    if mode == "directory"
      task.pipe = self.src(param, mode)
      self.debug("Detected directory: #{param}")
    elsif mode == "command"
      task.pipe = self.command(param)
    end

    task
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

  def self.set_debug(debug)
    @@debug = debug
  end

  # Determines the task mode by the given param
  private def self.get_mode(param)
    if param.includes?("/")
      "directory"
    elsif param.includes?(" ")
      "command"
    else
      "default"
    end
  end

  # Debugging utility
  private def self.debug(message)
    if @@debug
      @@logger.debug message
    end
  end

  # Load files with the given mode, according to the given path
  private def self.src(path, mode)
    files = Dir.glob(path).map do |file_path|
      File.read(file_path)
    end

    Lupin::Pipe.new files
  end

  # Process and execute raw shell commands
  private def self.command(command)
    # TODO allow multiple commands to be chained with &&
    command_args = command.split(" ")
    command_name = command_args.delete_at(0)
    status = Process.run(command_name, args: command_args)
    Lupin::Pipe.new status.exit_code
  end
end

Lupin.set_debug true

Lupin.task("command", "echo test")
Lupin.run("command")
