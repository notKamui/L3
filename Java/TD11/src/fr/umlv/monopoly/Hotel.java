package fr.umlv.monopoly;

public record Hotel(int rooms, double efficiency) implements Asset {
    public Hotel {
        if (rooms < 1) {
            throw new IllegalArgumentException("A hotel must contain at least 1 room");
        }
        if (efficiency < 0 || efficiency > 1) {
            throw new IllegalArgumentException("A hotel's efficiency is a rate, as such it must be between 0 and 1");
        }
    }

    @Override
    public String toString() {
        return "Hotel " + rooms + " rooms " + efficiency;
    }

    @Override
    public int profitPerNight() {
        return (int)(100 * rooms * efficiency);
    }
}
