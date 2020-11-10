package fr.umlv.calc.main;

import fr.umlv.calc.Expr;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Expr expr3 = Expr.parse(new Scanner("+ - 2 3 5"));
        System.out.println(expr3.eval());
        System.out.println(expr3);
    }
}
