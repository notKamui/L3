#ifndef MODEL
#define MODEL

#include "MLV/MLV_all.h"

#define COL 4
#define LIN 4

typedef struct square {
    int x;
    int y;
} Square;

typedef struct board {
    Square content[COL][LIN];
} Board;

/**
 * Initializes a new board
 * 
 * @param board the board to initialize
 */
void new_board(Board *board);

/**
 * Refreshes the coordinates of the void square
 * 
 * @param board the board
 * @param x the x coordinate of the void square to refresh
 * @param y the y coordinate of the void square to refresh
 */
void refresh_void_square(Board board, int *x, int *y);

/**
 * Is the board solved ?
 * 
 * @param board the board to check
 */
int is_solved(Board board);

/**
 * Moves the void square up
 * 
 * @param board the board
 * 
 * @return 0 if the move is impossible
 */
int move_up(Board *board);

/**
 * Moves the void square down
 * 
 * @param board the board
 * 
 * @return 0 if the move is impossible
 */
int move_down(Board *board);

/**
 * Moves the void square left
 * 
 * @param board the board
 * 
 * @return 0 if the move is impossible
 */
int move_left(Board *board);

/**
 * Moves the void square right
 * 
 * @param board the board
 * 
 * @return 0 if the move is impossible
 */
int move_right(Board *board);

#endif