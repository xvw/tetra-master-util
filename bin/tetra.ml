(* MIT License

   Copyright (c) 2023 Xavier Van de Woestyne

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE. *)

open Cmdliner

let docs = Manpage.s_common_options
let exits = Cmd.Exit.defaults
let version = "dev"

let pessimistic_probability, vprob =
  let doc =
    "Pessimistic calculation of the probability (in a pessimistic way) of \
     victory of an attacking statistic over a defending statistic."
  in
  let info_p = Cmd.info "pessimistic-probability" ~version ~doc ~exits in
  let info_v = Cmd.info "vprob" ~version ~doc ~exits in
  let term =
    Term.(
      const Program.pessimistic_probability
      $ Args.stat_attacker_arg
      $ Args.stat_defender_arg)
  in
  Cmd.v info_p term, Cmd.v info_v term
;;

let index =
  let doc = "Tetra Master util" in
  let info = Cmd.info Sys.argv.(0) ~version ~doc ~sdocs:docs ~exits in
  let default = Term.(ret (const (`Help (`Pager, None)))) in
  Cmd.group info ~default [ pessimistic_probability; vprob ]
;;

let () = exit @@ Cmd.eval index
