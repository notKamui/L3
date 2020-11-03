package fr.umlv.geom;

public class Ring extends Circle {
    private int inRadius;

    public Ring(Point center, int radius, int inRadius) {
        super(center, radius);
        if (inRadius < 0) throw new IllegalArgumentException("A radius must be positive");
        if (inRadius > radius) throw new IllegalArgumentException("The inward radius must be smaller or equal to the outward radius");
        this.inRadius = inRadius;
    }

    @Override
    public String toString() {
        return super.toString() + " ; inward radius : " + inRadius;
    }

    @Override
    public double surface() {
        return super.surface() - (Math.PI * (inRadius * inRadius));
    }

    @Override
    public boolean contains(Point p) {
        return super.contains(p) && (p.distance(center()) >= inRadius); // is in the big circle AND out the small circle
    }

    public static boolean contains(Point p, Ring... rings) {
        for (Ring ring : rings) {
            if (ring.contains(p)) return true;
        }
        return false;
    }

    public void setInRadius(int inRadius) {
        this.inRadius = inRadius;
    }
}
