#include <ncurses.h>
#include <stdlib.h>

int draw_rectangle(int width, int height, int color) {
    attron(COLOR_PAIR(color));
    for(int j = LINES / 2 - height / 2; j <= LINES / 2 + height / 2; j++) {
        for (int i = COLS / 2 - width / 2; i <= COLS / 2 + width / 2; i++) {
            mvaddch(j, i, ' ');
        }
    }
    refresh();
    return 1;
}

int draw() {
    int key;
    MEVENT ev;

    initscr();
    cbreak();
    noecho();
    keypad(stdscr, TRUE);
    nodelay(stdscr, TRUE);

    start_color();
    init_pair(1, COLOR_BLACK, COLOR_RED);
    init_pair(2, COLOR_BLACK, COLOR_CYAN);

    curs_set(0);

    mousemask(ALL_MOUSE_EVENTS | REPORT_MOUSE_POSITION, NULL);

    int current_color = 1;
    int width = 7;
    int height = 7;

    while (1) {
        draw_rectangle(width, height, current_color);

        key = getch();
        if (key == KEY_MOUSE && getmouse(&ev) == OK) {
            if (
                    (ev.x >= COLS / 2 - width / 2) &&
                    (ev.x <= COLS / 2 + width / 2) &&
                    (ev.y >= LINES / 2 - height / 2) &&
                    (ev.y <= LINES / 2 + height / 2)
               ) {
                current_color = current_color == 1 ? 2 : 1;
            }
        }
    }

    getch();
    endwin();
    return 1;
}

int main() {
    draw();
    return EXIT_SUCCESS;
}
