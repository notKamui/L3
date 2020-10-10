# Report Java TD 3

## Ex 1

1) See Book.java

2) "Da Vinci Code Dan Brown" is printed.
   It works because a record is a data object containing read access to properties
   in addition to built-in equals/hashCode/toString methods based on those.
   
3) We can't access properties of a Book because they're private by default.
   We need to use the provided getters `.title()` and `.author()`.
   
4) We can create a new canonical constructor.

5) See Book.java

6) See Book.java

7) That's what we call function overloading. The compiler knows which constructor to use
   based on the number and types of the given arguments. Hence why we can't create
   two functions that have the same signature (names of params aside)
   
8) Because properties in a record are also final by default, they are immutable.
   That means we need to create clones each time we want to "modify" a Book
   (in the same vein as String does)
   
## Ex 2

1) "true" then "false" are printed, because indeed, `b1` and `b2` share the exact same
   reference, contrary to `b3` which is another instance of Book
   
2) To check whether two Books are structurally similar (as in they have the same content)
   we need to use the built-in `.equals()` method.
   
3) See Book.java

4) We need to add a `.toString()` method to Book

5) See Book.java

6) `@Override` is an annotation. Annotation usually do not impact the resulting bytecode,
   but they do help the compiler (and to some extent, the devs) to understand the structure
   of the code.
   
## Ex 3

1) The problem here is that the default `.equals()` from java.lang.Object has the same
   behavior as the `==` operator (as in, it compares the references/addresses)
   
2) To fix that problem, we need to override this method accordingly
   (along the `.hashCode()` method !)
   
## Ex 4

1) See Sort.java

2) See Sort.java

3) See Sort.java

4) See Sort.java