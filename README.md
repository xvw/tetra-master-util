# tetra-master-util

> Miscellaneous tools for the Final Fantasy IX Tetra Master card game

The card game (from Final Fantasy IX) relies on a lot of implicit probabilities,
and this little binary served as the basis for the article describing it (in
French) [on my site](https://xvw.lol).

## Programs

Currently, the project contains only one utility (used to write the [following
article](https://xvw.lol/pages/tetra-master.html)). However, it's possible that
the software will be enriched with new features as I continue to build on my
experience with the Tetra Master.

### vprob

`vprob` pessimistically calculates an attacking card's probability of victory
based on its statistics. `vprob` pessimistically calculates an attacking card's
probability of victory based on its statistics.

**invocation:**

```shell
./tetra.exe vprob --attacker {attacker_stats} --defender {defender_stats}
```

The statistics are the same as in FFIX: `PKPP` :

- `P` is a number in hexadecimal from `0` to `F`
- `K` is the kind of the card `P`, `M`, `X` or `A`.

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
