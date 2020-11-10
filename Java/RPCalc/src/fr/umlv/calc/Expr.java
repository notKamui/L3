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

    sealed interface BinOp extends Expr {
        @Override
        default int eval() {
            return left().eval() + right().eval();
        }

        Expr left();
        Expr right();

        record Add(Expr left, Expr right) implements BinOp {
            public Add {
                Objects.requireNonNull(left);
                Objects.requireNonNull(right);
            }

            @Override
            public String toString() {
                return "(" + left + " + " + right + ")";
            }
        }

        record Sub(Expr left, Expr right) implements BinOp {
            public Sub {
                Objects.requireNonNull(left);
                Objects.requireNonNull(right);
            }

            @Override
            public String toString() {
                return "(" + left + " - " + right + ")";
            }
        }
    }
}

