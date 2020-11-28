package fr.umlv.data;

import java.util.Objects;

public class LinkedLink<T> {
    /**
     * The head of the list
     */
    private Link<T> head;

    /**
     * The size of the list
     */
    private int size;

    /**
     * Adds a new value on the head of the list
     *
     * @param value the value to add
     */
    public void add(T value) {
        Objects.requireNonNull(value);
        head = new Link<>(value, head);
        size++;
    }

    /**
     * Gets an element at a given index
     *
     * @param index the index of the element
     * @return the element at the index
     */
    public T get(int index) {
        if (index >= size || index < 0) {
            throw new IndexOutOfBoundsException();
        }

        var current = head;
        for (int repeat = 0; repeat < index; repeat++) {
            current = current.next();
        }
        return current.value();
    }

    /**
     * Checks whether an object is in the list or not.
     *
     * @param o the object to check
     * @return true if the object is in the list, false otherwise
     */
    public boolean contains(Object o) {
        Objects.requireNonNull(o);
        for (var current = head; current != null; current = current.next()) {
            if (o.equals(current.value())) {
                return true;
            }
        }
        return false;
    }

    /**
     * All the elements of the list.
     *
     * @return a string of the elements in the list
     */
    public String toString() {
        var strBuilder = new StringBuilder().append("[ ");
        for (var current = head; current != null; current = current.next()) {
            strBuilder.append(current).append(current.next() == null ? " " : ", ");
        }
        return strBuilder.append("]").toString();
    }
}
