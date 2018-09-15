require "./lupin/*"
require "./lupin/plugins/*"
require "epilog"

module Lupin
  VERSION = "1.0.1@alpha"
  @@debug = false
  @@tasks = [] of Task
  @@logger = Epilog::Logger.new
  @@default_tasks : Array(String) = [] of String

  # Creates a new task
  def self.task(name : String)
    task = Task.new(name, @@debug)
    @@tasks.push(task.as(Lupin::Task))

    self.debug("Task '#{name}' created.")

    task
  end

  # Overload for creating a task with a callback function that gets executed first
  def self.task(name : String, cb)
    task = self.task(name)
    fn = cb.call
    task.pipe = Pipe(typeof(fn)).new(fn)
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

  # Adds a default task
  def self.default(subtask : String)
    @@default_tasks.push(subtask)
  end

  # Add multiple default tasks
  def self.default(subtasks : Array(String))
    @@default_tasks = subtasks
  end

  # Runs the default task(s)
  def self.run_default
    self.run(@@default_tasks)
  end

  # turns global debug mode on
  def self.debug_mode(debug)
    @@debug = debug
  end

  # returns the state of the debug mode
  def self.get_debug_mode
    @@debug
  end

  # Debugging utility
  private def self.debug(message)
    @@logger.debug message if @@debug
  end
end
