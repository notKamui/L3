#include <ncurses.h>

int main() {
    initscr();
    printw("1");
    move(2, 10);
    addch('2');
    addch('3');
    move(LINES - 1, COLS - 1);
    addch('4');
    mvaddch(4, 2, '5');
    mvprintw(3, 3, "ABCD");
    printw("**");
    refresh();
    getch();
    endwin();
    return 0;
}
