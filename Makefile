.PHONY: all test build clean check-lint lint doc utop

all: build

# [make build] (or [make]) will build the source
build:
	dune build

# [make test] run all test
test:
	dune runtest --no-buffer -j 1

# [make clean] remove build artifacts (essentially the
# "_build/" folder)
clean:
	dune clean

# [make doc] build the documentation (using odoc)
doc: build
	dune build @doc

# [make utop] launch an REPL with the whole package in
# the context
utop:
	dune utop

# [make check-lint] ensure that the code is properly formatted
# according to the ".ocamlformat" file
check-lint:
	dune build @fmt

# [make lint] apply formatting according to the ".ocamlformat" file
lint:
	dune build @fmt --auto-promote



# Setting up the development environment

.PHONY: deps

# [make deps] will download locally the dependencies needed
# to build the libraries. That is, all the dependencies referenced
# in the OPAM description files.
deps:
	opam install . --deps-only --with-doc --with-test --with-dev-setup -y
