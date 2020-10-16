import java.util.*;

public class Library {
    /*private final List<Book> books;

    public Library() {
        books = new ArrayList<>();
    }

    public void add(Book book) {
        books.add(Objects.requireNonNull(book));
    }

    public Book findByTitle(String title) {
        for (Book book : books) {
            if (book.title().equals(title))
                return book;
        }
        return null;
    }

    @Override
    public String toString() {
        var str = new StringBuilder();
        books.forEach(book -> str.append(book).append('\n'));
        return str.toString();
    }*/

    private final Map<String, String> titleToAuthor;

    public Library() {
        titleToAuthor = new LinkedHashMap<>();
    }

    public void add(Book book) {
        titleToAuthor.put(book.title(), book.author());
    }

    public Book findByTitle(String title) {
        return new Book(title, titleToAuthor.get(title));
    }

    public void removeAllBooksFromAuthor(String author) {
        /*for (String title : titleToAuthor.keySet()) {
            if (titleToAuthor.get(title).equals(author)) {
                titleToAuthor.remove(title);
            }
        }*/

        /*final var iter = titleToAuthor.keySet().iterator();
        while (iter.hasNext()) {
            if (titleToAuthor.get(iter.next()).equals(author)) {
                iter.remove();
            }
        }*/

        titleToAuthor.keySet().removeIf(str -> titleToAuthor.get(str).equals(author));
    }

    @Override
    public String toString() {
        var str = new StringBuilder();
        for (String title : titleToAuthor.keySet()) {
            str.append(findByTitle(title)).append('\n');
        }
        return str.toString();
    }
}
