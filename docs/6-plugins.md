# Plugins

<p align="center">
  <b>
    <a href="#">Commands</a> | <a href="#">Dist</a> | <a href="#">Src</a> | <a href="#">Watch</a> | <a href="#">Plugins</a>
    <br>
    Do you feel like the documentation could be extended, or changed somewhere? Don't hesitate to open a Pull Request.
  </b>
</p>

## Lupin Plugins

Lupin works in a very simple way, and given that, we want to make sure it has a built-in plug and play plugin system. So we did just that!

With a Task's `pipe` method only accepting Lupin Plugins, we wanted to make sure that the **Lupin Community** can build and reuse Plugins built by other community members.

### Simple Plugin structure

A simple **Lupin** Plugin looks like this:

```crystal
require "lupin"

module YourModule
  class YourPluginName < Lupin::Plugin
    def run(input)
      input
    end
  end
end
```

As you can see, a simple plugin just inherits from `Lupin::Plugin`.

### Must Have

A Lupin plugin must have a `run` method inside, and that will be called whenever the pipeline gets to that Plugin.

_NOTE:_ Make sure you always return something from your run method that isn't `nil`.

## Community Plugins

Since Lupin has just released, the **Crystal Community** has yet to pick it up, and we are sure that as time goes, we will be able to list some amazing Lupin Plugins here, created by none other than the community.

## Plugin Shards

We encourage everyone that wants to create a Lupin Plugin as a shard, to prefix its name with `lupin-` to avoid naming conflicts and to get the shard recognized as a **Lupin** plugin.
