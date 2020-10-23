package fr.umlv.fight;

import java.util.Random;

/**
 * A fighter is a human that can fight.
 *
 * @author Jimmy 'notkamui' Teillard
 */
public class Fighter extends Robot {
    private final Random rng;

    /**
     * Fighter constructor.
     *
     * @param name is the name of the fighter.
     * @param seed is the seed of an RNG
     */
    public Fighter(String name, long seed) {
        super(name);
        rng = new Random(seed);
    }

    /**
     * Rolls a dice.
     *
     * @return true if successful
     */
    @Override
    boolean rollDice() {
        return rng.nextBoolean();
    }


    /**
     * Formatted robot's name.
     *
     * @return the formatted name of the robot
     */
    @Override
    String staticName() {
        return "Fighter";
    }
}
