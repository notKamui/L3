public class Main {
    private int foo;

    public Main(int foo) {
        this.foo = foo;
    }

    public static void main(String[] args) {
        /*System.out.println("Hello IntelliJ");
        var a = 2 + 3 + 4;
        var integer = new Integer(2);
        String s;*/

        var lib = new Library();
        lib.add(new Book("Bakemonogatari", "nisioisin"));
        lib.add(new Book("Coraline", "Neil Gaiman"));
        lib.add(new Book("Nisemonogatari", "nisioisin"));
        System.out.println(lib.findByTitle("Bakemonogatari"));
        System.out.println();
        System.out.println(lib);
        System.out.println();
        lib.removeAllBooksFromAuthor("nisioisin");
        System.out.println(lib);
        System.out.println();
    }

    @Override
    public String toString() {
        return super.toString();
    }

    public int getFoo() {
        return foo;
    }

    public void setFoo(int foo) {
        this.foo = foo;
    }
}
