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
    let expected = [ true; true; true; true; false; false; false ]
    and computed =
      Lib.Stat.Kind.
        [ equal p p
        ; equal m m
        ; equal x x
        ; equal a a
        ; equal x a
        ; equal m p
        ; equal m x
        ]
    in
    Alcotest.(check @@ list bool) "should be equal" expected computed)
;;

let test_from_char =
  Alcotest.test_case "some char projection" `Quick (fun () ->
    let expected =
      Lib.Stat.Kind.
        [ Some p; Some p; Some m; Some m; Some x; Some x; Some a; Some a ]
    and computed =
      Lib.Stat.Kind.
        [ from_char 'p'
        ; from_char 'P'
        ; from_char 'm'
        ; from_char 'M'
        ; from_char 'x'
        ; from_char 'X'
        ; from_char 'a'
        ; from_char 'A'
        ]
    in
    Alcotest.(check @@ list (option Test_util.kind_testable))
      "should be equal"
      expected
      computed)
;;

let test_to_char =
  Alcotest.test_case "some to char projection" `Quick (fun () ->
    let expected = [ 'P'; 'M'; 'X'; 'A' ]
    and computed =
      Lib.Stat.Kind.[ to_char p; to_char m; to_char x; to_char a ]
    in
    Alcotest.(check @@ list char) "should be equal" expected computed)
;;

let cases =
  "Lib.Stat.Kind", [ test_some_equalities; test_from_char; test_to_char ]
;;
