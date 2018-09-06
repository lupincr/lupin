# TODO: Write documentation for `Lupin`

require "./lupin/*"
require "epilog"
require "dir"

module Lupin
  VERSION = "0.1.0"
  DEBUG   = false

  @@tasks = [] of Lupin::Task
  @@logger = Epilog::Logger.new

  # Creates a new task
  def self.task(name)
    task = Lupin::Task.new(name)
    @@tasks.push(task)
    if DEBUG
      @@logger.debug "Task '#{name}' created."
    end

    task
  end

  # Override for simple command-driven tasks
  def self.task(name, command)
    # TODO
  end

  # Override for tasks starting out with files
  def self.task(name, pipable : Lupin::Pipable)
    task = Lupin::Task.new(name)
    task.pipable = pipable
    @@tasks.push(task)
    if DEBUG
      @@logger.debug "Task '#{name}' created."
    end

    task
  end

  def self.src(path)
    files = Dir.glob(path).map do |file_path|
      File.open(file_path)
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
  def self.run(tasks : Array)
    tasks.each do |task|
      self.run(task)
    end
  end
end

class LupinAppendHelloWorld < Lupin::Plugin
  def exec(value)
    value + "Hello World."
  end
end

Lupin.task("helloworld")
  .pipe(LupinAppendHelloWorld.new)
  .pipe(LupinAppendHelloWorld.new)

Lupin.task("helloworld2")
  .pipe(LupinAppendHelloWorld.new)
  .pipe(LupinAppendHelloWorld.new)

Lupin.run(["helloworld", "helloworld2"])
