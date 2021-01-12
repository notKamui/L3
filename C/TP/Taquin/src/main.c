#include "../include/model.h"
#include "../include/viewctrl.h"

int main() {
    int width, height; /* board dimensions */
    MLV_Image *image; /* an image */
    Board board; /* the board */
    MLV_Keyboard_button key; /* a key press */
    int time;

    width = height = 512;
    image = NULL;

    MLV_create_window("Taquin", "taquin", width, height);

    printf("menu\n");
    menu_ctrl(width, height, &image);
    printf("new board\n");
    new_board(&board);
    printf("scrambling\n");
    scramble_board(&board, width, height, image);
    printf("starting game\n");

    time = MLV_get_time();
    while (!is_solved(board)) {
        disp_board(board, width, height, image);
        MLV_actualise_window();
        MLV_wait_keyboard(&key, NULL, NULL);
        ctrl_void_square(&board, key);
        MLV_clear_window(MLV_COLOR_BLACK);
    }
    printf("finished in %d seconds\n", (MLV_get_time() - time)/1000);

    MLV_draw_text(width/2 - 35, 130, "You win !", MLV_COLOR_WHITE);
    MLV_actualise_window();

    MLV_wait_seconds(5);

    MLV_free_image(image);
    MLV_free_window();

    return 0;
}
