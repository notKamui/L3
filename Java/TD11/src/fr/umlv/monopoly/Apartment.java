package fr.umlv.monopoly;

import java.util.List;
import java.util.Objects;

public record Apartment(int area, List<String> residents) implements Asset {
    public Apartment {
        Objects.requireNonNull(residents);
        if (area <= 0) {
            throw new IllegalArgumentException("Apartment area must over 0");
        }
        if (residents.isEmpty()) {
            throw new IllegalArgumentException("Apartment must contain at least one resident");
        }
        residents = List.copyOf(residents);
    }

    public double efficiency() {
        return residents.size() == 1 ? .5f : 1f;
    }

    @Override
    public String toString() {
        return "Apartment " + area + " m2 " + String.join(", ", residents) + " " + efficiency();
    }

    @Override
    public int profitPerNight() {
        return 20 * residents.size();
    }
}
