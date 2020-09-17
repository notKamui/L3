#include <ncurses.h>
#include <stdlib.h>
#include <unistd.h>

int draw_box(int x1, int y1, int x2, int y2) {
    mvhline(y1, x1, 0, x2-x1);
    mvhline(y2, x1, 0, x2-x1);
    mvvline(y1, x1, 0, y2-y1);
    mvvline(y1, x2, 0, y2-y1);

    mvaddch(y1, x1, ACS_ULCORNER);
    mvaddch(y2, x1, ACS_LLCORNER);
    mvaddch(y1, x2, ACS_URCORNER);
    mvaddch(y2, x2, ACS_LRCORNER);
    return 1;
}

int draw() {
    int ball_x, ball_y;
    int vect_x, vect_y;
    int delay;

    initscr();
    cbreak();
    noecho();
    keypad(stdscr, TRUE);
    nodelay(stdscr, TRUE);
    curs_set(0);

    delay = 1; // in seconds

    start_color();
    init_pair(1, COLOR_BLACK, COLOR_CYAN);

    ball_x = COLS / 2;
    ball_y = LINES / 2;
    vect_x = 1;
    vect_y = -1;

    draw_box(1, 1, COLS - 2, LINES - 2);
    attron(COLOR_PAIR(1));
    mvaddch(ball_y, ball_x, ' ');
    attroff(COLOR_PAIR(1));
    refresh();

    while(!(getch() == '\n' || getch() == '\r'));

    while(1) {
        clear();
        draw_box(1, 1, COLS - 2, LINES - 2);
        attron(COLOR_PAIR(1));
        mvaddch(ball_y, ball_x, ' ');
        attroff(COLOR_PAIR(1));
        refresh();

        if(getch() == '\n' || getch() == '\r') {
            break;
        }

        sleep(delay);

        if(ball_x + vect_x < 2 || ball_x > COLS - 4) {
            vect_x *= -1;
        }

        if(ball_y + vect_y < 2 || ball_y > LINES - 4) {
            vect_y *= -1;
        }

        ball_x += vect_x;
        ball_y += vect_y;
    }


    getch();
    endwin();
    return 1;
}

int main() {
    draw();
    return EXIT_SUCCESS;
}
