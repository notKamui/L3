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
let circle_area r =
    let pi = acos(-1.) in
        pi *. r**2.;;

circle_area 3.;;

(*2*)
let cylinder_members r h =
    let pi = acos(-1.) in
    let p = 2. *. pi *. r in
    let d = pi *. r**2. in
    let a = 2. *. d +. p *. h and v = d *. h in
        (p, a, v);;

cylinder_members 2. 3.;;

(*Exercice 3*)

(*1*)

let a = 1 in a + 2;;
(*a + 3;;*) (*On ne peut pas faire ca car a n'est lié a rien ici, l'expression ci dessus est une valeur, pas une globale*)

let b = 5;;
let b = 5.5;; (*On peut tout a fait redéfinir une liaison*)

let c = 1;;
let d = c;;
c + d;; (*Puisque c est lié une valeur, on peut lier d à cette valeur sans problème*)

let e = 1 let f = e;; (*On peut voir ca comme deux lignes distinctes*)

(*let g = 1 and h = g;;*) (*On ne peut pas faire ca, car les deux liaisons doivent être simultanées, or g n'existe pas encore*)

(*let a = 1 in let b = a;;*) (*Aucune valeur de "retour"*)

let a = 1 in let b = a in b;; (*Good, c'est celle d'au dessus "corrigée"*)

(*2*)

let a = 1;; (*liaison de 1 à a*)
let a = 1.2 in a;; (*pas de liaison globale, on écrase pas a -> valeur 1.2*)
a;; (*affiche la valeur de a (global) -> 1*)

let a = 1 in (*pas de liaison globale, mais l'expression vaut 3 car*)
    let a = 2 and b = a in (*le a local est écrasé ici, mais est simultanément lié à b*)
        a + b;; (*donc ici a=2 et b=1*)

(*Exercice 4*)

(*1*)

let max a b =
    if a > b then a else b;;

max 8 5;;

(*2*)

let min_3 a b c =
    let tmpmin = if a < b then a else b in
    if tmpmin < c then tmpmin else c;;

min_3 4 6 2;;

(*3*)

(*if a mod 2 = 0 then a else "odd";;*) (*ne peut pas marcher car si a est une string, alors on ne peut pas mod, et si a est un int, alors "odd" ne peut pas être un retour valide puisque l'expression doit être un int*)

(*4*)

(*if a < 10 then let b = "small" else let b = "large";;*) (*let b = ? n'est pas une valeur, donc c'est une erreur de syntaxe, et de toute facon ce serait vouloir faire une sorte de liaison interne, ce qui n'est pas voulu ici*)

let b = if a < 10 then "small" else "large";;

(*5*)

let b = if a < 0 then (-a)/2 else a/2;;

(*6*)

let min = if a < b then a else b in
    min*min + (if c mod 3 = 0 then 1 else 0);;

