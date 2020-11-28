package fr.umlv.data;

record Link<T>(T value, Link<T> next) {
    public static void main(String[] args) {
        var link1 = new Link<>(13, null);
        var link2 = new Link<>(144, link1);
    }

    @Override
    public String toString() {
        return value.toString();
    }
}
