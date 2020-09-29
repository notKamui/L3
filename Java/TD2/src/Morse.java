public class Morse {
    public static void main(String[] args) {
        for (String arg : args) {
            System.out.print(arg + " Stop. ");
        }
        System.out.println();

        for (String arg : args) {
            System.out.print(
                    new StringBuilder()
                            .append(arg)
                            .append(" Stop. ")
                            .toString()
            );
        }
        System.out.println();

        var first = args[0];
        var second = args[1];
        var last = args[2];
        System.out.println(first + ' ' + second + ' ' + last);
    }
}
