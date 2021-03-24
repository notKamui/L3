#load "str.cma";;

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

let search_documents fs = not_rec_search_list (documents fs);;

let search_documents_fun fn fs = fn (documents fs);;

let size_images fs = List.fold_left (fun acc next -> match next with File(_, _, size) -> acc + size) 0 (images fs);;

let rec fs_filter filter fs =
    match fs with
        | FileItem(File(name, _, _)) -> (if filter fs then [name] else [])
        | FolderItem(Folder name, children) -> 
            List.append (List.fold_left (fun acc next -> List.append acc (fs_filter filter next)) [] children) (if filter fs then [name] else []);;

let item_names_with_large6_name fs =
    fs_filter (fun it -> match it with
        | FileItem(File(name, _, _)) when String.length name >= 6 -> true
        | FolderItem(Folder name, _) when String.length name >= 6 -> true
        | _ -> false
    ) fs;;

let item_names_with_digit_in_name fs =
    let has_digit s = Str.string_match (Str.regexp ".*[0-9].*") s 0 in
    fs_filter (fun it -> match it with
        | FileItem(File(name, _, _)) when has_digit name -> true
        | FolderItem(Folder name, _) when has_digit name -> true
        | _ -> false
    ) fs;;

let full_paths fs =
    let make_path path last = String.concat "/" (List.append path [last]) in
    let rec aux curr path = 
        match curr with
            | FileItem(File(name, _, _)) -> [(make_path path name)]
            | FolderItem(Folder name, children) -> 
                (make_path path name)::(List.fold_left (fun acc next -> List.append acc (aux next (List.append path [name]))) [] children)
    in aux fs [];;

let name_with_ext fs =
    match fs with
        | FolderItem(Folder name, _) -> name
        | FileItem(File(name, ftype, _)) -> 
            name^(match ftype with
                | PDF -> ".pdf"
                | DOC -> ".doc"
                | PNG -> ".png"
                | JPG -> ".jpg"
                | AVI -> ".avi"
                | MKV -> ".mkv"
            );;

let rec sort lst =
    match lst with
        | [] -> []
        | head :: tail -> insert head (sort tail)
and insert elt lst =
    match lst with
        | [] -> [elt]
        | head :: tail -> if elt <= head then elt :: lst else head :: insert elt tail;;

let no_two_identical_names l =
    let rec aux state =
        match state with
            | head::tail when tail != [] -> if head = List.hd tail then false else aux tail
            | _ -> true
    in aux (sort l);;

let check fs =
    match fs with FileItem(_) -> false | FolderItem(_, _) ->
        let rec aux curr =
            match curr with
                | FileItem(_) -> true
                | FolderItem(_, children) ->
                    let names = List.map name_with_ext children in
                    if no_two_identical_names names then
                        List.fold_left (fun acc next -> acc && (aux next)) true children
                    else
                        false
        in aux fs;;

(*let du fs =
    match fs with
        | FileItem(File(_, _, size)) -> [(name_with_ext fs), size)]
        | FolderItem(name, children) ->
            (name, )*)

(* toy file system my_fs *)
let my_fs =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FileItem (File ("doc 1", DOC, 32)); FileItem (File ("doc 2", DOC, 64));
      FileItem (File ("doc 3", PDF, 1024));
      FileItem (File ("doc 4", PDF, 2048));
      FolderItem (Folder "2015",
       [FileItem (File ("sujet tp note", PDF, 512));
        FileItem (File ("notes tp", DOC, 64))]);
      FolderItem (Folder "2016",
       [FileItem (File ("sujet tp note", PDF, 512));
        FileItem (File ("notes tp", DOC, 64))])]);
    FileItem (File ("Documents", PDF, 512));
    FileItem (File ("config", DOC, 28));
    FolderItem (Folder "Downloads",
     [FileItem (File ("doc 1", DOC, 32)); FileItem (File ("doc 2", DOC, 64));
      FileItem (File ("doc 1", PDF, 1024));
      FileItem (File ("doc 2", PDF, 2048))]);
    FolderItem (Folder "Movies",
     [FolderItem (Folder "Rocky 1",
       [FileItem (File ("Rocky 1", MKV, 4294967296));
        FileItem (File ("Rocky 1 - subtitle fr", DOC, 4096));
        FileItem (File ("Rocky 1 - subtitle en", DOC, 4096))]);
      FolderItem (Folder "Jaws 2",
       [FileItem (File ("Jaws 2", AVI, 16777216));
        FileItem (File ("Jaws 2 - subtitle fr", DOC, 4096))]);
      FolderItem (Folder "Alien 3",
       [FileItem (File ("Alien 3", MKV, 4294967296))]);
      FileItem (File ("Seven", AVI, 1024));
      FileItem (File ("seen movies", DOC, 64))]);
    FolderItem (Folder "Pictures",
     [FileItem (File ("Martine fait du chameau 1", PNG, 2048));
      FileItem (File ("Martine fait du chameau 2", JPG, 4096));
      FolderItem (Folder "Photos 2015",
       [FileItem (File ("description 2015", DOC, 256));
        FileItem (File ("Martine au zoo 1", JPG, 2048));
        FileItem (File ("Martine au zoo 2", JPG, 2048));
        FileItem (File ("Martine au zoo 3", PNG, 2048))]);
      FolderItem (Folder "Photos 2016",
       [FileItem (File ("description 2016", DOC, 512));
        FileItem (File ("Martine mange une pomme 1", JPG, 2048));
        FileItem (File ("Martine mange une pomme 2", JPG, 2048));
        FileItem (File ("Martine mange une pomme 3", PNG, 2048));
        FileItem (File ("Martine mange une pomme 4", PNG, 2048))])])]);;

(* toy file system my_fs2 *)
let my_fs2 =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FileItem (File ("doc 1", DOC, 32));
      FileItem (File ("doc 2", DOC, 64));
      FileItem (File ("doc 3", PDF, 1024));
      FileItem (File ("doc 4", PDF, 2048))]);
    FileItem (File ("Documents", DOC, 28))]);;

(* toy file system my_fs3 *)
let my_fs3 =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FolderItem (Folder "Documents",
       [FileItem (File ("doc 1", DOC, 32));
        FileItem (File ("doc 2", DOC, 64))]);
      FileItem (File ("doc 1", DOC, 32));
      FileItem (File ("doc 2", DOC, 64))]);
    FileItem (File ("Downloads", DOC, 28))]);;

(* toy file system my_fs4 *)
let my_fs4 =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FileItem (File ("doc 1", DOC, 32));
      FileItem (File ("doc 2", DOC, 64));
      FileItem (File ("doc 1", PDF, 1024));
      FileItem (File ("doc 2", PDF, 2048))]);
    FolderItem (Folder "Documents", [])]);;

(* toy file system my_fs5 *)
let my_fs5 =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FileItem (File ("doc 1", DOC, 32));
      FileItem (File ("doc 1", DOC, 64));
      FileItem (File ("doc 3", PDF, 1024));
      FileItem (File ("doc 4", PDF, 2048))]);
    FileItem (File ("Documents", DOC, 28))]);;

(* toy file system my_fs6 *)
let my_fs6 =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FileItem (File ("doc 1", DOC, 32));
      FileItem (File ("doc 1", DOC, 64))]);
    FileItem (File ("AutresDocuments", DOC, 28))]);;

(* File examples *)
let test1 = File ("file 1", DOC, 32)
let test2 = File ("file 2", PNG, 512)
let test3 = File ("file 3", AVI, 4294967296);;

files my_fs;;
folders my_fs;;

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

print_string "search_documents my_fs \"notes td\";;";;
search_documents my_fs "notes td";;
print_string "search_documents my_fs \"notes tp\";;";;
search_documents my_fs "notes tp";;
print_string "search_documents my_fs \"Rocky 1\";;";;
search_documents my_fs "Rocky 1";;
print_string "\n";;

print_string "size_images my_fs;;";;
size_images my_fs;;
print_string "\n";;

print_string "item_names_with_large6_name my_fs";;
item_names_with_large6_name my_fs;;
print_string "item_names_with_digit_in_name my_fs";;
item_names_with_digit_in_name my_fs;;
print_string "\n";;

print_string "full_paths my_fs;;";;
full_paths my_fs;;
print_string "\n";;

print_string "check my_fs, check my_fs2, check my_fs3, check my_fs4, check my_fs5, check my_fs6;;";;
check my_fs, check my_fs2, check my_fs3, check my_fs4, check my_fs5, check my_fs6;;
print_string "\n";;

(*print_string "du my_fs;;";;
du my_fs;;*)