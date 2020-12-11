package fr.umlv.monopoly.main;

import fr.umlv.monopoly.Apartment;
import fr.umlv.monopoly.AssetManager;
import fr.umlv.monopoly.Hotel;

import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        var hotel = new Hotel(5, .75f);
        var apartment = new Apartment(30, List.of("Bony", "Clyde"));
        var manager = new AssetManager();
        manager.add(hotel);
        manager.add(apartment);
        System.out.println(manager.profitPerNight());
        System.out.println(manager);
    }
}
