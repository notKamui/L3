package fr.umlv.fruits;

import java.util.*;

public class Basket {
    private final HashMap<Fruit, Integer> basket;

    public Basket() {
        basket = new HashMap<>();
    }

    public void add(Fruit fruit) {
        add(fruit, 1);
    }

    public void add(Fruit fruit, int amount) {
        Objects.requireNonNull(fruit);
        if (amount < 0) {
            throw new IllegalArgumentException("amount must be over 0");
        }
        basket.put(
                fruit,
                basket.getOrDefault(fruit, 0) + amount
        );
    }

    public int totalPrice() {
        var totalPrice = 0;
        for (var entry : basket.entrySet()) {
            totalPrice += entry.getKey().price() * entry.getValue();
        }
        return totalPrice;
    }

    @Override
    public String toString() {
        StringBuilder str = new StringBuilder();
        for (Fruit fruit : basket.keySet()) {
            str.append(fruit).append(" x ").append(basket.get(fruit)).append("\n");
        }
        return str.append("price : ").append(totalPrice()).toString();
    }
}
