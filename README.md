<p align="center">
  <img src="https://github.com/molnarmark/lupin/blob/master/assets/logo.png"/>
</p>

# Lupin

> All in one Task Runner for Crystal

Lupin is heavily inspired by [Gulp]("http://gulpjs.com") and tries to keep the API as close to Gulp's as possible.
We want to make it easy for JavaScripters, who might not have a Ruby background to experience the power that Crystal provides.


## Why?
Lupin was developed with one simple concept in mind. While Crystal already comes with a lot of helpful built in commands, we felt that there is space to improve. You can just toss a `lupinfile.cr` inside your project, and have multiple tasks that might run deployment, multiple unit tests, integration tests, CSS minifiers, you name it.

Lupin gets rid of all the time consumed by executing commands. Automate your workflow instead, and spend more time writing Crystal code - something you truly love!

## Roadmap

- [x] Create a LupinInputFile type that holds the file path and the file content
- [x] Add a `Lupin.debug` method to encapsulate all if DEBUG statements
- [x ] Implement `Lupin.dist`
- [x] Implement `Lupin.watch`
- [x] Refactor
- [x] Logo
- [ ] Site
- [ ] Docs
- [ ] Proper, pretty readme
- Implement lupinfile.yml parsing as a fallback if lupinfile.cr doesn't exist.

## Maintainers

Lupin is maintained by 2 JavaScript programmers.
- Mark Molnar - Initial concept, designing & implementation of Lupin
- Milan Szekely - Website maintainer, active Lupin contributor

## License
TODO