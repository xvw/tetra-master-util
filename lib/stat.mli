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

(** Describes map statistics and provides simulation, pretty-printing and comparison
    tools.

    Card statistics are described by 4 digits [1234].

    + Describes a card's attack points (represented by data of type
      {!type:Point.t})
    + Describes a card's type (can be [P], [M], [X], or [A], represented by
      {!type:Kind.t})
    + Describes a card's physical defense (represented by data of type
      {!type:Point.t})
    + Describes a card's magical defense (represented by data of type
      {!type:Point.t}) *)

(** Describes a complete set of statistics. *)
type t

(** {1 Elements of statistics} *)

module Point : sig
  (** Describes a point of attack or defense, and a value between [0 and 15] (in
      hexadecimal). *)

  (** The type describing a point of attack or defense. *)
  type t

  (** Constructors for {!type:t} values.

      We keep the type abstract and use functional constructors if the
      implementation'll change *)

  val p0 : t
  val p1 : t
  val p2 : t
  val p3 : t
  val p4 : t
  val p5 : t
  val p6 : t
  val p7 : t
  val p8 : t
  val p9 : t
  val pA : t
  val pB : t
  val pC : t
  val pD : t
  val pE : t
  val pF : t

  (** [equal x y] returns [true] if [x] and [y] are equal, [false] otherwise. *)
  val equal : t -> t -> bool

  (** [compare x y] returns an integer greather than [0] if [x > y], an integer
      lower than [0] if [x < y] and [0] if [x = y]. *)
  val compare : t -> t -> int

  (** pretty-printers for {!type:t}. *)
  val pp : Format.formatter -> t -> unit

  (** [from_char c] try to build a value of type {!type:t}, if the char is not
      valid it returns [None]. *)
  val from_char : char -> t option

  (** [from_int c] try to build a value of type {!type:t}, if the int is not
      valid ([int >= 0 && int <= 15]) it returns [None]. *)
  val from_int : int -> t option

  (** [to_int p] transforms a point to an integer [int >= 0 && int <= 15]. *)
  val to_int : t -> int

  (** [to_char p] transforms a point to the related char. *)
  val to_char : t -> char

  (** [min_bound p] returns the minimal potential value bounded in a point. *)
  val min_bound : t -> int

  (** [min_max p] returns the maximal potential value bounded in a point. *)
  val max_bound : t -> int

  (** [get_smaller p1 p2] returns the smaller of the two points. *)
  val get_smaller : t -> t -> t
end

module Kind : sig
  (** Describe the type of card (physical, magic, flexible, assault/advanced). *)

  type t

  (** Constructors for {!type:t} values.

      We keep the type abstract and use functional constructors if the
      implementation'll change *)

  val p : t
  val m : t
  val x : t
  val a : t

  (** [equal x y] returns [true] if [x] and [y] are equal, [false] otherwise. *)
  val equal : t -> t -> bool

  (** [compare x y] returns an integer greather than [0] if [x > y], an integer
      lower than [0] if [x < y] and [0] if [x = y]. *)
  val compare : t -> t -> int

  (** pretty-printers for {!type:t}. *)
  val pp : Format.formatter -> t -> unit

  (** [from_char c] try to build a value of type {!type:t}, if the char is not
      valid it returns [None]. *)
  val from_char : char -> t option

  (** [to_char p] transforms a kind to the related char. *)
  val to_char : t -> char
end

(** {1 Working with statistics} *)

(** [make ~kind ~attack ~physical_defense ~magical_defense] creates a complete
    statistic point. *)
val make
  :  kind:Kind.t
  -> attack:Point.t
  -> physical_defense:Point.t
  -> magical_defense:Point.t
  -> t

(** [mk a k p m] is a shortcut for [make]. *)
val mk : Point.t -> Kind.t -> Point.t -> Point.t -> t

(** [pick_target ~attacker ~defender] will return the statistic targeted by the
    attacker to the defender. As the software doesn't take real points into
    account, it only uses offsets to define the target. *)
val pick_target : attacker:t -> defender:t -> Point.t

(** [pessimistic_probability ~attacker ~defender] returns the pessimistic
    probability of the attacker's card winning over the opponent.

    We call them pessimistic probabilities because, as the simulator doesn't
    take into account the real points on the map (which change according to the
    number of games played and are approximately unreadable from a game), we
    take the lowest statistic in the range for the attacker and the highest for
    the opponent. *)
val pessimistic_probability : attacker:t -> defender:t -> float

(** [from_string str] try to build from the format HKHH a full set of stats. *)
val from_string : string -> t option

(** [equal x y] returns [true] if [x] and [y] are equal, [false] otherwise. *)
val equal : t -> t -> bool

(** pretty-printers for {!type:t}. *)
val pp : Format.formatter -> t -> unit
