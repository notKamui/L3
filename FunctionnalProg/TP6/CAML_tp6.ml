(* Part 1 *)

type tree =
    | Leaf of int
    | Node of char * tree list;;

let example_tree =
    Node ('a',
    [Node ('b', [Leaf 1; Leaf 2; Leaf 3]);
        Node ('c', [Node ('d', [Leaf 4; Leaf 5]); Node ('e', [Leaf 6])]);
        Leaf 7;
        Node ('f', [Node ('g', [Leaf 8]); Leaf 9])]);;

let tree_count_nodes t =
    let rec aux curr acc = match curr with
        | Leaf(_) -> 0
        | Node (_, children) -> (List.fold_left (fun acc next -> (aux next acc) + acc) 0 children) + 1
    in aux t 0;;

let tree_list_leaves t =
    let rec aux curr acc = match curr with
        | Leaf(value) -> [value]
        | Node (_, children) -> List.fold_left (fun acc next -> List.append acc (aux next acc)) [] children
    in aux t [];;


tree_count_nodes example_tree;;
tree_list_leaves example_tree;;

(* Part 2 *)

(* file system item type *)
type fs_file_type = PDF (* portable document format *)
                  | DOC (* microsoft document *)
                  | PNG (* portable network graphics *)
                  | JPG (* joint photographic experts group, *)
                  | AVI (* audio video interleave *)
                  | MKV (* matroska video *);;

(* file system item name alias *)
type fs_item_name = string;;

(* file system item size alias *)
type fs_file_size = int;;

(* file system file *)
(* a file is described by its name, its type and its size *)
type fs_file = File of fs_item_name * fs_file_type * fs_file_size;;

(* file system folder *)
(* a folder is simply described by its name *)
type fs_folder = Folder of fs_item_name;;

(* file system item *)
(* a file system item is either a folder (containing items) or a file *)
type fs_item = FolderItem of fs_folder * fs_item list
             | FileItem of fs_file;;

(* Part 3 *)

let rec files fs = match fs with
    | FileItem(file) -> [file]
    | FolderItem(_, children) -> List.fold_left (fun acc next -> List.append acc (files next)) [] children;;

let rec folders fs = match fs with
    | FileItem(_) -> []
    | FolderItem(self, children) -> self::(List.fold_left (fun acc next -> (List.append acc (folders next))) [] children);;

let rec ftype_pred file types =
    match file with
        | File (_, ftype, _) when types != [] ->
            if ftype = (List.hd types) then true
            else ftype_pred file (List.tl types)
        | _ -> false;;
let is_image f = ftype_pred f [JPG; PNG];;
let is_movie f = ftype_pred f [AVI; MKV];;
let is_document f = ftype_pred f [DOC; PDF];;

let files_filtered pred fs = List.filter pred (files fs);;
let images fs = files_filtered is_image fs;;
let movies fs = files_filtered is_movie fs;;
let documents fs = files_filtered is_document fs;;

let rec rec_search_list list name =
    if list = [] then []
    else match List.hd list with
        | File(this, _, _) when this = name -> (List.hd list)::(rec_search_list (List.tl list) name)
        | _ -> rec_search_list (List.tl list) name;;

let tail_rec_search_list list name =
    let rec aux left acc =
        if left = [] then acc
        else match List.hd left with
            | File(this, _, _) when this = name -> aux (List.tl left) ((List.hd list)::acc)
            | _ -> aux (List.tl left) acc
    in aux list [];;

let not_rec_search_list list name =
    List.filter (fun it ->
        match it with
            | File(this, _, _) when this = name -> true
            | _ -> false
    ) list;;

#use "tp6_exemple.ml";;

files my_fs2;;
folders my_fs2;;

print_string "is_image test1, is_image test2, is_image test3;;";;
is_image test1, is_image test2, is_image test3;;
print_string "is_movie test1, is_movie test2, is_movie test3;;";;
is_movie test1, is_movie test2, is_movie test3;;
print_string "is_document test1, is_document test2, is_document test3;;";;
is_document test1, is_document test2, is_document test3;;
print_string "\n";;

print_string "images my_fs;;";;
images my_fs;;
print_string "movies my_fs;;";;
movies  my_fs;;
print_string "documents my_fs;;";;
documents my_fs;;
print_string "\n";;

print_string "rec_search_list (files my_fs) \"notes td\";;";;
rec_search_list (files my_fs) "notes td";;
print_string "rec_search_list (files my_fs) \"notes tp\";;";;
rec_search_list (files my_fs) "notes tp";;
print_string "tail_rec_search_list (files my_fs) \"notes td\";;";;
tail_rec_search_list (files my_fs) "notes td";;
print_string "tail_rec_search_list (files my_fs) \"notes tp\";;";;
tail_rec_search_list (files my_fs) "notes tp";;
print_string "not_rec_search_list (files my_fs) \"notes td\";;";;
not_rec_search_list (files my_fs) "notes td";;
print_string "not_rec_search_list (files my_fs) \"notes tp\"";;
not_rec_search_list (files my_fs) "notes tp";;
print_string "\n";;
