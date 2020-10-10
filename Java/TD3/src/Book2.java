import java.util.Objects;

public class Book2 {
    private final String title;
    private final String author;

    public Book2(String title, String author) {
        this.title = title;
        this.author = author;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Book2 book2 = (Book2) o;
        return Objects.equals(title, book2.title) && Objects.equals(author, book2.author);
    }

    @Override
    public int hashCode() {
        return Objects.hash(title, author);
    }

    public static void main(String[] args) {
        var book1 = new Book2("Da Vinci Code", "Dan Brown");
        var book2 = new Book2("Da Vinci Code", "Dan Brown");
        System.out.println(book1.equals(book2));
    }
}
