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

let docs = Cmdliner.Manpage.s_common_options

let stat_conv =
  let docv = "The statistic of a card [HKHH]" in
  let printer = Lib.Stat.pp in
  let parser value =
    match Lib.Stat.from_string value with
    | Some x -> Result.ok x
    | None ->
      let message =
        `Msg (Format.asprintf "[%s] is not a valid stat format" value)
      in
      Result.error message
  in
  Cmdliner.Arg.conv ~docv (parser, printer)
;;

let stat_attacker_arg =
  let open Cmdliner in
  let doc = "the statistic of the attacker, ie: 4p23" in
  let arg = Arg.info ~doc ~docs [ "attacker" ] in
  Arg.(required & opt (some stat_conv) None & arg)
;;

let stat_defender_arg =
  let open Cmdliner in
  let doc = "the statistic of the defender, ie: 4p23" in
  let arg = Arg.info ~doc ~docs [ "defender" ] in
  Arg.(required & opt (some stat_conv) None & arg)
;;
