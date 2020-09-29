public class Ex1 {
    public static void main(String[] args) {
        var s = "toto";
        System.out.println(s.length());

        var s1 = "toto";
        var s2 = s1;
        var s3 = new String(s1);
        System.out.println(s1 == s2);
        System.out.println(s1 == s3);

        var s4 = "toto";
        var s5 = new String(s4);
        System.out.println(s4.equals(s5));

        var s6 = "toto";
        var s7 = "toto";
        System.out.println(s6 == s7);

        var s8 = "hello";
        s8.toUpperCase();
        System.out.println(s8);
    }
}
