# Getting Started

<p align="center">
  <b>
    <a href="https://github.com/lupincr/lupin/blob/master/docs/3-command.md">Command</a> | <a href="https://github.com/lupincr/lupin/blob/master/docs/5-dist.md">Dist</a> | <a href="https://github.com/lupincr/lupin/blob/master/docs/4-src.md">Src</a> | <a href="https://github.com/lupincr/lupin/blob/master/docs/6-watch.md">Watch</a> | <a href="https://github.com/lupincr/lupin/blob/master/docs/7-plugins.md">Plugins</a>
    <br>
    Do you feel like the documentation could be extended, or changed somewhere? Don't hesitate to open a Pull Request.
  </b>
</p>

Lupin comes with a handy tool, The Lupin CLI. The installation guide for that can be found over at [our website](http://lupincr.com) \
Or you can simply copy this shell command and run it in your terminal:

```sh
curl -s https://lupincr.com/install/lupin.sh | sh
```

The installation script is dead simple. It will create a directory inside your `$HOME`, called **.lupin** which will contain the binary for the Lupin CLI.

## First Steps

`cd` inside your project, and make sure you have Lupin locally installed for that project. \
If you don't have it installed, you can add this inside your `shard.yml` file:

```yaml
dependencies:
  lupin:
    github: lupincr/lupin
```

After that, run `shards` to install the dependency.

Lupin CLI comes with a few handy built-in tools to get you started.

To generate a `lupinfile.cr` template, you can use:

```sh
lupin init
```

This will generate a simple `lupinfile.cr` that contains one simple task called `first-step`, which is a shell command.

To run this task, execute:

```sh
lupin run first-step
```

As you can see, it created a file called `lupin-works.txt` inside your project, meaning Lupin is working! :tada:

To get rid of that file, run:

```sh
rm lupin-works.txt
```

For information regarding how to create your custom tasks, head over to the next section!

<p align="center">
  <a href="https://github.com/lupincr/lupin/blob/master/docs/2-custom-tasks.md">Next</a>
</p>
