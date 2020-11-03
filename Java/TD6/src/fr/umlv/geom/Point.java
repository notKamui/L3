package fr.umlv.geom;

public class Point {
    private int x;
    private int y;

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public Point(Point point) {
        this.x = point.x;
        this.y = point.y;
    }

    @Override
    public String toString() {
        return "(" + x + "," + y + ")";
    }

    public void translate(int dx, int dy) {
        x += dx;
        y += dy;
    }

    public double distance(Point other) {
        return Math.sqrt((this.x - other.x)*(this.x - other.x) + (this.y - other.y)*(this.y - other.y));
    }
}
