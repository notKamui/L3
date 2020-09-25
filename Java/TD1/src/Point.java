// javac --enable-preview -source 15 Point.java

public record Point(int xCoord, int yCoord) {
    public final static Point ORIGIN = new Point(0, 0);

    public static void main(String[] args) {
        var xCoord = Integer.parseInt(args[0]); // parseInt() is static because it doesn't need an instance of Integer to be used
        var yCoord = Integer.parseInt(args[1]); // if parseInt()'s argument is not an integer, it will trigger a NumberFormatException (you can't convert a non-Integer to and Integer)

        System.out.println("x=" + xCoord + ", y=" + yCoord);

        var point = new Point(xCoord, yCoord);
        System.out.println(point);
        System.out.println("dist=" + point.distance(ORIGIN));
    }

    public double distance(Point other) {
        return Math.sqrt(
                Math.pow(this.xCoord - other.xCoord, 2) + Math.pow(this.yCoord - other.yCoord, 2)
        );
    }
}
