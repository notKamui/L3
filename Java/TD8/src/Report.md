# Report Java TD8 Jimmy Teillard

## Ex 1

1. ```
   in A.printX
   x 1
   getX() 1
   ```
   Because it uses the `printX` of `A`, on an `A`, so x=1, and `getX()` is the one from
   `A`.
   
2. ```
   in B.printX
   x 2
   getX() 2
   ```
   Because it uses the `printX` of `B`, on a `B`, so x=2, and `getX()` is the one from
   `B`.
   
3. ```
   in A.printX
   x 1
   getX() 2
   ```
   This time, the `printX()` is from `A`, that's also why the `x` used is the one from
   `A`, because the parameter is an `A` ; BUT, because we gave it a `B`, it will use
   the `getX()` from `B` that overrode the one from `A`. 
   
4. "1" is printed because this time, the `m()` in `B` is not an override, but an overload, it
   doesn't take the same parameters (a `B` instead of an `A`). Because we used with an
   `A` (even though it's actually a `B`, but polymorphism), it's the `m()` from `A` that
   is used.
   
## Ex 2

See Fruit.java, Apple.java, AppleKind.java, Pear.java, Basket.java