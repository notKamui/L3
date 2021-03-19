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
        FileItem (File ("Martine mange une pomme 4", PNG, 2048))])])])

(* toy file system my_fs2 *)
let my_fs2 =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FileItem (File ("doc 1", DOC, 32));
      FileItem (File ("doc 2", DOC, 64));
      FileItem (File ("doc 3", PDF, 1024));
      FileItem (File ("doc 4", PDF, 2048))]);
    FileItem (File ("Documents", DOC, 28))])

(* toy file system my_fs3 *)
let my_fs3 =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FolderItem (Folder "Documents",
       [FileItem (File ("doc 1", DOC, 32));
        FileItem (File ("doc 2", DOC, 64))]);
      FileItem (File ("doc 1", DOC, 32));
      FileItem (File ("doc 2", DOC, 64))]);
    FileItem (File ("Downloads", DOC, 28))])

(* toy file system my_fs4 *)
let my_fs4 =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FileItem (File ("doc 1", DOC, 32));
      FileItem (File ("doc 2", DOC, 64));
      FileItem (File ("doc 1", PDF, 1024));
      FileItem (File ("doc 2", PDF, 2048))]);
    FolderItem (Folder "Documents", [])])

(* toy file system my_fs5 *)
let my_fs5 =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FileItem (File ("doc 1", DOC, 32));
      FileItem (File ("doc 1", DOC, 64));
      FileItem (File ("doc 3", PDF, 1024));
      FileItem (File ("doc 4", PDF, 2048))]);
    FileItem (File ("Documents", DOC, 28))])

(* toy file system my_fs6 *)
let my_fs6 =
  FolderItem (Folder "root",
   [FolderItem (Folder "Documents",
     [FileItem (File ("doc 1", DOC, 32));
      FileItem (File ("doc 1", DOC, 64))]);
    FileItem (File ("AutresDocuments", DOC, 28))])

(* File examples *)
let test1 = File ("file 1", DOC, 32)
let test2 = File ("file 2", PNG, 512)
let test3 = File ("file 3", AVI, 4294967296)