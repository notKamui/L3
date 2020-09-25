public class PrintArgs {
    public static void main(String[] args) {
        // if we try to access args[0] even though there is no argument, it will trigger an IndexOutOfBoundsException
        for(String s: args) {
            System.out.println(s);
        }
    }
}
