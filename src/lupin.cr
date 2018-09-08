require "./lupin/*"
require "./lupin/plugins/*"
require "epilog"

module Lupin
  VERSION = "0.1.0"
  @@debug = false
  @@tasks = [] of Task
  @@logger = Epilog::Logger.new

  # Creates a new task
  def self.task(name : String)
    task = Task.new(name, @@debug)
    @@tasks.push(task.as(Lupin::Task))

    self.debug("Task '#{name}' created.")

    task
  end

  # Run a task
  def self.run(name : String)
    @@tasks.each do |task|
      if name == task.name
        task.run
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

  def self.debug_mode(debug)
    @@debug = debug
  end

  # Debugging utility
  private def self.debug(message)
    if @@debug
      @@logger.debug message
    end
  end

  # Process and execute raw shell commands
  private def self.command(command)
    # TODO allow multiple commands to be chained with &&
    command_args = command.split(" ")
    command_name = command_args.delete_at(0)
    status = Process.run(command_name, args: command_args)
    Pipe.new status.exit_code
  end
end

Lupin.debug_mode true

Lupin.task("command")
  .watch("./test/*.txt")
  .pipe(Lupin::Plugins::HelloWorld.new)
  .dist("./test/")

Lupin.run("command")
