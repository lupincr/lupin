## Command

<p align="center">
  <b>
    <a href="https://github.com/molnarmark/lupin/blob/master/docs/3-command.md">Command</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/5-dist.md">Dist</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/4-src.md">Src</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/6-watch.md">Watch</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/7-plugins.md">Plugins</a>
    <br>
    Do you feel like the documentation could be extended, or changed somewhere? Don't hesitate to open a Pull Request.
  </b>
</p>

## What is command?

It's pretty easy. Calling `.command` on a task will attach the given shell command to the task, and they will be run in order when the task is executed.

## Simple example

```crystal
require "lupin"

Lupin.task("touch-files")
  .command("touch 1.txt && touch 2.txt")
  .command("rm -rf *.txt")
```

The above example will execute the given shell commands in order.

**NOTE**: `.dist`, `.watch` and `.src` can't be used on `command` tasks.

Let's talk about `.src`.

<p align="center">
  <a href="https://github.com/molnarmark/lupin/blob/master/docs/4-src.md">Next</a>
</p>
