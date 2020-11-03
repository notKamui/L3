package fr.umlv.geom.main;

import fr.umlv.geom.Circle;
import fr.umlv.geom.Point;
import fr.umlv.geom.Ring;

public class Main {
    public static void main(String[] args) {
        var point = new Point(1, 2);
        var circle = new Circle(point, 1);

        var circle2 = new Circle(point, 2);
        circle2.translate(1, 1);

        System.out.println(circle + "\n" + circle2);

        var p = new Point(1, 2);
        var c = new Circle(p, 1);
        var p2 = c.center();
        p2.translate(1, 1);
        System.out.println(c);

        var point_ = new Point(1, 2);
        var circle_ = new Circle(point_, 2);
        System.out.println(circle_);
        var ring = new Ring(point_, 2, 1);
        System.out.println(ring);
    }
}
