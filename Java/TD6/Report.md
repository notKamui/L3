# Report Java TD 6

## Ex 1

1) In this current state, the record `Point` cannot compile because translate tries to
   modify the `x` and `y` fields, which is not possible since they are final
   (because it's a record)\
   There are two possibilities : either we keep Point immutable, and we need `translate()` to
   return a new cloned Point ; OR we make Point a mutable class, in which case the current
   implementation of `translate()` is fine.\
   I'd personally choose to make it immutable, since a point is unique, and, in geometry,
   translating a point is NOT "moving a point" (it's multiplying it by translation vector
   and getting a new point)
   
2) In this case, for the sake of consistency, we should make `Circle` mutable
   (as in, a regular class)\
   If at any moment we choose to change the radius of a circle, we should be able to do
   so with the same behavior as `Point`.
   
3) See Circle.java

4) See Circle.java

5) See Circle.java

6) "[center : (2,3) ; radius : 1][center : (2,3) ; radius : 2]" is printed.
   Indeed, we gave the same reference to both circles for their center ; modifying
   one is effectively the same as modifying both.\
   To fix that, we can create a clone constructor in `Point` so that in `Circle` we
   create a new instance of point to put it as a center (defensive copy/clone).
   
7) Same as before, `center()` should return a clone (a new instance)

8) See Circle.java

9) See Circle.java

10) "..." after the type of an argument means that it's a varargs.
    It is manipulated the same way as an array.
    
## Ex 2

1) Inheritance is something to consider when we want to avoid the duplication of code
   AND that the inherited class has a valid semantic link with the class that inherits.
   
2) See Ring.java

3) If inRadius is greater than radius, we should throw an IllegalArgumentException

4) The surface of a ring is wrong, 
   because we should subtract the surface of the inside circle.
   (Override `surface()`)

  
1) See Ring.java

2) See Ring.java

3) Mutability, in some case, is really hard and cumbersome to work with because we need
   defensive copies everywhere.