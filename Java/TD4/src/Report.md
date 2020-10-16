> **!Disclamer!** : I will be using IntelliJ IDEA throughout this assignment
> because I am much more familiar and efficient with it than with Eclipse.
> (I have used Eclipse and NetBeans in the past for reference)
> For the questions that use Eclipse specific syntax, I will translate it accordingly.

# Report TD4 Java

## Ex 1

1) (`sout` + TAB) in a function = `System.out.println();`

2) (`tos` + TAB) in a class = 
    ```Java
    @Override
    public String toString() {
        return super.toString();
    }
    ```

3) (`get` + TAB) and (`set` + TAB) in a class will show suggestions for getters/setters
    for the available attributes.
   ```Java
   public int getFoo() {
       return foo;
   }
    
   public void setFoo(int foo) {
       this.foo = foo;
   }
   ```
   
4) (ALT + INSERT > Constructor) generates a basic constructor with the chosen attributes.

5) (Shift + F6) refactor-renames an identifier in the whole project.

6) (CTRL + ALT + V) introduces a new variable containing the highlighted elements
    AND replaces the latter with the variable.
    
7) (CTRL + ALT + V) introduces a new variable containing the previous inlined expression.

8) (CTRL + LEFT_CLICK) on a class reference shows the content of said class.

9) (CTRL + LEFT_CLICK) on a method call shows the said function in its class.

10) (ALT + F7) on a variable finds all its references.

11) No need for that shortcut : IntelliJ auto imports and optimizes everything.

12) (CTRL + /) comments the highlighted area.
    (CTRL + SHIFT + /) block-comments the highlighted area.
    
## Ex 2

1) See Library.java.

2) "Contents of collection 'books' are updated, but never queried".
   That means that we never try to access any book in the List ;
   We either need a getter, or any function to fetch its content.

3) See Library.java

4) 
    ```
    public Book findByTitle(java.lang.String);
        Code:
           0: aload_0
           1: getfield      #10                 // Field books:Ljava/util/List;
           4: invokeinterface #30,  1           // InterfaceMethod java/util/List.iterator:()Ljava/util/Iterator;
           9: astore_2
          10: aload_2
          11: invokeinterface #34,  1           // InterfaceMethod java/util/Iterator.hasNext:()Z
          16: ifeq          45
          19: aload_2
          20: invokeinterface #40,  1           // InterfaceMethod java/util/Iterator.next:()Ljava/lang/Object;
          25: checkcast     #22                 // class Book
          28: astore_3
          29: aload_3
          30: invokevirtual #44                 // Method Book.title:()Ljava/lang/String;
          33: aload_1
          34: invokevirtual #48                 // Method java/lang/String.equals:(Ljava/lang/Object;)Z
          37: ifeq          42
          40: aload_3
          41: areturn
          42: goto          10
          45: aconst_null
          46: areturn
    ```
    An Iterator goes through the List while `hasNext()` is still true to get each instance of `Book`
    
5) `findByTitle()` should not raise an NPE because we want to handle the case where there is
    simply no book that goes by an X name in the library. In a way, this is literally not
    an exception, but a regular case.
    
6) See Library.java

## Ex 3

1) `findByTitle()` has an O(n) time complexity because in the worst case scenario it has
    to go through the whole list.
    
2) HashMap is an implementation of a Map(/assiociative array, dictionary) based on a
    hashtable.
    To better the performance of `findByTitle()`, we can replace `List<Book> books`
    by a `HashMap<String, String>` (title->author), making the time complexity O(1).
    
3) See Library.java

4) In this particular case, the structure isn't similar to the representation ; 
    so we don't want to be able to access the map from the exterior, hence why we don't
    want Library to be a record either (because it would automatically create a getter).
    
5) To cycle through the map, we can use the method `.keySet()`

6) Replacing the type of the map by a LinkedHashMap will suffice : 
    it keeps the order of insertion.
    
7) A `ConcurrentModificationException` is raised because we CANNOT modify the content of
    a structure inside a foreach.
    
8) See Library.java

9) See Library.java