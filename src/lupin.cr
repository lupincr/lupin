require "./lupin/*"
require "./lupin/plugins/*"
require "epilog"

module Lupin
  VERSION = "1.0.0@alpha"
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
end
