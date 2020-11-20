package fr.umlv.fruits;

public enum AppleKind {
    Golden,
    PinkLady,
    GrannySmith;

    @Override
    public String toString() {
        return switch (this) {
            case PinkLady -> "Pink Lady";
            case GrannySmith -> "Granny Smith";
            default -> name();
        };
    }
}