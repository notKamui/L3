(* Exercice 1 *)

(*1*)
let rec integers_1 n =
    if n < 0 then [] 
    else n :: integers_1 (n - 1);;

integers_1 5;; (* n downTo 0 *)

(*2*)
let rec integers_2 n =
    if n < 0 then [] 
    else integers_2 (n - 1) @ [n] ;;

integers_2 5;;
(*integers_2 100_000;; (* BEAUCOUP TROP LONG *)*)

(*3*)
let integers_3 n =
    let rec aux n =
        if n < 0 then [] 
        else n :: aux (n - 1)
    in List.rev (aux n);;

integers_3 5;;
integers_3 100_000;; (* mmmm juicy instant *)

(*4*)
let integers_4 n =
    let rec aux n acc =
        if n < 0 then acc
        else aux (n-1) (n :: acc)
    in aux n [];;

integers_4 5;; (*Elle est dans le bon sens, sans besoin d'inversion*)

(* Exercice 2 *)
exception Empty_list;;

let three_or_more l =
    let rec aux l count =
        if count = 0 then true
        else if l = [] then false
        else aux (List.tl l) (count-1)
    in aux l 3;;

three_or_more;; (*'a list -> bool*)
three_or_more [0; 1; 2];;
three_or_more [0; 1; 2; 3];;
three_or_more [0; 1];;
three_or_more [0];;
three_or_more [];;

let size l =
    let rec aux l s =
        if l = [] then s
        else aux (List.tl l) (s+1)
    in aux l 0;;

size;; (*'a list -> int*)
size [0; 1];;
size [];;
size [0; 1; 2; 3];;

let last l =
    if l = [] then raise Empty_list
    else
        let rec aux l =
            if (List.tl l) = [] then (List.hd l)
            else aux (List.tl l)
        in aux l;;

last;; (*'a list -> int*)
(*last [];;*)
last [0; 1; 2; 3];;
last [0; 1];;

let is_increasing l =
    if l = [] then true
    else 
        let rec aux l prev =
            if (List.hd l) < prev then false
            else if (List.tl l) = [] then true
            else aux (List.tl l) (List.hd l)
        in aux (List.tl l) (List.hd l);;

is_increasing;; (*'a list -> bool*)
is_increasing [];;
is_increasing [0; 1; 1; 4; 10];;
is_increasing [0; 1; 4; 2; 7];;

let even_odd l =
    let rec aux l even =
        if l = [] then
            true
        else 
            if ((List.hd l) mod 2 = 0) != even then
                false
            else 
                aux (List.tl l) (not even)
    in aux l false;; 

even_odd;; (*'a list -> bool*)
even_odd [];;
even_odd [1; 4; 5; 10];;
even_odd [1; 4; 6; 10];;

let rec find e l =
    if l = [] then false
    else if (List.hd l) = e then true
    else find e (List.tl l);;

find;; (*'a list -> bool*)
find 2 [0; 3; 2; 5];;
find 10 [0; 3; 2; 5];;

let rec member e l =
    if l = [] then []
    else if (List.hd l) = e then l
    else member e (List.tl l);;

member;; (*'a list -> a' list*)
member 2 [0; 3; 2; 5];;
member 10 [0; 3; 2; 5];;

let rec member_last e l =
    if l = [] then []
    else if (List.hd l) = e && (not (find e (List.tl l))) then l
    else member e (List.tl l);;

member_last;; (*'a list -> a' list*)
member 2 [0; 3; 2; 5; 5; 2; 10];;
member 10 [0; 3; 2; 5];;

let nb_occ e l =
    let rec aux l count =
        if l = [] then count
        else 
            let i = if (List.hd l) = e then 1 else 0 in
            aux (List.tl l) (count+i)
    in aux l 0;;

nb_occ;; (*'a list -> int*)
nb_occ 2 [0; 3; 2; 5; 2; 5; 2; 10];;

let nth n l =
    let rec aux l i =
        if i = n then List.hd l
        else aux (List.tl l) (i+1)
    in aux l 0;;

nth;; (*'a list -> 'a*)
nth 2 [0; 3; 8; 5; 2; 6; 2; 10];;
nth 5 [0; 3; 8; 5; 2; 6; 2; 10];;

let max_list l =
    if l = [] then raise Empty_list
    else
        let rec aux l m =
            if l = [] then m
            else aux (List.tl l) (max m (List.hd l))
        in aux (List.tl l) (List.hd l);;

max_list;; (*int list -> int*)
max_list [0; 3; 8; 5; 2; 6; 2];;
max_list [3; 8; 5; 2; 6; 2; 10];;

let nb_max l =
    if l = [] then raise Empty_list
    else
        let rec aux l m count =
            if l = [] then count
            else aux (List.tl l) (max m (List.hd l)) (if m > (List.hd l) then count+1 else 1)
        in aux (List.tl l) (List.hd l) 1;;

nb_max;; (*'a list -> int*)
nb_max [0; 3; 8; 5; 2; 8; 6; 2];;
nb_max [3; 8; 5; 10; 10; 2; 6; 2; 10];;

let average l =
    if l = [] then raise Empty_list
    else
        let rec aux l sum =
            if l = [] then sum
            else aux (List.tl l) (sum +. (List.hd l))
        in (aux (List.tl l) (List.hd l)) /. (float_of_int (size l)) ;;

average;; (*float list -> float*)
average [0.; 3.; 8.; 5.; 2.; 8.; 6.; 2.];;
average [3.; 8.; 5.; 10.; 10.; 2.; 6.; 2.; 10.];;

(* Exercice 3 *)