#include "../include/model.h"

void new_board(Board *board) {
    int i, j; /* loop indices */

    /* double loop to go through each square and set its value */
    for (j = 0; j < LIN; j++) {
        for (i = 0; i < COL; i++) {
            ((board->content)[j][i]).x = i;
            ((board->content)[j][i]).y = j;
        }
    }
}

void refresh_void_square(Board board, int *x, int *y) {
    int i, j; /* loop indices */
    Square square; /* tmp square */
    int found; /* boolean found void square */

    /* double loop to check each square; stops when void square is found */
    found = 0;
    for (j = 0; j < LIN && !found; j++) {
        for (i = 0; i < COL && !found; i++) {
            square = board.content[j][i];
            if (square.x == COL - 1 && square.y == LIN - 1) { /* is the void square aka the last square ? */
                *x = i;
                *y = j;
                found = 1;
            }
        }
    }
}

int is_solved(Board board) {
    int i, j; /* loop indices */
    Square square; /* tmp square */

    /* double loop to check if the board is solved */
    for (j = 0; j < LIN; j++) {
        for (i = 0; i < COL; i++) {
            square = board.content[j][i];
            if (square.x != i || square.y != j) { /* is it incorrectly placed ? */
                return 0; /* not solved */
            }
        }
    }

    return 1; /* solved */
}

int move_left(Board *board) {
    Square square; /* tmp square */
    int i, j;

    refresh_void_square(*board, &i, &j);
    if (i > 0) {
        square = board->content[j][i-1];
        board->content[j][i-1] = board->content[j][i];
        board->content[j][i] = square;
        return 1;
    }

    return 0;
}

int move_right(Board *board) {
    Square square; /* tmp square */
    int i, j;

    refresh_void_square(*board, &i, &j);
    if (i < LIN - 1) {
        square = board->content[j][i+1];
        board->content[j][i+1] = board->content[j][i];
        board->content[j][i] = square;
        return 1;
    }

    return 0;
}

int move_up(Board *board) {
    Square square; /* tmp square */
    int i, j;

    refresh_void_square(*board, &i, &j);
    if (j > 0) {
        square = board->content[j-1][i];
        board->content[j-1][i] = board->content[j][i];
        board->content[j][i] = square;
        return 1;
    }

    return 0;
}

int move_down(Board *board) {
    Square square; /* tmp square */
    int i, j;

    refresh_void_square(*board, &i, &j);
    if (j < COL - 1) {
        square = board->content[j+1][i];
        board->content[j+1][i] = board->content[j][i];
        board->content[j][i] = square;
        return 1;
    }

    return 0;
}