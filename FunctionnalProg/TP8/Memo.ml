let memo f =
    let m = ref [] in
    fun x ->
        try
            List.assoc x !m
        with
            Not_found ->
                let y = f x in
                m := (x, y) :: !m;
                y
