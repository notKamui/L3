(* TP2 CAML Jimmy Teillard *)

(* Exercice 1 *)
let rec fact (n: int) = match n with
      0 -> 1
    | 1 -> 1
    | _ -> n * fact(n-1);;

fact 6;;

(* Exercice 2 *)
let rec fib (n: int) = match n with
      0 -> 0
    | 1 -> 1
    | _ -> fib(n-1) + fib(n-2);;

fib 11;;

(* Exercice 3 *)
let rec pgcd m n =
    if m = 0 then
        n
    else if m > n then
        pgcd n m
    else
        pgcd (n mod m) m;;

pgcd 20 30;;

(* Exercice 4 *)
let rec ackermann m n =
    if m = 0 then
        n + 1
    else if m >= 1 && n = 0 then
        ackermann (m-1) 1
    else if m >= 1 && n >= 1 then
        ackermann (m-1) (ackermann m (n-1))
    else 0;;

ackermann 0 1, ackermann 1 1, ackermann 2 1, ackermann 3 1;;

(* Exercice 5 *)
let rec binom n k =
    if k = 0 then
        1
    else if n < k then
        0
    else 
        (binom (n-1) (k-1)) + (binom (n-1) k);;

let binom2 n k = (fact n) / ((fact k) * fact (n-k));;

binom 4 0, binom 4 1, binom 4 2, binom 4 3, binom 4 4;;
binom2 4 0, binom2 4 1, binom2 4 2, binom2 4 3, binom2 4 4;;

binom 0 0 = binom2 0 0 &&
binom 1 0 = binom2 1 0 &&
binom 2 0 = binom2 2 0 &&
binom 3 0 = binom2 3 0 &&
binom 1 1 = binom2 1 1 &&
binom 2 1 = binom2 2 1 &&
binom 3 1 = binom2 3 1 &&
binom 2 2 = binom2 2 2 &&
binom 3 2 = binom2 3 2 &&
binom 3 3 = binom2 3 3 ;;

(* Exercice 6 *)

let rec is_even n = n = 0 || is_odd (n-1)
and is_odd n = n != 0 && is_even (n-1);;

is_even 0, is_even 1, is_even 2, is_even 3, is_even 4, is_even 5;;
is_odd 0, is_odd 1, is_odd 2, is_odd 3, is_odd 4, is_odd 5;;

(* Exercice 7 *)

let fact' n =
    let rec fact n acc =
        if n <= 1 then acc
        else fact (n-1) (acc*n)
    in fact n 1;;

fact 0 = fact' 0, fact 1 = fact' 1, fact 2 = fact' 2, fact 10 = fact' 10;;

(* Exercice 8 *)

let fib' n =
    let rec aux n prev2 prev =
        if n <= 0 then prev2
        else aux (n-1) (prev) (prev2+prev)
    in aux n 0 1;;

fib 0 = fib' 0, fib 1 = fib' 1, fib 2 = fib' 2, fib 10 = fib' 10;;

(* Exercice 9 *)

let syracuse start =
    let rec aux n i =
        if n = 1 then i
        else if n mod 2 = 0 then aux (n/2) (i+1)
        else aux (n*3 + 1) (i+1)
    in aux start 0;;

syracuse 1;;
syracuse 14;;
syracuse 100;;
syracuse 1_000;;
syracuse 10_000;;

(* Exercice 10 *)

let rec exp x n =
    if n != 0 then x * (exp x (n - 1))
    else 1;;

let exp' x n =
    let rec aux i acc =
        if i <= 0 then acc
        else aux (i-1) (acc*x)
    in aux n 1;;

let fast_exp x n =
    if n = 0 then 1
    else if n mod 2 = 0 then
        let tmp = exp x (n/2)
        in tmp * tmp
    else x * (exp x (n-1));;


exp 2 10;;
exp' 2 10;;
fast_exp 2 10;;

(* Exercice 11 *)

let sum1 m n = 1;;