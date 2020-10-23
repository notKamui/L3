import fr.umlv.fight.Arena;
import fr.umlv.fight.Fighter;
import fr.umlv.fight.Robot;

public class Main {
    public static void main(String[] args) {
        var bob = new Robot("bob");
        System.out.println(bob);

        var d2r2 = new Robot("D2R2");
        var data = new Robot("Data");
        System.out.println(Arena.fight(d2r2, data) + " wins");

        System.out.println();

        var john = new Fighter("John", 1);
        var jane = new Fighter("Jane", 2);
        System.out.println(Arena.fight(john, jane) + " wins");

    }
}
