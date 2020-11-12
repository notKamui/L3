package fr.umlv.calc;

import java.util.Iterator;
import java.util.Objects;

public sealed interface Expr  {
    int eval();

    static Expr parse(Iterator<String> cmd) {
        final var token = cmd.next();
        return switch (token) {
            case "+" -> new BinOp.Add(parse(cmd), parse(cmd));
            case "-" -> new BinOp.Sub(parse(cmd), parse(cmd));
            default -> new Value(Integer.parseInt(token));
        };
    }

    record Value(int value) implements Expr {
        @Override
        public int eval() {
            return value;
        }

        @Override
        public String toString() {
            return value + "";
        }
    }

     sealed abstract class BinOp implements Expr {
        Expr left;
        Expr right;

        private BinOp(Expr left, Expr right) {
            this.left = Objects.requireNonNull(left);
            this.right = Objects.requireNonNull(right);
        }

        @Override
        public int eval() {
            return op(left.eval(), right.eval());
        }

        public abstract int op(int a, int b);

        @Override
        abstract public String toString();

        public static final class Add extends BinOp {
            public Add(Expr left, Expr right)  {
                super(left, right);
            }

            @Override
            public int op(int a, int b) {
                return a + b;
            }

            @Override
            public String toString() {
                return "(" + left + " + " + right + ")";
            }
        }

        public static final class Sub extends BinOp {
            public Sub(Expr left, Expr right)  {
                super(left, right);
            }

            @Override
            public int op(int a, int b) {
                return a - b;
            }

            @Override
            public String toString() {
                return "(" + left + " - " + right + ")";
            }
        }
    }
}

