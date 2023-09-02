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

let test_some_equalities =
  Alcotest.test_case "some equalities" `Quick (fun () ->
    let expected = [ true; true; true; true; true; false; false; false ]
    and computed =
      Lib.Stat.Point.
        [ equal p0 p0
        ; equal p7 p7
        ; equal pA pA
        ; equal pF pF
        ; equal p2 p2
        ; equal p1 p0
        ; equal pE pF
        ; equal pA p6
        ]
    in
    Alcotest.(check @@ list bool) "should be equal" expected computed)
;;

let test_some_char_projection =
  Alcotest.test_case "some char projection" `Quick (fun () ->
    let expected =
      Lib.Stat.Point.
        [ Some p0
        ; Some p1
        ; Some p2
        ; Some p3
        ; Some p4
        ; Some p5
        ; Some p6
        ; Some p7
        ; Some p8
        ; Some p9
        ; Some pA
        ; Some pA
        ; Some pB
        ; Some pB
        ; Some pC
        ; Some pC
        ; Some pD
        ; Some pD
        ; Some pE
        ; Some pE
        ; Some pF
        ; Some pF
        ; None
        ; None
        ]
    and computed =
      Lib.Stat.Point.
        [ from_char '0'
        ; from_char '1'
        ; from_char '2'
        ; from_char '3'
        ; from_char '4'
        ; from_char '5'
        ; from_char '6'
        ; from_char '7'
        ; from_char '8'
        ; from_char '9'
        ; from_char 'a'
        ; from_char 'A'
        ; from_char 'b'
        ; from_char 'B'
        ; from_char 'c'
        ; from_char 'C'
        ; from_char 'd'
        ; from_char 'D'
        ; from_char 'e'
        ; from_char 'E'
        ; from_char 'f'
        ; from_char 'F'
        ; from_char 'x'
        ; from_char '@'
        ]
    in
    Alcotest.(check @@ list (option Test_util.point_testable))
      "should be equal"
      expected
      computed)
;;

let test_some_int_projection =
  Alcotest.test_case "some int projection" `Quick (fun () ->
    let expected =
      Lib.Stat.Point.
        [ Some p0
        ; Some p1
        ; Some p2
        ; Some p3
        ; Some p4
        ; Some p5
        ; Some p6
        ; Some p7
        ; Some p8
        ; Some p9
        ; Some pA
        ; Some pB
        ; Some pC
        ; Some pD
        ; Some pE
        ; Some pF
        ; None
        ; None
        ; None
        ]
    and computed =
      Lib.Stat.Point.
        [ from_int 0
        ; from_int 1
        ; from_int 2
        ; from_int 3
        ; from_int 4
        ; from_int 5
        ; from_int 6
        ; from_int 7
        ; from_int 8
        ; from_int 9
        ; from_int 10
        ; from_int 11
        ; from_int 12
        ; from_int 13
        ; from_int 14
        ; from_int 15
        ; from_int 16
        ; from_int (-4)
        ; from_int 22
        ]
    in
    Alcotest.(check @@ list (option Test_util.point_testable))
      "should be equal"
      expected
      computed)
;;

let test_some_point_projection =
  Alcotest.test_case "some point to int projection" `Quick (fun () ->
    let computed =
      Lib.Stat.Point.(
        [ p0; p1; p2; p3; p4; p5; p6; p7; p8; p9; pA; pB; pC; pD; pE; pF ]
        |> List.map to_int)
    and expected = List.init 16 (fun i -> i) in
    Alcotest.(check @@ list int) "should be equal" expected computed)
;;

let test_some_point_char_projection =
  Alcotest.test_case "some point to char projection" `Quick (fun () ->
    let computed =
      Lib.Stat.Point.(
        [ p0; p1; p2; p3; p4; p5; p6; p7; p8; p9; pA; pB; pC; pD; pE; pF ]
        |> List.map to_char)
    and expected =
      [ '0'
      ; '1'
      ; '2'
      ; '3'
      ; '4'
      ; '5'
      ; '6'
      ; '7'
      ; '8'
      ; '9'
      ; 'A'
      ; 'B'
      ; 'C'
      ; 'D'
      ; 'E'
      ; 'F'
      ]
    in
    Alcotest.(check @@ list char) "should be equal" expected computed)
;;

let test_bound_computation =
  Alcotest.test_case "some point to int projection" `Quick (fun () ->
    let computed =
      Lib.Stat.Point.(
        [ p0; p1; p2; p3; p4; p5; p6; p7; p8; p9; pA; pB; pC; pD; pE; pF ]
        |> List.map (fun p -> min_bound p, max_bound p))
    and expected =
      [ 0, 15
      ; 16, 31
      ; 32, 47
      ; 48, 63
      ; 64, 79
      ; 80, 95
      ; 96, 111
      ; 112, 127
      ; 128, 143
      ; 144, 159
      ; 160, 175
      ; 176, 191
      ; 192, 207
      ; 208, 223
      ; 224, 239
      ; 240, 255
      ]
    in
    Alcotest.(check @@ list (pair int int)) "should be equal" expected computed)
;;

let test_get_smaller =
  Alcotest.test_case "get the smallest point" `Quick (fun () ->
    let expected = Lib.Stat.Point.[ p0; p0; pA; p9 ]
    and computed =
      Lib.Stat.Point.
        [ get_smaller p0 p1
        ; get_smaller p3 p0
        ; get_smaller pA pF
        ; get_smaller pD p9
        ]
    in
    Alcotest.(check @@ list Test_util.point_testable)
      "should be equal"
      expected
      computed)
;;

let cases =
  ( "Lib.Stat.Point"
  , [ test_some_equalities
    ; test_some_char_projection
    ; test_some_int_projection
    ; test_some_point_projection
    ; test_some_point_char_projection
    ; test_bound_computation
    ; test_get_smaller
    ] )
;;
