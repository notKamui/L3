# Report Java TD2

## Ex 1

1. `s` is of type `String`. `.length()` is a method of `String` ; so in this case, because of `s`'s type,
   the compiler knows that it's the method `String.length()`.

2. Prints `true` then `false` ; indeed the `==` operator compares only the reference in the case of instances
   of objects (which is the case here). In the first case, `s1` and `s2` have the same reference since we 
   declared `var s2 = s1`. In the second case, `s1` and `s3` since the latter has been constructed
   with a `new String()`.

3. To compare the content of two `String`s, we should use the method `Object.equals(Object other)`. 
   (`String`'s implementation of this method knows that it should compare each character)

4. All strings generated by the compiler are *interned*. So the result is that `s6` and `s7` point to the same
   string instance, and so `==` returns `true`.
   
5. Because Java uses string literals, immutability is necessary not to affect the generated strings.

6. Since `s8` is a `String`, and that they are immutable by definition, no method should be able to modify
   one. `String.toUpperCase()` is no exception ; it only **returns** a **copy** of the string to upper case.
   
## Ex2

1. See Morse.java

2. `StringBuilder` is used to easily build and manipulate strings. `StringBuilder.append()` returns a
   `StringBuilder` so that we can chain another method right after it.
   
3. The main goal of this solution is to ensure the immutability of strings, and to build on top of string literals
   more cleanly without creating clones everytime.
   
4. We can use single quotes there because single quotes are used to declare characters (not strings), which is the 
   case here with the character ` ` (space).
   `// InvokeDynamic #0:makeConcatWithConstants:(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;`
   -> `javap` returned this line, meaning that those spaces were considered as constants and that the compiler knew 
   how to optimize all the `+`s in one operation instead of creating multiple instances everytime. 
   Good compiler ! ***pat pat***
   
5. When we want to concatenate multiple strings together in one instance *in a loop*, whe shouldn't chain `+` operators 
   and instead use `StringBuilder.append()` because it consumes less memory. Also, I'm probably going to die if I 
   use a `+` in an `.append()`because it defies the very purpose of the latter and immutability.
   
## Ex 3

1. `Pattern` and `Pattern.compile()` are used to create and compile a regular expression, while `Matcher` uses this 
   regex to apply checks on strings.
   
2. `[0-9]+`

3. `[^0-9]*[0-9]+` + `.replaceAll("[^0-9]", "")`

4. See Parser.java ; /!\\ byte is signed (`Byte.MAX_VALUE == 127`) **//still think it's bad design//**