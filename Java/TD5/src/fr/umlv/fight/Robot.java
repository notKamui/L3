package fr.umlv.fight;

/**
 * This class represents a combat robot.
 * A robot has a name and health points (which start out at 10)
 *
 * @author Jimmy 'notkamui' Teillard
 */
public class Robot {
    private final String name;
    int hp;

    /**
     * Robot constructor.
     *
     * @param name is the name of the robot.
     */
    public Robot(String name) {
        this.name = name;
        this.hp = 10;
    }

    /**
     * Is the robot dead ?
     *
     * @return the status of the robot as boolean. (Dead or alive)
     */
    public boolean isDead() {
        return hp <= 0;
    }

    /**
     * Shoots another robot for 2 hp.
     *
     * @param other is the other robot.
     */
    public void fire(Robot other) {
        if (other.isDead()) throw new IllegalStateException(other + " is already dead");

        if (rollDice()) {
            other.hp -= 2;
            System.out.println(other + " has been shot by " + this);
        } else {
            System.out.println(this + " missed " + other);
        }
    }

    /**
     * Rolls a dice.
     *
     * @return true if successful
     */
    boolean rollDice() {
        return true;
    }

    /**
     * The static name
     *
     * @return the static name.
     */
    String staticName() {
        return "Robot";
    }

    /**
     * Formatted robot's name.
     *
     * @return the formatted name of the robot
     */
    @Override
    public String toString() {
        return staticName() + " " + name;
    }
}
