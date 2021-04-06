let memo f =
    let m = ref [] in
    fun x ->
        try List.assoc x !m
        with Not_found ->
            let y = f x in
            m := (x, y) :: !m;
            y

(**********************************************************************)
(***************************** Exercice 1 *****************************)
(**********************************************************************)

(* 1.1. *)
(* val interval : int -> int -> int list = <fun> *)
let interval a b =
    if a > b then  []
    else List.init (b - a + 1) (fun i -> i + a)

(* 1.2. *)
(* val string_of_list : 'a list -> ('a -> string) -> string = <fun> *)
let string_of_list lst mapper = List.fold_left (fun acc next -> acc ^ (mapper next)) "" lst

(* 1.3. *)
(* val compose_iter : ('a -> 'a) -> 'a -> int -> 'a list = <fun> *)
let compose_iter f x n =
    let rec aux v it =
        if it = 0 then v
        else aux (f v) (it - 1)
    in List.init (n + 1) (fun i -> aux x i);;

(* 1.4. *)
(* val is_prefix_lists : 'a list -> 'a list -> bool = <fun> *)
let rec is_prefix_lists pref lst =
    if pref = [] then
        true
    else if lst != [] && List.hd pref = List.hd lst then
        is_prefix_lists (List.tl pref) (List.tl lst)
    else
        false

(* 1.5. *)
(* val is_factor_lists : 'a list -> 'a list -> bool = <fun> *)
let rec is_factor_lists fact lst =
    if fact = [] then true
    else if lst = [] then false
    else if is_prefix_lists fact lst then true
    else is_factor_lists fact (List.tl lst)

(* 1.6. *)
(* val is_subword_lists : 'a list -> 'a list -> bool = <fun> *)
let rec is_subword_lists sub lst = 
    if sub = [] then
        true
    else if lst = [] then
        false
    else if List.hd lst = List.hd sub then
        is_subword_lists (List.tl sub) (List.tl lst)
    else
        is_subword_lists sub (List.tl lst)

(* 1.7. *)
(* val is_duplicate_free : 'a list -> bool = <fun> *)
exception Found
let is_duplicate_free lst =
    let hash = Hashtbl.create (List.length lst) in
    try (
        List.iter (fun el ->
            if (Hashtbl.mem hash el) then (raise Found)
            else (Hashtbl.add hash el true)
        ) lst;
        true
    ) with Found -> false

(**********************************************************************)
(***************************** Exercice 2 *****************************)
(**********************************************************************)

type 'a automaton = {
    ribbon: int -> 'a;
    evol: 'a * 'a * 'a -> 'a;
    void: 'a
}

(* 2.1. *)
(* val create : ('a * 'a * 'a -> 'a) -> 'a -> 'a automaton = <fun> *)
let create e v = { ribbon = (fun _ -> v); evol = e; void = v }

(* 2.2. *)
(* val get_value : 'a automaton -> int -> 'a = <fun> *)
let get_value atm idx = atm.ribbon idx

(* 2.3. *)
(* val set_value : 'a automaton -> int -> 'a -> 'a automaton = <fun> *)
let set_value atm idx value = { atm with ribbon = (fun i -> if idx = i then value else atm.ribbon i); }

(**********************************************************************)
(***************************** Exercice 3 *****************************)
(**********************************************************************)

type bunch = int * int

(* 3.1. *)
(* val get_bunch_values : 'a automaton -> bunch -> 'a list = <fun> *)
let get_bunch_values atm bnc =
    let (a, b) = bnc in
    let itvl = interval a b in
    List.map (fun i -> atm.ribbon i) itvl


(* 3.2. *)
(* val to_string : 'a automaton -> bunch -> ('a -> string) -> string
    = <fun> *)
let to_string atm bnc mapper = string_of_list (get_bunch_values atm bnc) mapper

(* 3.3. *)
(* val has_factor : 'a automaton -> bunch -> 'a list -> bool = <fun> *)
let has_factor atm bnc fact = is_factor_lists fact (get_bunch_values atm bnc)


(* 3.4. *)
(* val has_subword : 'a automaton -> bunch -> 'a list -> bool = <fun> *)
let has_subword atm bnc sub = is_subword_lists sub (get_bunch_values atm bnc)

(**********************************************************************)
(***************************** Exercice 4 *****************************)
(**********************************************************************)

(* 4.1. *)
(* val shift : 'a automaton -> int -> 'a automaton = <fun> *)
let shift atm k = { atm with ribbon = (fun i -> atm.ribbon (i + k)); }

(* 4.2. *)
(* val mirror : 'a automaton -> 'a automaton = <fun> *)
let mirror atm = { atm with ribbon = (fun i -> atm.ribbon (-i)) }

(* 4.3. *)
(* val map : 'a automaton -> ('a -> 'a) -> 'a automaton = <fun> *)
let map atm transform = { atm with ribbon = (fun i -> transform (atm.ribbon i)) }

(* 4.4. *)
(* val evolution : 'a automaton -> 'a automaton = <fun> *)
let evolution atm = { atm with ribbon = (fun i -> atm.evol ((atm.ribbon (i-1)), (atm.ribbon i), (atm.ribbon (i+1)))) }

(* 4.5. *)
(* val evolutions : 'a automaton -> int -> 'a automaton list = <fun> *)
let evolutions atm n = compose_iter evolution atm n

(* 4.6. *)
(* val evolutions_bunch : 'a automaton -> bunch -> int -> 'a list list = <fun> *)
let evolutions_bunch atm bnc n = List.map (fun it -> get_bunch_values it bnc) (evolutions atm n)

(* 4.7. *)
(* val is_resurgent : 'a automaton -> bunch -> int -> bool *)
let is_resurgent atm bnc n = not (is_duplicate_free (evolutions_bunch atm bnc n))

(**********************************************************************)
(***************************** Exercice 5 *****************************)
(**********************************************************************)

(* 5.1. *)
(* val sierpinski : int automaton = {ribbon = <fun>; evol = <fun>; void = 0} *)
let sierpinski = create (fun (a, b, c) -> (a + b + c) mod 2) 0

(* 5.2. *)
(* Type wb. *)
(* val chaos : wb automaton = {ribbon = <fun>; evol = <fun>; void = White} *)
type wb = White | Black
let chaos = create (fun (a, b, c) ->
    match a with
    | White -> (
        match b with
        | White -> (
            match c with
            | White -> White
            | Black -> Black
        )
        | Black -> (
            match c with
            | White -> Black
            | Black -> Black
        )
    )
    | Black -> (
        match b with
        | White -> (
            match c with
            | White -> Black
            | Black -> White
        )
        | Black -> (
            match c with
            | White -> White
            | Black -> White
        )
    )
) White

(**********************************************************************)
(***************************** Exercice 6 *****************************)
(**********************************************************************)

;;

(* 6.1. *)
let aut =  set_value sierpinski 0 1;;
evolutions aut 16;;
(*print_string (String.concat "\n"
    (List.map (fun a ->
        to_string a (-8, 8) string_of_int
    ) (evolutions aut 16))
);;*)
(* Trop long et couteux car calcul a chaque fois *)

(* 6.2. *)
