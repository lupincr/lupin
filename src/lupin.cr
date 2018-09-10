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

  def self.get_debug_mode
    @@debug
  end

  # Debugging utility
  private def self.debug(message)
    if @@debug
      @@logger.debug message
    end
  end

  private def run_command(name, args)
    status = Process.run(name, args: args)
    status.exit_code
  end

  # Process and execute raw shell commands
  private def self.command(command)
    # TODO allow multiple commands to be chained with &&
    if command.includes?("&&")
      final_exit_code = 0
      split_commands = command.split("&&")

      split_commands.each do |text_command|
        text_command = text_command.chomp
        command_args = command.split(" ")
        command_name = command_args.delete_at(0)
        final_exit_code = run_command(command_name, command_args)
      end

      final_exit_code
    else
      command_args = command.split(" ")
      command_name = command_args.delete_at(0)
      run_command(command_name, command_args)
    end
  end
end
