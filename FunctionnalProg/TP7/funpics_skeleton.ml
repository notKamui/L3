#load "graphics.cma";;

open Graphics;;

(* Dimensions of the graphical window. *)
let w = 512 and h = 512

(* Type for the representation of functional images. *)
type picture  = int * int -> Graphics.color

(* render f : draw the image `f` on the graphical window. *)
let render (f : picture) =
    open_graph (Printf.sprintf " %dx%d" w h);
    auto_synchronize false;
    for x = 0 to w - 1 do
        for y = 0 to h - 1 do
            set_color (f (x, y));
            plot x y
        done;
        set_color background
    done;
    synchronize ();
    (wait_next_event [Button_down; Key_pressed]) |> ignore; 
    close_graph ()

let from_polar (rho, theta) =
    (int_of_float (rho *. cos theta), int_of_float (rho *. sin theta)) 

let to_polar (x, y) =
    let distance_to_origin (x, y) = sqrt (float_of_int (x * x + y * y)) in
    (distance_to_origin (x, y), atan2 (float_of_int y) (float_of_int x))













