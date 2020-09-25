import java.util.Scanner; // imports the Scanner class in the classpath (like an alias) so that we can instantiate a Scanner to use its methods

public class Calc {
    public static void main(String[] args) {
        var scanner = new Scanner(System.in); // scanner is of type Scanner

        System.out.print("a = ");
        var firstVal = scanner.nextInt(); // firstVal is of type int // nextInt() is accessed on an instance of Scanner, not the class itself, therefore it's a method, not a function
        System.out.print("b = ");
        var secondVal = scanner.nextInt(); // secondVal is of type int

        System.out.println(
                "a + b = " + (firstVal + secondVal) +
                "\na - b = " + (firstVal - secondVal) +
                "\na * b = " + (firstVal * secondVal) +
                "\na / b = " + (firstVal / secondVal) +
                "\na % b = " + (firstVal % secondVal));
    }
}