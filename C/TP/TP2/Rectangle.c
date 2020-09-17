#include <ncurses.h>
#include <stdlib.h>

int draw_rectangle(int width, int height, int color) {
    attron(COLOR_PAIR(color));
    for(int j = LINES / 2 - height / 2; j <= LINES / 2 + height / 2; j++) {
        for (int i = COLS / 2 - width / 2; i <= COLS / 2 + width / 2; i++) {
            mvaddch(j, i, ' ');
        }
    }
    return 1;
}

int draw() {
    initscr();

    start_color();
    init_pair(1, COLOR_BLACK, COLOR_RED);

    curs_set(0);

    int current_color = 1;
    int width = 15;
    int height = 3;

    draw_rectangle(width, height, current_color);

    refresh();
    getch();
    endwin();
    return 1;
}

int main() {
    draw();
    return EXIT_SUCCESS;
}
