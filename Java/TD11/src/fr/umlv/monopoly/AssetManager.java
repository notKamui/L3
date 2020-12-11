package fr.umlv.monopoly;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class AssetManager {
    private final ArrayList<Asset> assets = new ArrayList<>();

    public void add(Asset asset) {
        Objects.requireNonNull(asset);
        assets.add(asset);
    }

    public int profitPerNight() {
        return assets.stream().mapToInt(Asset::profitPerNight).sum();
    }

    public List<Asset> lowestEfficiency(double limit) {
        if (limit < 0 || limit > 1) {
            throw new IllegalArgumentException("limit is a rate, as such it must be between 0 and 1");
        }
        return assets.stream()
                .filter(asset -> asset.efficiency() <= limit)
                .collect(Collectors.toList());
    }

    public void remove(double limit) {
        if (limit < 0 || limit > 1) {
            throw new IllegalArgumentException("limit is a rate, as such it must be between 0 and 1");
        }
        //assets.removeAll(lowestEfficiency(limit));
        assets.removeIf(asset -> asset.efficiency() <= limit);
    }

    @Override
    public String toString() {
        return assets.stream().map(Asset::toString).collect(Collectors.joining("\n"));
    }
}
