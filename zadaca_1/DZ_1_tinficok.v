Set Implicit Arguments.
Require Import List.
Import ListNotations.
(* Require Import Omega. *) (*ne dopusta pa sam zakomentirao*)

(*ovo sam ja dodao*)
Require Import Bool.
Require Import Lia.



(* Zd 1a *)
Goal forall (x y : bool),
  (x && (negb y)) || ((negb x) && (negb y)) || ((negb x) && y) = negb (x && y).
Proof.
intros. destruct x, y; simpl; reflexivity.
(*
- reflexivity.
- reflexivity.
- reflexivity.
- reflexivity.
*)
Qed.


(* Zd 1b *)
Goal forall (x y z : bool),
  negb ((negb x) && y && z) && negb (x && y && (negb z)) && (x && (negb y) && z)
  = x && (negb y) && z.
Proof.
intros. destruct x, y, z; simpl; reflexivity.
(*
- reflexivity
...
*)
Qed.


(* Bit *)

Inductive B : Type :=
  | O : B
  | I : B.

Definition And (x y : B) : B :=
match x with
  | O => O
  | I => y
end.

Definition Or (x y : B) : B :=
match x with
  | O => y
  | I => I
end.

Definition Not (x : B) : B :=
match x with
  | O => I
  | I => O
end.

Definition Add (x y c : B) : B :=
match x, y with
  | O, O => c
  | I, I => c
  | _, _ => Not c
end.

Definition Rem (x y c : B) : B :=
match x, y with
  | O, O => O
  | I, I => I
  | _, _ => c
end.

(* List *)

Fixpoint AndL (x y : list B) : list B :=
match x, y with
| [], _ => []
| _, [] => []
| x :: xs, y :: ys => And x y :: AndL xs ys
end.

Fixpoint OrL (x y : list B) : list B :=
match x, y with
| [], _ => []
| _, [] => []
| x :: xs, y :: ys => Or x y :: OrL xs ys
end.

Fixpoint NotL (x : list B) : list B :=
match x with
  | [] => []
  | x :: xs => Not x :: NotL xs
end.

Fixpoint AddLr (x y : list B) (c : B) : list B :=
match x, y with
| [], _ => []
| _, [] => []
| x :: xs, y :: ys => Add x y c :: AddLr xs ys (Rem x y c)
end.

Definition AddL (x y : list B) : list B := rev (AddLr (rev x) (rev y) O).

Fixpoint IncLr (x : list B) (c : B) : list B :=
match x with
| [] => []
| x :: xs => Add x I c :: IncLr xs (Rem x I c)
end.

Definition IncL (x : list B) : list B := rev (IncLr (rev x) O).

(* ALU *)

Definition flag_zx (f : B) (x : list B) : list B :=
match f with
| I => repeat O (length x)
| O => x
end.

Definition flag_nx (f : B) (x : list B) : list B :=
match f with
| I => NotL x
| O => x
end.

Definition flag_f (f : B) (x y : list B) : list B :=
match f with
| I => AddL x y
| O => AndL x y
end.

Definition ALU (x y : list B) (zx nx zy ny f no : B) : list B := 
  flag_nx no (flag_f f (flag_nx nx (flag_zx zx x)) (flag_nx ny (flag_zx zy y))).


(* Teoremi *)

Lemma ALU_zero (x y : list B) :
  length x = length y -> ALU x y I O I O I O = repeat O (length x).
Proof. Abort.

Lemma ALU_minus_one (x y : list B) : 
  length x = length y -> ALU x y I I I O I O = repeat I (length x).
Proof. Abort.

Lemma ALU_x (x y : list B) : 
  length x = length y -> ALU x y O O I I O O = x.
Proof. Abort.

Lemma ALU_y (x y : list B) : 
  length x = length y -> ALU x y I I O O O O = y.
Proof. Abort.

Lemma ALU_Not_x (x y : list B) : 
  length x = length y -> ALU x y O O I I O I = NotL x.
Proof. Abort.

Lemma ALU_Not_y (x y : list B) : 
  length x = length y -> ALU x y I I O O O I = NotL y.
Proof. Abort.

Lemma ALU_Add (x y : list B) : 
  length x = length y -> ALU x y O O O O I O = AddL x y.
Proof. Abort.

Lemma ALU_And (x y : list B) : 
  length x = length y -> ALU x y O O O O O O = AndL x y.
Proof. Admitted.

Lemma ALU_Or (x y : list B) : 
  length x = length y -> ALU x y O I O I O I = OrL x y.
Proof. Admitted.

(* DZ *) (* 4zd *)

Lemma ALU_One (n : nat) (x y : list B) :
  length x = n /\ length y = n /\ n <> 0 -> ALU x y I I I I I I = repeat O (pred n) ++ [I].
Proof.
intros. destruct H. destruct H0.
assert(len_x_y: length x = length y).
{
 now rewrite H, H0. 
}
simpl. rewrite len_x_y.
assert(NotL_rep: forall n, NotL (repeat O n) = repeat I n).
{
induction n0.
- now simpl.
- simpl. rewrite IHn0. reflexivity.
}
rewrite NotL_rep.
assert(AddL_rep: forall n, AddL (repeat I n) (repeat I n) = repeat O n ++ [I]).
{
induction n; destruct n.
- simpl. contradiction.
- now simpl.
- apply IHn.
+ rewrite H.  (*rewrite H1.*) (*tu sam zapeo*)

(*
induction n; simpl.
- now simpl.
- destruct n0.
-- apply IHn.
--- 


- assert(rep_I: forall n, repeat I n ++ [I] = I :: repeat I n).
  {
  induction n.
  - now simpl.
  - simpl. rewrite IHn. reflexivity.
  }
*)
}
Abort.







