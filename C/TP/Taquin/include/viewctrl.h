#ifndef VIEWCTRL
#define VIEWCTRL

#include "MLV/MLV_all.h"
#include "model.h"

/**
 * Displays the main menu
 * 
 * @param width the width of the window
 * @param height the height of the window
 */
void disp_main_menu(int width, int height);

/**
 * Displays the game menu
 * 
 * @param width the width of the window
 * @param height the height of the window
 */
void disp_game_menu(int width, int height);

/**
 * Displays the how to play menu
 * 
 * @param width the width of the window
 * @param height the height of the window
 */
void disp_htp_menu(int width, int height);

/**
 * Displays the control menu
 * 
 * @param width the width of the window
 * @param height the height of the window
 * @param image the image of the window
 */
void menu_ctrl(int width, int height, MLV_Image** image);

/**
 * Displays the game board
 * 
 * @param board the game board
 * @param width the width of the window
 * @param height the height of the window
 * @param image the image of the window
 */
void disp_board(Board board, int width, int height, MLV_Image* image);

/**
 * Gets the the chosen menu on click
 * 
 * @param width the width of the window
 * @param height the height of the window
 * 
 * @return the menu choice
 */
int get_menu_choice(int width, int height);

/**
 * Controls the void square
 * 
 * @param board the board
 * @param key the pressed key
 */
void ctrl_void_square(Board *board, MLV_Keyboard_button key);

/**
 * Scrambles the board
 * 
 * @param board the board
 * @param width the width of the board
 * @param height the height of the board
 * @param image the image of the board
 */
void scramble_board(Board *board, int width, int height, MLV_Image *image);

#endif