# Custom Tasks

<p align="center">
  <b>
    <a href="#">Commands</a> | <a href="#">Dist</a> | <a href="#">Src</a> | <a href="#">Watch</a> | <a href="#">Plugins</a>
    <br>
    Do you feel like the documentation could be extended, or changed somewhere? Don't hesitate to open a Pull Request.
  </b>
</p>

## Introduction

Defining custom tasks in **Lupin** is really simple. Here is a simple task that does basically nothing:

```crystal
require "lupin"

Lupin.task("does-nothing")
```

You can run this by executing:

```sh
lupin run does-nothing
```

And, it does nothing! Exactly what it's supposed to do.

## Tasks in depth

While the above is already a valid task, **Lupin** has way more to offer.

Take the following example:

```crystal
require "lupin"
require "lupin/plugins/*"

Lupin.task("hello-world")
  .src("./text-files/*.txt")
  .pipe(Lupin::Plugins::HelloWorld.new)
  .dist("./text-files")
```

Looks a bit more exciting, right? This example assumes that you have a directory called `text-files`, with some text files in it.

When this task is ran, **Lupin** will read every text file inside that directory, pipe it into a Lupin Plugin called Hello World, and write the resulting files into the `text-files` directory.

This plugin comes with **Lupin**, so all you need to do is create a dummy directory with some text files, run the task, and what you will see is that every text file inside the given directory contains the word `Hello World!`.

A task can have as many pipes as you may want, the first pipe will receive the initial value of the task, and the next will receive the output from the previous pipe, and so on. It's that simple!

For more information regarding Lupin's Plugin capabilities, please take a look <a href="#">here</a>.

## Pipes

Every **Lupin** task has a `pipe` method, which accepts any class that inherits from `Lupin::Plugin`.

Instead of passing blocks, we decided to use the plugin system as a default way to attach functionality to a task.

About plugins, please read the [Plugin Documentation](plugindocs)

## Default tasks

To define default tasks, take a look at the following example:

```crystal
Lupin.default("hello-world")
```

When `lupin run` is invoked without any tasks, the default task will be ran.

You can also give the default task an array of task names, and they will run in order.

```crystal
Lupin.default(["hello-world", "my-task", "my-second-task"])
```

Next, lets talk about `src`.

<p align="center">
  <a href="#">Next</a>
</p>
