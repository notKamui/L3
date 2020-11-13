# Report Java TD7 Jimmy Teillard

1. We need to watch out for the canonical constructor of the record which takes every
   parameter and would allow for the creation of an instance that is both a value AND 
   an operator, which is bad.

2. We could use an interface (or heritage in general). It's way better because it allows
   for more modularity, better debugging, and follows the OOP paradigm.
   
3. See Expr.java

4. Added `sealed` modifier.

5. It's kind of nice to put those records in the sealed interface because not only it
   avoids the redundant `permits` clause, it's also a way to have cleaner and better
   semantically organized code.

6. See Expr.java

7. See Expr.java

8. See Main.java

9. We can use Iterator<String>, which is the superclass of List<String> and Scanner.

10. See Expr.java

11. BinOp can only be either an interface, or an abstract class because we don't want
    to be able to instantiate a BinOp. I'd choose an abstract class because it allows
    pulling up the left and right fields.
    
12. If BinOp is an interface, `eval()` should be declared as default to allow its
    definition ; if it's an abstract class, it should just be declared and defined 
    the regular way.\
    If BinOp is an interface, `Expr left();` and `Expr right();` should be declared
    in it so that the default getters of the records override them ; else, pulling
    up the two fields in BinOp is the solution.
    
13. See Expr.java