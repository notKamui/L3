#include "../include/viewctrl.h"

void disp_main_menu(int width, int height) {
    MLV_draw_rectangle(width/2 - 40, 40, 100, 40, MLV_COLOR_WHITE);
    MLV_draw_text(width/2 - 30, 50, "Play", MLV_COLOR_WHITE);

    MLV_draw_rectangle(width/2 - 40, 120, 100, 40, MLV_COLOR_WHITE);
    MLV_draw_text(width/2 - 35, 130, "How to play", MLV_COLOR_WHITE);

    MLV_draw_rectangle(width/2 - 40, 200, 100, 40, MLV_COLOR_WHITE);
    MLV_draw_text(width/2 - 30, 210, "Quit", MLV_COLOR_WHITE);
}

void disp_game_menu(int width, int height) {
    MLV_draw_rectangle(width/2 - 40, 40, 100, 40, MLV_COLOR_WHITE);
    MLV_draw_text(width/2 - 30, 50, "Level 1", MLV_COLOR_WHITE);

    MLV_draw_rectangle(width/2 - 40, 120, 100, 40, MLV_COLOR_WHITE);
    MLV_draw_text(width/2 - 35, 130, "Level 2", MLV_COLOR_WHITE);

    MLV_draw_rectangle(width/2 - 40, 200, 100, 40, MLV_COLOR_WHITE);
    MLV_draw_text(width/2 - 30, 210, "Back", MLV_COLOR_WHITE);
}

void disp_htp_menu(int width, int height) {
    MLV_draw_text(width/2 - 100, 50, "Solve the puzzle by rearranging it with the arrow keys", MLV_COLOR_WHITE);

    MLV_draw_rectangle(width/2 - 40, 200, 100, 40, MLV_COLOR_WHITE);
    MLV_draw_text(width/2 - 30, 210, "Back", MLV_COLOR_WHITE);
}


void menu_ctrl(int width, int height, MLV_Image** image) {
    int choice;

    disp_main_menu(width, height);
    MLV_actualise_window();
    choice = get_menu_choice(width, height);
    MLV_clear_window(MLV_COLOR_BLACK);

    switch (choice) {
        case 1: /* game menu */
            disp_game_menu(width, height);
            MLV_actualise_window();
            choice = get_menu_choice(width, height);
            MLV_clear_window(MLV_COLOR_BLACK);
            switch (choice) {
                case 1: /* level 1 */
                    *image = MLV_load_image("./resources/level1.jpg");
                    MLV_resize_image(*image, width, height);
                    return;
                case 2: /* level 2 */
                    *image = MLV_load_image("./resources/level2.jpg");
                    MLV_resize_image(*image, width, height);
                    return;
                case 3: /* back */
                    menu_ctrl(width, height, image);
                    return;
            }
            return;
        case 2: /* how to play */
            disp_htp_menu(width, height);
            MLV_actualise_window();
            choice = get_menu_choice(width, height);
            MLV_clear_window(MLV_COLOR_BLACK);
            while (1) {
                if (choice == 3) {
                    break;
                }
            }
            menu_ctrl(width, height, image);
            return;
        case 3: /* quit */
            exit(0);
    }
}

void disp_board(Board board, int width, int height, MLV_Image* image) {
    int i, j; /* loop indices */
    Square square; /* tmp square */
    int squareh, squarew; /* height and width of a square */

    squareh = height/LIN;
    squarew = width/COL;

    /* double loop to display each square */
    for (j = 0; j < LIN; j++) {
        for (i = 0; i < COL; i++) {
            square = board.content[j][i];
            if (square.x == LIN - 1 && square.y == COL - 1) { /* is the void square ? */
                MLV_draw_filled_rectangle(i*squarew, j*squareh, squarew, squareh, MLV_COLOR_BLACK);
            } else {
                MLV_draw_partial_image(image, square.x*squarew, square.y*squareh, squarew-1, squareh-1, i*squarew, j*squareh);
            }
        }
    }
}

int get_menu_choice(int width, int height) {
    int mousex, mousey; /* mouse click coordinates */
    int choice;

    choice = 0;
    while (choice == 0) {
        MLV_wait_mouse(&mousex, &mousey);

        if (
            mousex >= width/2 - 40 &&
            mousex <= width/2 + 60 &&
            mousey >= 40 &&
            mousey <= 80
        ) {
            choice = 1;
        }

        if (
            mousex >= width/2 - 40 &&
            mousex <= width/2 + 60 &&
            mousey >= 120 &&
            mousey <= 160
        ) {
            choice = 2;
        }

        if (
            mousex >= width/2 - 40 &&
            mousex <= width/2 + 60 &&
            mousey >= 200 &&
            mousey <= 240
        ) {
            choice = 3;
        }
    }

    return choice;
}

void ctrl_void_square(Board *board, MLV_Keyboard_button key) {
    switch (key) {
        case MLV_KEYBOARD_UP:
            move_up(board);
            break;
        case MLV_KEYBOARD_DOWN:
            move_down(board);
            break;
        case MLV_KEYBOARD_LEFT:
            move_left(board);
            break;
        case MLV_KEYBOARD_RIGHT:
            move_right(board);
            break;
        default:
            break;
    }
}

void scramble_board(Board *board, int width, int height, MLV_Image * image) {
    int repeat; /* the number of times to move */

    for (repeat = 128; repeat >= 0; repeat--) {
        disp_board(*board, width, height, image);
        MLV_actualise_window();
        MLV_wait_milliseconds(50);
        MLV_clear_window(MLV_COLOR_BLACK);
        switch (MLV_get_random_integer(0, 4)) { /* moves the void square randomly */
            case 0:
                move_up(board);
                break;
            case 1:
                move_down(board);
                break;
            case 2:
                move_left(board);
                break;
            case 3:
                move_right(board);
                break;
            default:
                break;
        }
    }
}