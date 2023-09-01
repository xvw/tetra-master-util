# tetra-master-util

> Miscellaneous tools for the Final Fantasy IX Tetra Master card game

The card game (from Final Fantasy IX) relies on a lot of implicit probabilities,
and this little binary served as the basis for the article describing it (in
French) [on my site](https://xvw.lol).

## Setting up the development environment

Setting up a development environment is quite common. We recommend setting up a
local switch to collect dependencies locally. Here are the commands to enter to
initiate the environment:

```shell
opam update
opam switch create . ocaml-base-compiler.5.0.0 --deps-only -y
eval $(opam env)
```

After initializing the switch, you can collect the development and project
dependencies using make:

```shell
make deps
```
