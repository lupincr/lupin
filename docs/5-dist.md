# Dist

<p align="center">
  <b>
    <a href="https://github.com/molnarmark/lupin/blob/master/docs/3-command.md">Command</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/5-dist.md">Dist</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/4-src.md">Src</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/6-watch.md">Watch</a> | <a href="https://github.com/molnarmark/lupin/blob/master/docs/7-plugins.md">Plugins</a>
    <br>
    Do you feel like the documentation could be extended, or changed somewhere? Don't hesitate to open a Pull Request.
  </b>
</p>

## What is dist?

Dist works in a very simple way. It receives an Array of `InputFile`'s, and writes them to the given path.

For example:

```crystal
require "lupin"

Lupin.task("move-files")
  .src("./text-files/*.txt")
  .dist("./new-text-files")
```

The above example will read all of the files that match the given pattern, put them into `InputFile`'s and when `dist` is called, it will receive the array of `InputFile`'s and write them to the given path.

Sounds pretty simple, right?

`dist` is pretty simple, lets talk about `watch`.

<p align="center">
  <a href="https://github.com/molnarmark/lupin/blob/master/docs/6-watch.md">Next</a>
</p>
