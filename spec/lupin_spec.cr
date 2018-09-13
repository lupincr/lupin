require "spec"
require "../src/lupin"
require "../src/lupin/plugins/*"

describe Lupin do
  it "works with a simple named task" do
    task = Lupin.task("test")
    task.name.should eq "test"
  end

  it "works with debug mode" do
    Lupin.debug_mode true
    Lupin.get_debug_mode.should eq true
  end

  it "works with src" do
    task = Lupin.task("test").src("./spec/data/*.txt")
    task.pipe.value.as(Array).size.should eq 3
  end

  it "works with src and dist" do
    task = Lupin.task("test")
      .src("./spec/data/*.txt")
      .dist("./spec/data_out")

    task.dist.should eq true
    task.dist_path.should eq "./spec/data_out"
  end

  it "works with a single default task" do
    Lupin.task("default_task").command("touch default1.txt")
    Lupin.task("default_task_cleanup").command("rm default1.txt")

    Lupin.default("default_task")
    Lupin.run_default
    exists = File.exists?("default1.txt")
    Lupin.run("default_task_cleanup")
    exists.should eq true
  end

  it "works with multiple default tasks" do
    Lupin.task("default_task").command("touch default1.txt")
    Lupin.task("default_task2").command("touch default2.txt")
    Lupin.task("default_task_cleanup").command("rm default1.txt && rm default2.txt")

    Lupin.default(["default_task", "default_task2"])

    Lupin.run_default

    exists = File.exists?("default1.txt")
    exists2 = File.exists?("default2.txt")

    Lupin.run("default_task_cleanup")
    exists.should eq true
    exists2.should eq true
  end

  it "works with a shell command" do
    Lupin.task("command_task")
      .command("touch ./spec/test.txt")
    Lupin.task("command_task_cleanup")
      .command("rm ./spec/test.txt")

    Lupin.run("command_task")

    exists = File.exists?("./spec/test.txt")

    Lupin.run("command_task_cleanup")
    exists.should eq true
  end
end
