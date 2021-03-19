open List
open String

(* file system item type *)
type fs_file_type = PDF (* portable document format *)
                  | DOC (* microsoft document *)
                  | PNG (* portable network graphics *)
                  | JPG (* joint photographic experts group, *)
                  | AVI (* audio video interleave *)
                  | MKV (* matroska video *)

(* file system item name alias *)
type fs_item_name = string

(* file system item size alias *)
type fs_file_size = int

(* file system file *)
(* a file is described by its name, its type and its size *)
type fs_file = File of fs_item_name * fs_file_type * fs_file_size

(* file system folder *)
(* a folder is simply described by its name *)
type fs_folder = Folder of fs_item_name

(* file system item *)
(* a file system item is either a folder (containing items) or a file *)
type fs_item = FolderItem of fs_folder * fs_item list
             | FileItem of fs_file



(* val files : fs_item -> fs_file list = <fun> *)


(* val folders : fs_item -> fs_folder list = <fun> *)


(* val is_image : fs_file -> bool = <fun> *)


(* val is_movie : fs_file -> bool = <fun> *)


(* val is_document : fs_file -> bool = <fun> *)


(* val images : fs_item -> fs_file list = <fun> *)


(* val movies : fs_item -> fs_file list = <fun> *)


(* val documents : fs_item -> fs_file list = <fun> *)


(* val rec_search_list : fs_file list -> String.t -> fs_file list = <fun> *)


(* val tail_rec_search_list : fs_file list -> String.t -> fs_file list = <fun> *)


(* val not_rec_search_list : fs_file list -> String.t -> fs_file list = <fun> *)


(* val search : fs_item -> String.t -> fs_file list = <fun> *)


(* val search_documents : fs_item -> String.t -> fs_file list = <fun> *)


(* val search_documents_fun : (fs_file list -> 'a) -> fs_item -> 'a = <fun> *)


(* val size_images : fs_item -> int = <fun> *)


(* val fs_filter : (fs_item -> bool) -> fs_item -> fs_item_name list = <fun> *)


(* val item_names_with_large6_name : fs_item -> fs_item_name list = <fun> *)


(* val item_names_with_digit_in_name : fs_item -> fs_item_name list = <fun> *)


(* val full_paths : fs_item -> string list = <fun> *)


(* val no_two_identical_names : String.t list -> bool = <fun> *)


(* val name_with_ext : fs_item -> fs_item_name = <fun> *)


(* val check : fs_item -> bool = <fun> *)


(* val du : fs_item -> (fs_item_name * fs_file_size) list = <fun> *)



