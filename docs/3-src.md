## Src

<p align="center">
  <b>
    <a href="#">Commands</a> | <a href="#">Dist</a> | <a href="#">Src</a> | <a href="#">Watch</a> | <a href="#">Plugins</a>
    <br>
    Do you feel like the documentation could be extended, or changed somewhere? Don't hesitate to open a Pull Request.
  </b>
</p>

## What is src?

Src is used to read files inside of a **Lupin** task, from a given pattern. src will always return an array of `InputFile`'s, which can be further modified.

## Simple example

```crystal
require "lupin"

Lupin.task("read-files")
  .src("./text-files/*.txt")
```

The above example will read every file with a `.txt` extension into an `InputFile`, thus forming an Array of `InputFile`'s.

The next pipe will receive this array as input, giving you the ability to manipulate the contents, path, and the file name.

The built-in `InputFile` has the following fields that are set upon initialization:

- name
- path
- contents

These fields can be modified during any pipe, however, these changes will not persist until .dist is called.

So if you have a task that starts out with `.src`, but no `.dist`, no changes will be written to the file system.

### Force writing

However, you can also force write these changes, by calling `.write` on an `InputFile`.

This requires no `.dist` calls.

Now you know what `src` does, lets talk about `dist`.

<p align="center">
  <a href="#">Next</a>
</p>
