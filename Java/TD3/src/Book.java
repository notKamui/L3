import java.util.Objects;

public record Book(String title, String author) {
    /*
    public Book(String title, String author) {
        this.title = Objects.requireNonNull(title);
        this.author = Objects.requireNonNull(author);
    }
    */

    public Book {
        Objects.requireNonNull(title);
        Objects.requireNonNull(author);
    }

    public Book(String title) {
        this(title, "<no author>");
    }

    /*
    public void withTitle(String title) {
        this.title = title;
    }
    */

    public Book withTitle(String title) {
        return new Book(title, this.author);
    }

    public boolean isFromTheSameAuthor(Book other) {
        return this.author.equals(other.author);
    }

    @Override
    public String toString() {
        return title + " by " + author;
    }
}
