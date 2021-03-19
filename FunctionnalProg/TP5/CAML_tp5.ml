(* Exercice 1 *)

let sqr x = x * x;;
let my_list = [3; 12; 3; 40; 6; 4; 6; 0];;

(* f_sum: (int -> int) -> int -> int -> int *)
let f_sum f (a: int) (b: int) = (f a) + (f b);;

f_sum;;
f_sum sqr 2 3;;
f_sum (fun x -> x + 1) 2 3;;

let new_f_sum f a = f_sum f a;;

new_f_sum;;
new_f_sum sqr 2;;
(new_f_sum sqr 2) 3;;

let f1 a b = a + b;;
let f2 f = (f 3) + 1;;
let f3 f x = (f (x+1)) + 1;;
let f4 f = fun x -> (f (x+1)) + 1;; (* impossible a réaliser *)
let f5 f = (f sqr)+1;;

List.map sqr my_list;;

List.map (( *) 2) my_list;;

(* (unit -> int) -> int -> int list *)
let make_list make n =
    let rec aux i list =
        if (i = n) then list
        else aux (i+1) (make()::list)
    in aux 0 [];;

let f () = 0;;
make_list f 8;;

make_list Random.bool 64;;

make_list (fun () -> Random.int 100) 16;;

(* Exercice 2 *)

let entiers = [2; 5; 7; 3; 12; 4; 9; 2; 11];;
let animaux = ["Wombat"; "aXolotl"; "pangolin"; "suricate"; "paresseuX"; "quoKKa"; "lemurien"];;

List.map (fun w -> String.length w) animaux;;

List.map (fun w -> String.uppercase_ascii w) animaux;;

List.filter (fun w -> String.lowercase_ascii w = w) animaux;;

List.filter (fun w -> (String.length w) mod 2 = 0) animaux;;

List.map (fun i -> (i, if (i mod 2 = 0) then "pair" else "impair")) entiers;;

List.map (fun i -> List.init i (fun _ -> i)) entiers;;

List.exists (fun w -> w.[0] = 's') animaux;;

List.for_all (fun w -> (String.length w) mod 5 = 2) animaux;;

(* Exercice 3 *)

let sum l = List.fold_left (fun acc next -> acc + next) 0 l;;
sum entiers;;

let size l = List.fold_left (fun acc _ -> acc + 1) 0 l;;
size entiers;;

let last l = List.fold_left (fun _ next -> next) 0 l;;
last entiers;;

let nb_occ e l = List.fold_left (fun acc next -> acc + if next = e then 1 else 0) 0 l;;
nb_occ 2 entiers;;

let max_list l = List.fold_left (fun acc next -> if acc > next then acc else next) (List.hd l) (List.tl l);;
max_list entiers;;

let average l =
    let (sum, length) = List.fold_left (fun (sum, length) next -> (sum + next, length + 1)) (0, 0) l in
    float_of_int sum /. float_of_int length;;
average entiers;;

(* Exercice 4 *)

let rec my_for_all p l =
    if l = [] then true
    else if p (List.hd l) then my_for_all p (List.tl l)
    else false;;
my_for_all (fun i -> i > 0) entiers;;

let my_for_all2 p l = List.fold_left (fun acc next -> acc && (p next)) true l;;
my_for_all2 (fun i -> i > 5) entiers;;

let my_for_all3 p l = List.fold_right (fun acc next -> acc && next) (List.map (fun it -> p it) l) true;;
my_for_all3 (fun i -> i > 0) entiers;;

let my_exists p l = List.fold_left (fun acc next -> acc || (p next)) false l;;
my_exists (fun i -> i = 2) entiers;;

let none p l = not (my_exists p l);;
none (fun i -> i = 2) entiers;; 

let not_all p l = not (my_for_all p l);;
not_all (fun i -> i > 5) entiers;;

let ordered p l = let (_, state) = List.fold_left (fun (prev, state) next -> next, p prev next) (0, true) l in state;;
ordered (<) [1; 2; 3];;
ordered (<) [1; 4; 3];;
ordered (fun x y -> x + y >= 1) [1; 4; -3; 6];;

let filter2 p a b = List.rev (List.fold_left2 (fun acc n1 n2 -> if p n1 n2 then (n1, n2)::acc else acc) [] a b);;
filter2 (<) [2; 2; 3] [1; 4; 5];;

(* Exercice 6 *)
type bintree = 
    | Empty
    | Node of int * bintree * bintree;;

let example_tree =
    Node(1,
        Node(2, Node(4, Empty, Empty),
            Node(5, Node(7, Empty, Empty), Node(8, Empty, Empty))),
        Node(3, Empty, Node(6, Node(9, Empty, Empty), Empty)));;

let rec map_tree f t = match t with
    | Empty -> Empty
    | Node(value, left, right) -> Node(f value, map_tree f left, map_tree f right);;

let rec fold_tree f t s = match t with
    | Empty -> s
    | Node(value, left, right) -> 
        let leftV = fold_tree f left s and rightV = fold_tree f right s in
        f value leftV rightV;;

fold_tree (fun acc a b -> acc+a+b) example_tree 0;;
fold_tree (fun acc a b -> acc*a*b) example_tree 1;;


let bintree_count_nodes t = fold_tree (fun acc a b -> acc + a + b) t 0;;

(*let bintree_collect_nodes t = fold_tree (fun acc next -> next::acc) t [];;*)
(* puisque fold_tree prend un (int -> int -> int), je ne vois pas quel genre de lambda je peux donner, sachant qu'un fold "normal" prendrai celle ci dessus *)

map_tree (fun x -> x * 2) example_tree;;
bintree_count_nodes example_tree;;