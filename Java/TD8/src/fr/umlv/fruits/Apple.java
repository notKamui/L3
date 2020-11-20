package fr.umlv.fruits;

import java.util.Objects;

public record Apple(int weight, AppleKind kind) implements Fruit {
    public Apple {
        Objects.requireNonNull(kind);
        if (weight <= 0) {
            throw new IllegalArgumentException("weight must be over 0");
        }
    }

    @Override
    public int price() {
        return weight / 2;
    }

    @Override
    public String toString() {
        return kind + " " + weight + " g";
    }
}
