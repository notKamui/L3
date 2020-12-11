package fr.umlv.monopoly;

public sealed interface Asset permits Hotel, Apartment {
    int profitPerNight();
    double efficiency();
}
