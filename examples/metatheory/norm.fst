
module Norm

open Prims
open Stlc

(* XXX both multi and red require the --full_context_dependency flag XXX 
   Compile this file with:
   ../../bin/fstar.exe --fstar_home ../.. stlc.fst norm.fst --full_context_dependency
*)

(* Reflexive-transitive closure of step *)

kind Relation (a:Type) = a -> a -> Type

(* CH: needed to unfold the definition of Relation to make this work;
   for failed attempts to define this see below *)
type multi (a:Type) (r:(a -> a -> Type)) : a -> a -> Type =
  | Multi_refl : x:a -> multi a r x x
  | Multi_step : x:a -> y:a -> z:a -> r x y -> multi a r y z -> multi a r x z

(*
Kinds "(_:a -> _:a -> Type)" and "Type" are incompatible

type multi (a:Type) (r:Relation a) : Relation a =
  | Multi_refl : x:a -> multi a r x x
  | Multi_step : x:a -> y:a -> z:a -> r x y -> multi a r y z -> multi a r x z

same error below (non-uniform args):
Kinds "(_:'a -> _:'a -> Type)" and "Type" are incompatible

type multi : 'a:Type -> ('a -> 'a -> Type) -> 'a -> 'a -> Type =
  | Multi_refl : x:'a -> r:('a -> 'a -> Type) -> multi r x x
  | Multi_step : x:'a -> y:'a -> z:'a -> r:('a -> 'a -> Type) -> r x y -> multi r y z -> multi r x z
*)

assume val multi_refl : #a:Type -> x:a -> r:Relation a -> Lemma (multi a r x x)

type step_rel (e:exp) (e':exp) : Type = step e == Some e'

type steps : exp -> exp -> Type = multi exp step_rel

type halts (e:exp) : Type = (exists (e':exp). (steps e e' /\ is_value e'))

val value_halts : v:exp ->
  Lemma (requires (is_value v))
        (ensures (halts v))
let value_halts v =
  multi_refl v step_rel

(* This has a negative occurrence of R that makes Coq succumb,
   although this definition is just fine (the type decreases);
   F* should have similar problems as soon as we start checking
   for negative occurrences. *)
type red : ty -> exp -> Type =
  | R_bool : e:exp{typing empty e = Some TBool /\ halts e} -> red TBool e
  | R_arrow : t1:ty -> t2:ty
               -> e:exp{typing empty e = Some (TArrow t1 t2) /\ halts e}
               -> (e':exp -> red t1 e' -> Tot (red t2 (EApp e e')))
               -> red (TArrow t1 t2) e

(* My original attempt -- red' called recursively only in refinement *)
type red' : ty -> exp -> Type =
  | R_bool' : e:exp{typing empty e = Some TBool /\ halts e} -> red' TBool e
  | R_arrow' : e:exp -> t1:ty -> t2:ty{typing empty e = Some (TArrow t1 t2)
      /\ halts e /\ (forall (e':exp). red' t1 e' ==> red' t2 (EApp e e'))} ->
      red' (TArrow t1 t2) e

(* In Coq we define R/red by recursion on the type,
   we don't have fixpoints in Type in F* though (see mailing list discussion)
The type of R is
val R : ty -> exp -> Type
*)
(*
Fixpoint R (T:ty) (t:tm) {struct T} : Prop :=
  has_type empty t T /\ halts t /\
  (match T with
   | TBool  => True
   | TArrow T1 T2 => (forall s, R T1 s -> R T2 (tapp t s))
   | TProd T1 T2 => (R T1 (tfst t)) /\ (R T2 (tsnd t)) 
   end).
*)