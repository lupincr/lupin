# Watch

<p align="center">
  <b>
    <a href="https://github.com/molnarmark/lupin/blob/master/docs/3-command.md">Command</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/5-dist.md">Dist</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/4-src.md">Src</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/6-watch.md">Watch</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/7-plugins.md">Plugins</a>
    <br>
    Do you feel like the documentation could be extended, or changed somewhere? Don't hesitate to open a Pull Request.
  </b>
</p>

## Monitoring file changes

Lupin has built in support to monitor file changes, and run the pipeline whenever a file has changed.

Example:

```crystal
require "lupin"

Lupin.task("watch-for-changes")
  .watch("./text-files/*.txt")
```

This above task, when invoked will start watching for changes in files according to the given pattern.

This feature uses `.src` under the hood, so whenever you call `.watch`, the files will turn into an Array of `InputFile`'s and the next pipe will receive those.

When running in watch mode, **Lupin** will be in a blocking state, but whenever a file changes, your pipeline will be re-run.

Example:

```crystal
require "lupin"

Lupin.task("watch-dir")
  .watch("./text-files/*.txt")
  .pipe(MyFancyPlugin.new)
  .pipe(MyNextFancyPlugin.new)
```

Also, `watch` and `dist` can be used together, making it an extremely useful feature for plugins such as bundlers, CSS minifiers, etc.

Given how flexible **Lupin** is, you can just add a final `dist` call to the end of your task, _however_, if you decide to do this, the last pipe has to return an Array of `InputFile`'s, since that's what `dist` accepts.

Next, lets dive into Plugins!

<p align="center">
  <a href="https://github.com/molnarmark/lupin/blob/master/docs/7-plugins.md">Next</a>
</p>
