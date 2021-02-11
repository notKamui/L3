(*1*)

let average a b c =
    (a + b + c) / 3;;

average 5 3 9;; (*ne peut pas être appelé avec des float car opérateur + pas pour les float*)

(*2*)

let implies a b =
    if a = false
        then true
        else if b = true
            then true
            else false;;

implies true true;; (*doit etre true*)
implies true false;; (*doit etre false*)
implies false true;; (*doit etre true*)
implies false false;; (*doit etre true*)

(*3*)

let inv (a, b) =
    (b, a);;

inv (2, "a");;

let inv couple =
    (snd couple, fst couple);;

inv (2, "a");;

(*4*)

let inv ((a, b): int*int) =
    (b, a);;

inv (2, 4);;

(*5*)

let f_one () = 1;;

f_one() + 2;;

(*6*)

let m = 3;; (*liaison m: int = 3*)
let f x = x;; (*fonction f qui prend un x et renvoi x (type any)*)
let g x = x + m;; (*fonction f qui prend un x et renvoi x+3 (pas m), x est int car 3 est int*)
f 4;; (*valeur 4*)
g 4;; (*valeur 7*)
let m = 5;; (*liaison m: int = 5*)
g 4;; (*valeur 7 (4+3)*)
f m;; (*valeur 5*)
