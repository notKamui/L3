/*
C version : .97s
Java version : .25s

Memory management and allocation is more efficient in Java partly because the JVM is already allowed some memory
 */

public class Pascal {
    public static void main(String[] args) {
        System.out.println("Cn, p = " + pascal(30000, 250));
    }

    public static int pascal(int nEnd, int pEnd) {
        var tab = new int[nEnd + 1];
        tab[0] = 1;

        for(var n = 1; n <= nEnd; n++){
            tab[n] = 1;
            for(var i = n - 1; i > 0; i--)
                tab[i] = tab[i-1] + tab[i];
        }

        return tab[pEnd];
    }
}
