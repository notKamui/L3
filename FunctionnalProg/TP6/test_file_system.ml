(* toy file system *)
let my_fs : fs_item =
  FolderItem (Folder "root",
    [ FolderItem (Folder "Documents",
      [ FileItem (File ("doc 1", DOC, 32))
      ; FileItem (File ("doc 2", DOC, 64))
      ; FileItem (File ("doc 3", PDF, 1024))
      ; FileItem (File ("doc 4", PDF, 2048))
      ; FolderItem (Folder "2015",
        [ FileItem (File ("sujet tp note", PDF, 512))
        ; FileItem (File ("notes tp", DOC, 64))
        ])
      ;  FolderItem (Folder "2016",
        [ FileItem (File ("sujet tp note", PDF, 512))
        ; FileItem (File ("notes tp", DOC, 64))
        ])
      ])
    ; FileItem (File ("Documents", PDF, 512))
    ; FileItem (File ("config", DOC, 28))
    ; FolderItem (Folder "Downloads",
      [
        FileItem (File ("doc 1", DOC, 32))
      ; FileItem (File ("doc 2", DOC, 64))
      ; FileItem (File ("doc 1", PDF, 1024))
      ; FileItem (File ("doc 2", PDF, 2048))
      ])
    ; FolderItem (Folder "Movies",
      [ FolderItem (Folder "Rocky 1",
        [ FileItem (File ("Rocky 1", MKV, 4294967296))
        ; FileItem (File ("Rocky 1 - subtitle fr", DOC, 4096))
        ; FileItem (File ("Rocky 1 - subtitle en", DOC, 4096))
        ])
      ; FolderItem (Folder "Jaws 2",
        [
          FileItem (File ("Jaws 2", AVI, 16777216))
        ; FileItem (File ("Jaws 2 - subtitle fr", DOC, 4096))
        ])
      ; FolderItem (Folder "Alien 3",
        [ FileItem (File ("Alien 3", MKV, 4294967296))
        ])
      ; FileItem (File ("Seven", AVI, 1024))
      ; FileItem (File ("seen movies", DOC, 64))
      ])
    ; FolderItem (Folder "Pictures",
      [ FileItem (File ("Martine fait du chameau 1", PNG, 2048))
      ; FileItem (File ("Martine fait du chameau 2", JPG, 4096))
      ; FolderItem (Folder "Photos 2015",
        [ FileItem (File ("description 2015", DOC, 256))
        ; FileItem (File ("Martine au zoo 1", JPG, 2048))
        ; FileItem (File ("Martine au zoo 2", JPG, 2048))
        ; FileItem (File ("Martine au zoo 3", PNG, 2048))
        ])
      ; FolderItem (Folder "Photos 2016",
        [ FileItem (File ("description 2016", DOC, 512))
        ; FileItem (File ("Martine mange une pomme 1", JPG, 2048))
        ; FileItem (File ("Martine mange une pomme 2", JPG, 2048))
        ; FileItem (File ("Martine mange une pomme 3", PNG, 2048))
        ; FileItem (File ("Martine mange une pomme 4", PNG, 2048))
        ])
      ])
    ])

(* toy file system *)
let my_fs2 : fs_item =
  FolderItem (Folder "root",
    [ FolderItem (Folder "Documents",
      [
        FileItem (File ("doc 1", DOC, 32))
      ; FileItem (File ("doc 2", DOC, 64))
      ; FileItem (File ("doc 3", PDF, 1024))
      ; FileItem (File ("doc 4", PDF, 2048))
      ])
    ; FileItem (File ("Documents", DOC, 28))
    ])

(* toy file system *)
let my_fs3 : fs_item =
  FolderItem (Folder "root",
    [ FolderItem (Folder "Documents",
      [
        FolderItem (Folder "Documents",
        [
          FileItem (File ("doc 1", DOC, 32))
        ; FileItem (File ("doc 2", DOC, 64))
        ])
      ; FileItem (File ("doc 1", DOC, 32))
      ; FileItem (File ("doc 2", DOC, 64))
      ])
    ; FileItem (File ("Downloads", DOC, 28))
    ])

(* toy file system (not well-formed)*)
let my_fs4 : fs_item =
  FolderItem (Folder "root",
    [ FolderItem (Folder "Documents",
      [
        FileItem (File ("doc 1", DOC, 32))
      ; FileItem (File ("doc 2", DOC, 64))
      ; FileItem (File ("doc 1", PDF, 1024))
      ; FileItem (File ("doc 2", PDF, 2048))
      ])
    ; FolderItem (Folder "Documents",[])
    ])

(* toy file system (not well-formed)*)
let my_fs5 : fs_item =
  FolderItem (Folder "root",
    [ FolderItem (Folder "Documents",
      [
        FileItem (File ("doc 1", DOC, 32))
      ; FileItem (File ("doc 1", DOC, 64))
      ; FileItem (File ("doc 3", PDF, 1024))
      ; FileItem (File ("doc 4", PDF, 2048))
      ])
    ; FileItem (File ("Documents", DOC, 28))
    ])

(* toy file system (not well-formed)*)
let my_fs6 : fs_item =
  FolderItem (Folder "root",
    [ FolderItem (Folder "Documents",
      [
        FileItem (File ("doc 1", DOC, 32))
      ; FileItem (File ("doc 1", DOC, 64))
      ])
    ; FileItem (File ("AutresDocuments", DOC, 28))
    ])

let test1 = File ("file 1", DOC, 32)
and test2 = File ("file 2", PNG, 512)
and test3 = File ("file 3", AVI, 4294967296);;

print_string "files my_fs;;";;
files my_fs;;
print_string "\n";;

print_string "folders my_fs;;";;
folders my_fs;;
print_string "\n";;

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

print_string "du my_fs;;";;
du my_fs;;
