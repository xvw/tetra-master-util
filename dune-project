(lang dune 3.0)
(name tetra-master-util)
(version dev)
(generate_opam_files true)


(source (github xvw/tetra-master-util))
(license MIT)
(authors "Xavier Van de Woestyne")
(maintainers "Xavier Van de Woestyne")

(package
 (name tetra-master-util)
 (synopsis "Miscellaneous tools for the Final Fantasy IX Tetra Master card game")
 (description "A companion tool for a blog post about Tetra Master (the FFIX's card game)")
 (depends
  (ocaml (>= 5.0.0))
  (dune (>= 3.0.0))
  cmdliner
  ppx_deriving
  (alcotest :with-test)
  (merlin :with-dev-setup)
  (ocamlformat :with-dev-setup)
  (ocp-indent :with-dev-setup)
  (utop :with-dev-setup)))
