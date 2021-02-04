(* Jimmy TEILLARD TP1: Programmation Fonctionnelle *)

(* Exercice 1 *)

(*1*)
33;; (* On ne peut pas utiliser les flèches dans le REPL par défaut *)

(*2*)
33;; (* On peut maintenant utiliser les flèches grace à rlwrap *)
(* Le top level donne l'état de l'enironnement ainsi que des choses déclarées *)

(*3*)
2;; (*int*)
2.0;; (*float*)
2,0;; (*(int*int) -> paire d'int*)
2;0;; (*Warning 10: this expression should have type unit. - : int = 0*)
(2, 0);; (*(int*int) -> paire d'int*)
(2; 0);; (*Warning 10: this expression should have type unit.- : int = 0*)
(*a;;*) (*Error: Unbound value a*)
'a';; (*char*)
"a";; (*string*)
true;; (*bool*)
();; (*unit*)
[];; (*'a list -> list vide ?*) (*???*)
[1];; (*int list*)
[1,true];; (*(int*bool) list -> list de paires(int, bool)*)
(*[1;true];;*) (*Erreur de type*)

(*4*)
(2, 2.1);; (*int * float*)
(*(int,float) -> pas possible ?*)
["baba"; "bobo"];; (*string list*)
([true; false], "bibi");; (*bool list * string*)
(*'a * int -> pas possible ?*)
[[1;2];[3;4;5]];; (*int list list*)

(*5*)
1+2;; (*int = 3*)
(*1.1 + 2.2;;*) (*addition int alors que floats*)
(*1.1 + 2;;*) (*addition int alors que left est float*)
2/3;; (*int = 0*)
7 mod 2;; (*int = 1*)
(*7. mod 3.;;*) (*modulo entier impossible sur floats*)
int_of_float (2. ** 3.);; (*int = 8*)
2 = 3;; (*bool = false*)
'a' = 'b';; (*bool = false*)
(*"a" = 'a';;*) (*comparation de types différents*)
(*not 1 = 0;;*) (*impossible parce que 'not' a une précédence plus forte que '='*)
not (1 = 0);; (*bool = true*)

(*6*)
0 = 0 && true;; (*&& lazy, précédence faible*)

(*Exercice 2*)

(*1*)
let rec circle_area r =
    let pi = acos(-1.) in
        pi *. r**2.;;

circle_area 3.;;

(*2*)
let rec cylinder_members r h =
    let pi = acos(-1.) in
    let p = 2. *. pi *. r in
    let d = pi *. r**2. in
    let a = 2. *. d +. p *. h and v = d *. h in
        (p, a, v);;

cylinder_members 2. 3.;;

