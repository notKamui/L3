(* point type definition *)
type point = float * float

(* Question 1 *)
(* float -> float -> point *)
(* make_point *)
let make_point (f1 : float) (f2 : float) : point = (f1, f2)

(* Question 2 *)
(* point -> float *)
(* point_x *)
let point_x (p : point) : float = fst p

(* point -> float *)
(* point_y *)
let point_y (p : point) : float = snd p

(* Question 3 *)
(* point -> point -> bool *)
(* point_domination *)
let point_domination (p1 : point) (p2 : point) : bool =
  fst p1 >= fst p2 && snd p1 >= snd p2

(* -------------------------------------------------------------------------- *)

(* rectangle type definition *)
type rectangle = point * point

(* Question 4 *)
(* point -> point -> rectangle *)
(* make_rectangle *)
let make_rectangle (p1 : point) (p2 : point) : rectangle =
  assert (point_domination p2 p1);
  (p1, p2)

(* Question 5 *)
(* rectangle -> point *)
(* rectangle_lower_left *)
let rectangle_lower_left (r : rectangle) : point = fst r

(* rectangle -> point *)
(* rectangle_upper_right *)
let rectangle_upper_right (r : rectangle) : point = snd r

(* Question 6 *)
(* rectangle -> float *)
(* rectangle_width *)
let rectangle_width (r : rectangle) : float =
  point_x (rectangle_upper_right r) -. point_x (rectangle_lower_left r)

(* rectangle -> float *)
(* rectangle_height *)
let rectangle_height (r : rectangle) : float =
  point_y (rectangle_upper_right r) -. point_y (rectangle_lower_left r)

(* Question 7 *)
(* rectangle -> point -> bool *)
(* rectangle_contains_point *)
let rectangle_contains_point (r : rectangle) (p : point) : bool =
  let pl = rectangle_lower_left r in
  let pr = rectangle_upper_right r in
  point_domination p pl && point_domination pr p

(* Question 8 *)
(* rectangle -> point list -> point list *)
(* rectangle_contains_points *)
let rectangle_contains_points (r : rectangle) (ps : point list) : point list =
  List.filter (fun p -> rectangle_contains_point r p) ps

(* -------------------------------------------------------------------------- *)

(* quadtree type definition *)
type quadtree =
  | Leaf of point list * rectangle
  | Node of quadtree * quadtree * quadtree * quadtree * rectangle

(* Question 9 *)
(* rectangle -> rectangle * rectangle * rectangle * rectangle  *)
(* rectangle_split_four *)
let rectangle_split_four (r : rectangle) :
  rectangle * rectangle * rectangle * rectangle =
  let pl, pr = r in
  match r with
  | (xl, yl), (xr, yr) ->
    let m = make_point ((xl +. xr) /. 2.) ((yl +. yr) /. 2.) in
    let u = make_point ((xl +. xr) /. 2.) yr in
    let l = make_point xl ((yl +. yr) /. 2.) in
    let d = make_point ((xl +. xr) /. 2.) yl in
    let r = make_point xr ((yl +. yr) /. 2.) in
    ( make_rectangle l u,
      make_rectangle m pr,
      make_rectangle d r,
      make_rectangle pl m )

(* Question 10 *)
(* ’a list -> ’a *)
(* smallest *)
let smallest lst =
  assert (lst != []);
  if List.length lst = 1 then List.hd lst
  else
    List.fold_left
      (fun acc next -> if compare acc next >= 0 then next else acc)
      (List.hd lst) (List.tl lst)

(* ’a list -> ’a *)
(* largest *)
let largest lst =
  assert (lst != []);
  if List.length lst = 1 then List.hd lst
  else
    List.fold_left
      (fun acc next -> if compare acc next >= 0 then acc else next)
      (List.hd lst) (List.tl lst)

(* Question 11 *)
(* point list -> rectangle *)
(* enclosing_rectangle *)
let enclosing_rectangle (ps : point list) : rectangle =
  make_rectangle (smallest ps) (largest ps)

(* Question 12 *)
(* point list -> int -> quadtree *)
(* quadtree_make *)
let quadtree_make (ps : point list) (n : int) : quadtree =
  assert (ps != []);
  let rec aux ps encl =
    if List.length ps <= n then Leaf (ps, encl)
    else
      let nw, ne, se, sw = rectangle_split_four encl in
      Node
        ( aux (rectangle_contains_points nw ps) nw,
          aux (rectangle_contains_points ne ps) ne,
          aux (rectangle_contains_points se ps) se,
          aux (rectangle_contains_points sw ps) sw,
          encl )
  in
  aux ps (enclosing_rectangle ps)

(* Question 13 *)
(* quadtree -> int  *)
(* quadtree_count *)
let rec quadtree_count (tree : quadtree) : int =
  match tree with
  | Leaf (ps, _) -> List.length ps
  | Node (nw, ne, se, sw, _) ->
    quadtree_count nw + quadtree_count ne + quadtree_count se
    + quadtree_count sw

(* Question 14 *)
(* quadtree -> int list *)
(* quadtree_signature *)
let rec quadtree_signature (tree : quadtree) : int list =
  match tree with
  | Leaf (ps, _) -> [ List.length ps ]
  | Node (nw, ne, se, sw, _) ->
    quadtree_signature nw @ quadtree_signature ne @ quadtree_signature se
    @ quadtree_signature sw

(* -------------------------------------------------------------------------- *)

(* Question 15 *)
(* quadtree -> point list  *)
(* quadtree_all_points *)
let rec quadtree_all_points (tree : quadtree) : point list =
  match tree with
  | Leaf (ps, _) -> ps
  | Node (nw, ne, se, sw, _) ->
    quadtree_all_points nw @ quadtree_all_points ne @ quadtree_all_points se
    @ quadtree_all_points sw

(* rectangle -> rectangle -> bool *)
let rectangle_contains_rectangle (r1 : rectangle) (r2 : rectangle) : bool =
  rectangle_contains_point r1 (rectangle_lower_left r2)
  && rectangle_contains_point r1 (rectangle_upper_right r2)

(* rectangle -> rectangle -> bool *)
let rectangle_disjoint ((p1, p2) : rectangle) ((p3, p4) : rectangle) : bool =
  point_domination p3 p2 || point_domination p1 p4

(* rectangle * rectangle -> rectangle *)
let rectangle_intersection (((p1, p2), (p3, p4)) : rectangle * rectangle) :
  rectangle =
  let ll_x_max = largest [ point_x p1; point_x p3 ] in
  let ll_y_max = largest [ point_y p1; point_y p3 ] in
  let ur_x_min = smallest [ point_x p2; point_x p4 ] in
  let ur_y_min = smallest [ point_y p2; point_y p4 ] in
  let ll = make_point ll_x_max ll_y_max in
  let ur = make_point ur_x_min ur_y_min in
  make_rectangle ll ur

(* Question 16 *)
(* rectangle -> quadtree -> point list  *)
(* rectangle_query *)
let rec rectangle_query (r : rectangle) (tree : quadtree) : point list =
  match tree with
  | Leaf (ps, root) when not (rectangle_disjoint r root) ->
    if rectangle_contains_rectangle root r then ps
    else rectangle_contains_points r ps
  | Node (nw, ne, se, sw, root) when not (rectangle_disjoint r root) ->
    if rectangle_contains_rectangle root r then quadtree_all_points tree
    else
      rectangle_query r nw @ rectangle_query r ne @ rectangle_query r se
      @ rectangle_query r sw
  | _ -> []

(* -------------------------------------------------------------------------- *)

(* Question 17 *)
(* quadtree -> int -> point -> quadtree *)
(* quadtree_insert *)

(* Question 18 *)
(* quadtree -> point -> quadtree *)
(* quadtree_delete *)
