package fr.umlv.geom;

import java.util.Objects;

public class Circle {
    private final Point center;
    private int radius;

    public Circle(Point center, int radius) {
        if (radius < 0) throw new IllegalArgumentException("A radius must be positive");

        this.center = new Point(Objects.requireNonNull(center));
        this.radius = radius;
    }

    @Override
    public String toString() {
        return "center : " + center + " ; radius : " + radius + " ; surface : " + surface();
    }

    public void translate(int dx, int dy) {
        center.translate(dx, dy);
    }

    public Point center() {
        return new Point(center);
    }

    public double surface() {
        return Math.PI * (radius * radius);
    }

    public boolean contains(Point p) {
        return p.distance(center) <= radius;
    }

    public static boolean contains(Point p, Circle... circles) {
        for (Circle circle : circles) {
            if (circle.contains(p)) return true;
        }
        return false;
    }

    public void setRadius(int radius) {
        this.radius = radius;
    }
}
