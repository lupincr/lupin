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
end
