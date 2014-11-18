module Prims : sig
  (* Fix this... *)
  type double  = float
  type uint16 = int
  type int32 = int

  type byte = char
  type uint8 = char
  val ignore : 'a -> unit
  val fst : 'a * 'b -> 'a
  val snd : 'a * 'b -> 'b
  val failwith : string -> 'a
  val try_with : (unit -> 'a) -> (exn -> 'a) -> 'a
end


module ST : sig
  val read : 'a ref -> 'a
end


module String : sig
  val strcat : string -> string -> string
  val split : char list -> string -> string list
  val compare : string -> string -> Prims.int32
  val concat : string -> string list -> string
  val length : string -> int
end


module List : sig
  val hd : 'a list -> 'a
  val tl : 'a list -> 'a list
  val nth : 'a list -> int -> 'a
  val length : 'a list -> int
  val rev : 'a list -> 'a list
  val map : ('a -> 'b) -> 'a list -> 'b list
  val mapi : (int -> 'a -> 'b) -> 'a list -> 'b list
  val map2 : ('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list
  val map3 : ('a -> 'b -> 'c -> 'd) -> 'a list -> 'b list -> 'c list -> 'd list
  val iter : ('a -> unit) -> 'a list -> unit
  val partition : ('a -> bool) -> 'a list -> 'a list * 'a list
  val append : 'a list -> 'a list -> 'a list
  val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
  val fold_right : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b
  val collect : ('a -> 'b list) -> 'a list -> 'b list
  val unzip : ('a * 'b) list -> ('a list) * ('b list)
  val unzip3 : ('a * 'b * 'c) list -> ('a list) * ('b list) * ('c list)
  val filter : ('a -> bool) -> 'a list -> 'a list
  val sortWith : ('a -> 'a -> int) -> 'a list -> 'a list
  val forall2 : ('a -> 'b -> bool) -> 'a list -> 'b list -> bool
  val tryFind : ('a -> bool) -> 'a list -> 'a option
  val flatten : ('a list) list -> 'a list
  val split : ('a * 'b) list -> ('a list) * ('b list)
  val choose : ('a -> 'b option) -> 'a list -> 'b list
  val contains : 'a -> 'a list -> bool
end


module Option : sig
  val isSome : 'a option -> bool
  val isNone : 'a option -> bool
end


module Microsoft : sig
  module FStar : sig
    module Util : sig
      exception Impos
      exception NYI of string
      exception Failure of string
      val return_all: 'a -> 'a
      type 'a set = ('a list) * ('a -> 'a -> bool)
      val new_set: ('a -> 'a -> int) -> ('a -> int) -> 'a set
      val set_is_empty: 'a set -> bool
      val set_add: 'a -> 'a set -> 'a set
      val set_remove: 'a -> 'a set -> 'a set
      val set_mem: 'a -> 'a set -> bool
      val set_union: 'a set -> 'a set -> 'a set
      val set_intersect: 'a set -> 'a set -> 'a set
      val set_is_subset_of: 'a set -> 'a set -> bool
      val set_count: 'a set -> int
      val set_difference: 'a set -> 'a set -> 'a set
      val set_elements: 'a set -> 'a list
      type 'value smap = (string, 'value) BatHashtbl.t
      val smap_create: int -> 'value smap
      val smap_clear:'value smap -> unit
      val smap_add: 'value smap -> string -> 'value -> unit
      val smap_try_find: 'value smap -> string -> 'value option
      val smap_fold: 'value smap -> (string -> 'value -> 'a -> 'a) -> 'a -> 'a
      val smap_remove: 'value smap -> string -> unit
      val smap_keys: 'value smap -> string list
      val smap_copy: 'value smap -> 'value smap
      val format: string -> string list -> string
      val format1: string -> string -> string
      val format2: string -> string -> string -> string
      val format3: string -> string -> string -> string -> string
      val format4: string -> string -> string -> string -> string -> string
      val format5: string -> string -> string -> string -> string -> string -> string
      val fprint1: string -> string -> unit
      val fprint2: string -> string -> string -> unit
      val fprint3: string -> string -> string -> string -> unit
      val fprint4: string -> string -> string -> string -> string -> unit
      val fprint5: string -> string -> string -> string -> string -> string -> unit
      val print_string : string -> unit
      val print_any : 'a -> unit
      val strcat : string -> string -> string
      val concat_l : string -> string list -> string
      type file_handle = out_channel
      val open_file_for_writing: string -> file_handle
      val append_to_file: file_handle -> string -> unit
      val close_file: file_handle -> unit
      val write_file: string -> string -> unit
      val flush_file: file_handle -> unit
      type proc = unit (* FIXME *)
      val start_process: string -> string -> (string -> bool) -> proc
      val ask_process: proc -> string -> string
      val kill_process: proc -> unit
      val kill_all: unit -> unit
      val run_proc : string -> string -> string -> (bool * string * string)
      val write_JSON: 'a -> string -> unit
      val read_JSON: string -> 'a
      val get_file_extension: string -> string
      val int_of_string: string -> int
      val int_of_char: char -> int
      val char_of_int: int -> char
      val int_of_uint8: Prims.uint8 -> int
      val uint16_of_int: int -> Prims.uint16
      val float_of_byte: char -> float
      val float_of_int32: Prims.int32 -> float
      val float_of_int64: BatInt64.t -> float
      val string_of_int:   int -> string
      val string_of_float: float -> string
      val string_of_char:  char -> string
      val string_of_bytes: char array -> string
      val starts_with: string -> string -> bool
      val trim_string: string -> string
      val ends_with: string -> string -> bool
      val char_at: string -> int -> char
      val is_upper: char -> bool
      val substring_from: string -> int -> string
      val substring: string -> int -> int -> string
      val replace_char: string -> char -> char -> string
      val replace_string: string -> string -> string -> string
      val hashcode: string -> int
      val compare: string -> string -> int
      val splitlines: string -> string list
      val split: string -> string -> string list
      type ('a,'b) either =
        | Inl of 'a
        | Inr of 'b
      val left: ('a,'b) either -> 'a
      val right: ('a,'b) either -> 'b
      val find_dup: ('a -> 'a -> bool) -> 'a list -> 'a option
      val nodups: ('a -> 'a -> bool) -> 'a list -> bool
      val sort_with: ('a -> 'a -> int) -> 'a list -> 'a list
      val set_eq: ('a -> 'a -> int) -> 'a list -> 'a list -> bool
      val remove_dups: ('a -> 'a -> bool) -> 'a list -> 'a list
      val add_unique: ('a -> 'a -> bool) -> 'a -> 'a list -> 'a list
      val find_map: 'a list -> ('a -> 'b option) -> 'b option
      val fold_map: ('a -> 'b -> 'a * 'c) -> 'a -> 'b list -> 'a * ('c list)
      val choose_map: ('a -> 'b -> 'a * ('c option)) -> 'a -> 'b list -> 'a * ('c list)
      val for_all: ('a -> bool) -> 'a list -> bool
      val for_some: ('a -> bool) -> 'a list -> bool
      val forall_exists: ('a -> 'b -> bool) -> 'a list -> 'b list -> bool
      val multiset_equiv: ('a -> 'b -> bool) -> 'a list -> 'b list -> bool
      val is_some: 'a option -> bool
      val must: 'a option -> 'a
      val dflt: 'a -> 'a option -> 'a
      val find_opt: ('a -> bool) -> 'a list -> 'a option
      val bind_opt: 'a option -> ('a -> 'b option) -> 'b option
      val map_opt: 'a option -> ('a -> 'b) -> 'b option
      val first_N: int -> 'a list -> ('a list * 'a list)
      val nth_tail: int -> 'a list -> 'a list
      val prefix_until: ('a -> bool) -> 'a list -> ('a list * 'a * 'a list) option
      val prefix: 'a list -> ('a list * 'a)
      val string_of_unicode: char array -> string
      val unicode_of_string: string -> char array
      val incr: int ref -> unit
      val geq: int -> int -> bool
      val for_range: int -> int -> (int -> unit) -> unit
      type ('s,'a) state = 's -> 'a * 's
      val get: ('s,'s) state
      val put: 's -> ('s,unit) state
      val upd: ('s -> 's) -> ('s,unit) state
      val ret: 'a -> ('s,'a) state
      val bind: ('s,'a) state -> ('a -> ('s,'b) state) -> ('s,'b) state
      val stmap: 'a list -> ('a -> ('s,'b) state) -> ('s,'b list) state
      val stiter: 'a list -> ('a -> ('s,unit) state) -> ('s,unit) state
      val stfold: 'b -> 'a list -> ('b -> 'a -> ('s,'b) state) -> ('s,'b) state
      val run_st: 's -> ('s,'a) state -> ('a * 's)
      val mk_ref: 'a -> 'a ref
      val expand_environment_variable: string -> string
      val physical_equality: 'a -> 'a -> bool
      val check_sharing: 'a -> 'a -> string -> unit
    end
    module Unionfind : sig
      type 'a cell = {mutable contents : 'a contents}
       and 'a contents =
         | Data of 'a list * Prims.int32
         | Fwd of 'a cell
      type 'a uvar = 'a cell
      exception Impos
      val uvar_id : 'a uvar -> Prims.int32
      val find : 'a uvar -> 'a
      val change : 'a uvar -> 'a -> unit
      val equivalent : 'a uvar -> 'a uvar -> bool
      val fresh : 'a -> 'a uvar
    end
    module Platform : sig
      val exe : string -> string
    end
    module Getopt : sig
      val noshort : char
      type opt_variant =
        | ZeroArgs of (unit -> unit)
        | OneArg of (string -> unit) * string
    end
    module Range : sig
      type range = BatInt64.t
      type file_idx = Prims.int32
      type pos = Prims.int32
      val mk_pos: int -> int -> pos
      val mk_file_idx_range:file_idx -> int -> int -> range
      val mk_range: string -> int -> int -> range
      val encode_file:string -> string
      val decode_file_idx:string -> int
      val file_of_file_idx:file_idx -> string
      val union_ranges: range -> range -> range
      val string_of_range: range -> string
      val file_of_range: range -> string
      val string_of_pos: pos -> string
      val start_of_range: range -> pos
      val end_of_range: range -> pos
      val line_of_pos: pos -> int
      val end_range: range -> range
    end
    module Bytes : sig
      type bytes = (* abstract *)
          char array   (* except in F# *)
      val length : bytes -> int
      val get: bytes -> int -> int
      val zero_create : int -> bytes
      val of_intarray: int array -> bytes
      val string_as_unicode_bytes: string -> bytes
      val unicode_bytes_as_string: bytes -> string
      val utf8_bytes_as_string: bytes -> string
      val append: bytes -> bytes -> bytes
      val make: (int -> int) -> int -> bytes

      type bytebuf = (* abstract *)
          { mutable bbArray: bytes;  (* except in F# *)
            mutable bbCurrent: int }
      val create: int -> bytebuf
      val close : bytebuf -> bytes
      val emit_int_as_byte: bytebuf -> int -> unit
      val emit_bytes: bytebuf -> bytes -> unit
    end
    module Parser : sig
      module ParseIt : sig
        (* FIXME *)
        val parse_file: (string,string) Util.either -> ('a,string) Util.either
      end
    end
  end
end
