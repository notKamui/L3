package fr.umlv.fight;

/**
 * Arena consists of static functions to make robots battle each other.
 *
 * @author Jimmy 'notkamui' Teillard
 */
public final class Arena {
    /**
     * An arena should not be instantiated.
     */
    private Arena() {}

    /**
     * Make two robots fight each other.
     *
     * @param r1 is the first robot.
     * @param r2 is the second robot.
     * @return the winner of the fight.
     */
    public static Robot fight(Robot r1, Robot r2) {
        Robot winner;

        while (true) {
            r1.fire(r2);
            if (r2.isDead()) {
                winner = r1;
                break;
            }

            r2.fire(r1);
            if (r1.isDead()) {
                winner = r2;
                break;
            }
        }

        return winner;
    }
}
