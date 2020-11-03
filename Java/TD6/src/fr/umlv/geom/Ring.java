package fr.umlv.geom;

public class Ring extends Circle {
    private final int inRadius;

    public Ring(Point center, int radius, int inRadius) {
        super(center, radius);
        if (inRadius < 0) throw new IllegalArgumentException("A radius must be positive");
        if (inRadius > radius) throw new IllegalArgumentException("The inner radius must be smaller or equal to the outward radius");
        this.inRadius = inRadius;
    }

    @Override
    public String toString() {
        return super.toString() + " ; inner radius : " + inRadius;
    }

    @Override
    public double surface() {
        return super.surface() - Math.PI * inRadius * inRadius;
    }

    @Override
    public boolean contains(Point p) {
        var distance = distanceToCenter(p);
        return distance <= radius() && distance >= inRadius; // is in the big circle AND out the small circle
    }

    public static boolean contains(Point p, Ring... rings) {
        return Circle.contains(p, rings);
    }
}
