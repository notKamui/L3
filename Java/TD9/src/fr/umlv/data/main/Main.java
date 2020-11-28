package fr.umlv.data.main;

import fr.umlv.data.LinkedLink;

public class Main {
    public static void main(String[] args) {
        var list = new LinkedLink<String>();
        list.add("aaa");
        list.add("bbbbb");
        list.add("cc");
        System.out.println(list);
        System.out.println(list.get(1).length());
        System.out.println(list.contains("aaa"));
    }
}
