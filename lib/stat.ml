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

module Point = struct
  type t =
    | Zero
    | One
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | A
    | B
    | C
    | D
    | E
    | F
  [@@deriving eq, ord, enum]

  let p0 = Zero
  let p1 = One
  let p2 = Two
  let p3 = Three
  let p4 = Four
  let p5 = Five
  let p6 = Six
  let p7 = Seven
  let p8 = Eight
  let p9 = Nine
  let pA = A
  let pB = B
  let pC = C
  let pD = D
  let pE = E
  let pF = F

  let from_basis root offset c =
    let zero = Char.code root
    and code = Char.code c in
    of_enum (code - zero + offset)
  ;;

  let from_char = function
    | '0' .. '9' as c -> from_basis '0' 0 c
    | 'a' .. 'f' as c -> from_basis 'a' 10 c
    | 'A' .. 'F' as c -> from_basis 'A' 10 c
    | _ -> None
  ;;

  let from_int = of_enum
  let to_int = to_enum

  let to_char p =
    let i = to_enum p in
    if i < 10
    then Char.chr (Char.code '0' + i)
    else (
      let i = i - 10 in
      Char.chr (Char.code 'A' + i))
  ;;

  let pp ppf x =
    let chr = to_char x in
    Format.pp_print_char ppf chr
  ;;

  let min_bound p = to_int p * 16
  let max_bound p = min_bound p + 15

  let () =
    (* Sad runtime assertion to not export [min] and [max]. *)
    assert (min = 0 && max = 15)
  ;;
end

module Kind = struct
  type t =
    | P
    | M
    | X
    | A
  [@@deriving eq, ord]

  let p = P
  let m = M
  let x = X
  let a = A
end
