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

module P = Lib.Stat.Point
module K = Lib.Stat.Kind

(* Unsafe stat creation for test purpose. *)
let m s = Option.get (Lib.Stat.from_string s)

let test_from_string =
  Alcotest.test_case "some from_string projection" `Quick (fun () ->
    let expected =
      Lib.Stat.
        [ Option.some @@ mk P.p3 K.p P.p6 P.p0
        ; Option.some @@ mk P.p2 K.p P.p0 P.p1
        ; Option.some @@ mk P.p0 K.p P.p0 P.p0
        ; Option.some @@ mk P.p0 K.m P.p0 P.p0
        ; Option.some @@ mk P.p1 K.p P.p0 P.p0
        ; Option.some @@ mk P.p1 K.p P.p2 P.p0
        ; Option.some @@ mk P.p7 K.p P.p6 P.p7
        ; Option.some @@ mk P.p4 K.x P.p5 P.p1
        ; Option.some @@ mk P.p6 K.m P.p0 P.p5
        ; Option.some @@ mk P.p5 K.x P.p3 P.p3
        ; Option.some @@ mk P.p2 K.m P.p1 P.p0
        ; Option.some @@ mk P.pF K.a P.p0 P.pF
        ; Option.some @@ mk P.pA K.a P.pA P.pA
        ; Option.some @@ mk P.p0 K.x P.pD P.pE
        ; Option.some @@ mk P.pF K.a P.pF P.pF
        ; None
        ; None
        ]
    and computed =
      [ "3p60"
      ; "2P01"
      ; "0P00"
      ; "0M00"
      ; "1p00"
      ; "1P20"
      ; "7P67"
      ; "4x51"
      ; "6m05"
      ; "5x33"
      ; "2M10"
      ; "FA0F"
      ; "AAAA"
      ; "0XDE"
      ; "FAFF"
      ; "0XDEE"
      ; "FXPD"
      ]
      |> List.map Lib.Stat.from_string
    in
    Alcotest.(check @@ list (option Test_util.stat_testable))
      "should be equal"
      expected
      computed)
;;

let test_pick_target =
  Alcotest.test_case "pick target" `Quick (fun () ->
    let expected = P.[ p2; pF; p0; p1; p1; p0; p0; p3 ]
    and computed =
      [ m "3p60", m "1a2f"
      ; m "3m60", m "1a2f"
      ; m "0x00", m "0p10"
      ; m "0x00", m "1m91"
      ; m "0x00", m "9p19"
      ; m "0a00", m "0p12"
      ; m "0a00", m "9m09"
      ; m "0a00", m "3p9a"
      ]
      |> List.map (fun (attacker, defender) ->
        Lib.Stat.pick_target ~attacker ~defender)
    in
    Alcotest.(check @@ list Test_util.point_testable)
      "should be equal"
      expected
      computed)
;;

let test_pessimistic_probability =
  Alcotest.test_case "pessimistic probabilities" `Quick (fun () ->
    let expected = [ 87.69; 96.44; 12.70; 75.38 ]
    and computed =
      [ m "4p22", m "1m01"
      ; m "exff", m "1m01"
      ; m "4p23", m "exff"
      ; m "4p23", m "2m12"
      ]
      |> List.map (fun (attacker, defender) ->
        Lib.Stat.pessimistic_probability ~attacker ~defender)
    in
    Alcotest.(check @@ list (float Float.epsilon))
      "should be equal"
      expected
      computed)
;;

let cases =
  ( "Lib.Stat"
  , [ test_from_string; test_pick_target; test_pessimistic_probability ] )
;;
