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

  let get_smaller a b = if compare a b > 0 then b else a
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

  let from_char = function
    | 'P' | 'p' -> Some P
    | 'M' | 'm' -> Some M
    | 'X' | 'x' -> Some X
    | 'A' | 'a' -> Some A
    | _ -> None
  ;;

  let to_char = function
    | P -> 'P'
    | M -> 'M'
    | X -> 'X'
    | A -> 'A'
  ;;

  let pp ppf x =
    let chr = to_char x in
    Format.pp_print_char ppf chr
  ;;
end

type t =
  { kind : Kind.t
  ; attack : Point.t
  ; physical_defense : Point.t
  ; magical_defense : Point.t
  }
[@@deriving eq]

let pp ppf { kind; attack; physical_defense; magical_defense } =
  Format.fprintf
    ppf
    "%a%a%a%a"
    Point.pp
    attack
    Kind.pp
    kind
    Point.pp
    physical_defense
    Point.pp
    magical_defense
;;

let make ~kind ~attack ~physical_defense ~magical_defense =
  { kind; attack; physical_defense; magical_defense }
;;

let mk attack kind physical_defense magical_defense =
  make ~kind ~attack ~physical_defense ~magical_defense
;;

open struct
  let ( let* ) = Option.bind
end

let from_string str =
  if Int.equal (String.length str) 4
  then
    let* attack = Point.from_char str.[0] in
    let* kind = Kind.from_char str.[1] in
    let* physical_defense = Point.from_char str.[2] in
    let* magical_defense = Point.from_char str.[3] in
    Option.some @@ make ~kind ~attack ~physical_defense ~magical_defense
  else None
;;

let pick_target
  ~attacker:{ kind; _ }
  ~defender:{ attack; physical_defense; magical_defense; _ }
  =
  match kind with
  | Kind.P -> physical_defense
  | Kind.M -> magical_defense
  | Kind.X -> Point.get_smaller physical_defense magical_defense
  | Kind.A ->
    Point.get_smaller physical_defense magical_defense
    |> Point.get_smaller attack
;;

let pessimistic_probability ~attacker ~defender =
  let target = pick_target ~attacker ~defender in
  let attack = Point.min_bound attacker.attack |> Float.of_int in
  let defend = Point.max_bound target |> Float.of_int in
  let a, b, need_reverse =
    if attack > defend then defend, attack, false else attack, defend, true
  in
  let x = 2.0 *. (1.0 +. b)
  and y = 1.0 +. a in
  let r = 100.0 *. ((x -. y) /. x) in
  let r = if need_reverse then 100.0 -. r else r in
  Float.round (r *. 100.) /. 100.
;;
