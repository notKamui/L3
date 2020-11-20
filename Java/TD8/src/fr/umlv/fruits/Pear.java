package fr.umlv.fruits;

public record Pear(int juiceFactor) implements Fruit {
    public Pear {
        if (juiceFactor < 0 || juiceFactor > 9) {
            throw new IllegalArgumentException("juiceFactor must be between 1 and 9");
        }
    }

    @Override
    public int price() {
        return 3 * juiceFactor;
    }

    @Override
    public String toString() {
        return "Pear " + juiceFactor + " j";
    }
}
