(* Exercice 1 *)

type bintree =
    | Node of bintree * int * bintree
    | Leaf of int
    | Empty;;

let example_tree = Node(Node(Leaf(4),2,Node(Leaf(7),5,Leaf(8))),1,Node(Empty,3,Node(Leaf(9),6,Empty)));;

(* Exercice 2 *)

let rec bintree_count_nodes tree = match tree with
    | Node(left, _, right) -> (bintree_count_nodes left) + (bintree_count_nodes right) + 1
    | Leaf(_) -> 1
    | Empty -> 0;;

let rec bintree_count_leaves tree = match tree with
    | Node(left, _, right) -> (bintree_count_leaves left) + (bintree_count_leaves right)
    | Leaf(_) -> 1
    | Empty -> 0;;

let rec bintree_count_internal_nodes tree = match tree with
    | Node(left, _, right) -> (bintree_count_internal_nodes left) + (bintree_count_internal_nodes right) + 1
    | Leaf(_) -> 0
    | Empty -> 0;;

let bintree_count_right tree =
    let rec aux curr count = match curr with
        | Node(left, _, right) -> (aux left count) + (aux right (count+1))
        | Leaf(_) -> 0
        | Empty -> count
    in aux tree 0;;

let bintree_count_left tree =
    let rec aux curr count = match curr with
        | Node(left, _, right) -> (aux left (count+1)) + (aux right count)
        | Leaf(_) -> 0
        | Empty -> count
    in aux tree 0;;

bintree_count_nodes;;
bintree_count_nodes example_tree;;

bintree_count_leaves;;
bintree_count_leaves example_tree;;

bintree_count_internal_nodes;;
bintree_count_internal_nodes example_tree;;

bintree_count_right;;
bintree_count_right example_tree;;

bintree_count_left;;
bintree_count_left example_tree;;

(* Exercice 3 *)

let rec bintree_height tree =
    let max a b = if a > b then a else b in
    match tree with
        | Node(left, _, right) -> max ((bintree_height left)+1) ((bintree_height right)+1)
        | Leaf(_) -> 1
        | Empty -> 0;;

let rec bintree_is_mirror tree1 tree2 = match tree1 with
    | Node(left1, _, right1) -> (match tree2 with
        | Node(left2, _, right2) -> (bintree_is_mirror left1 right2) && (bintree_is_mirror left2 right1)
        | Leaf(_) -> false
        | Empty -> false)
    | Leaf(_) -> (match tree2 with
        | Node(_, _, _) -> false
        | Leaf(_) -> true
        | Empty -> false)
    | Empty -> (match tree2 with
        | Node(_, _, _) -> false
        | Leaf(_) -> false
        | Empty -> true);;

let bintree_is_symmetric tree = match tree with
    | Node(left, _, right) -> bintree_is_mirror left right
    | Leaf(_) -> true
    | Empty -> true;;

bintree_height;;
bintree_height example_tree;;

bintree_is_mirror;;
bintree_is_mirror Empty Empty;;
bintree_is_mirror (Node(Empty, 1, Empty)) (Node(Empty, 2, Empty));;
bintree_is_mirror (Node(Empty, 1, Node(Empty,3, Empty))) (Node(Node(Empty, 4, Empty), 2, Empty));;

bintree_is_symmetric;;
bintree_is_symmetric Empty;;
bintree_is_symmetric (Node(Node(Empty, 2, Empty), 1, Node(Empty, 2, Empty)));;
bintree_is_symmetric (Node(Node(Empty, 2, Empty), 1, Empty));;

(* Exercice 4 *)

let bintree_collect_nodes tree =
    let rec aux curr list = match curr with
        | Node(left, it, right) -> it::(aux left list)@(aux right list)
        | Leaf(it) -> it::list
        | Empty -> list
    in aux tree [];;

let bintree_collect_leaves tree =
    let rec aux curr list = match curr with
        | Node(left, _, right) -> (aux left list)@(aux right list)
        | Leaf(it) -> it::list
        | Empty -> list
    in aux tree [];;

let bintree_collect_internal_nodes tree =
    let rec aux curr list = match curr with
        | Node(left, it, right) -> it::(aux left list)@(aux right list)
        | Leaf(_) -> list
        | Empty -> list
    in aux tree [];;

let bintree_collect_level tree level =
    if level < 1 || level > bintree_height tree then []
    else let rec aux curr currlev list =
            match curr with
                | Node(left, it, right) -> (
                    if (level = currlev) then it::list
                    else (aux left (currlev+1) list)@(aux right (currlev+1) list)
                )
                | Leaf(it) -> (
                    if (level = currlev) then it::list
                    else list
                )
                | Empty -> list
        in aux tree 1 [];;

let bintree_collect_canopy tree =
    let rec aux curr list = match curr with
        | Node(left, _, right) -> (
            match left with
                | Node(_, _, _) -> aux left list
                | Leaf(_) -> 0::list
                | Empty -> list
        )@(
            match right with
                | Node(_, _, _) -> aux right list
                | Leaf(_) -> 1::list
                | Empty -> list
        )
        | Leaf(_) -> list
        | Empty -> list
    in aux tree [];;

bintree_collect_nodes;;
bintree_collect_nodes example_tree;;

bintree_collect_leaves;;
bintree_collect_leaves example_tree;;

bintree_collect_internal_nodes;;
bintree_collect_internal_nodes example_tree;;

bintree_collect_level;;
bintree_collect_level example_tree 1;;
bintree_collect_level example_tree 2;;
bintree_collect_level example_tree 3;;
bintree_collect_level example_tree 4;;
bintree_collect_level example_tree 5;;

bintree_collect_canopy;;
bintree_collect_canopy example_tree;;