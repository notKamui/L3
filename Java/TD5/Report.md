# Java Report TD5

# Ex 1

1) In the case of Robot, we cannot use a record because Robot's state is supposed to be mutable.
   Indeed, a robot's HP will get updated eventually.
   
2) See fr.umlv.fight.Robot.

3) See fr.umlv.fight.Robot.

4) See fr.umlv.fight.Arena

# Ex 2

1) A pseudo-random number generator generates an infinite sequence of numbers based on a
   function (a sequence in fact) with a starting point, which we call a seed.
   
2) See fr.umlv.fight.Fighter

3) Fields should always be at least package private because we don't want an external user
   to modify the state of an object with anything other than a method
   (to avoid leaks or unexpected behaviors)
   
4) See fr.umlv.fight.Fighter

5) There's a lot of code redundancy between Robot and Fighter, thus, we need to optimize them.

6) `.rollDice()` should be package private (as in, no modifier keyword), because an external user
   does not need to roll any dice.
   
7) See fr.umlv.fight.Fighter

8) See fr.umlv.fight.Fighter

9) Subtyping/Inheritance is the capacity of class to inherit characteristics of its superclass.
   For example, `Fighter` inherits the fact that `Robot` has a name and HPs, as well as its
   responsibility to shoot on another robot, etc.\
   Polymorphism is the concept of being able to use a subtype of class as if it was its supertype.
   For example, we can have a fighter act the same as a robot with `.fire()` and make a fight
   with `Arena.fight()` with any two fighters, two robots, or even a robot and a fighter, all
   this very indifferently.