# Report Java TD 9 Jimmy Teillard

## Ex 1

1) `Link` must be package private (default visibility).

2) `java --enable-preview fr.umlv.data.Link`

3) See LinkedLink.java.

## Ex 2

1) If the index is invalid, and `IndexOutOfBoundException` should be thrown.

2) See Link.java, LinkedLink.java.

3) See Main.java

4) In this case, the list cannot know if what is in it are Strings or not ; thus, the method `.length()`
   is not available, unless we explicitly say to the compiler with a cast that it's a String.\
   The issue with this solution is that nothing prevents the user from using classes that are NOT
   castable into a String, which will cause a `ClassCastException`.
   
## Ex 3

1) A generic type will prevent the issue explained above by explicitly declaring the type of the list
   before any insertion.
   
2) See LinkedLink.java

3) See Main.java

4) `.contains()` should receive an `Object` in the special case there's inheritance going on.\
   For example a class `Apple` extends `Fruit`:
   ```Java
   var list = new LinkedLink<Apple>();
   list.add(new Apple("foo"));
   Fruit fruit = new Apple("foo");
   System.out.println(list.contains(fruit));
   ```
   Here, this situation must return `true`, though if we chose `.contains()` to receive a `T`, this
   situation wouldn't even compile, because Fruit is not a subtype of Apple, even though a Fruit may
   contain an Apple.