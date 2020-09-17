#include <ncurses.h>
#include <stdlib.h>
#include <unistd.h>

void draw_box(int x1, int y1, int x2, int y2);
void ball_run(int delay);
void options(int* ptr_delay);
void credits();
void draw_menu(int choice, int delay);
void menu(int* ptr_delay);

void draw_box(int x1, int y1, int x2, int y2) {
    mvhline(y1, x1, 0, x2-x1);
    mvhline(y2, x1, 0, x2-x1);
    mvvline(y1, x1, 0, y2-y1);
    mvvline(y1, x2, 0, y2-y1);

    mvaddch(y1, x1, ACS_ULCORNER);
    mvaddch(y2, x1, ACS_LLCORNER);
    mvaddch(y1, x2, ACS_URCORNER);
    mvaddch(y2, x2, ACS_LRCORNER);
}

void ball_run(int delay) {
    int ball_x, ball_y;
    int vect_x, vect_y;

    initscr();
    clear();

    cbreak();
    noecho();
    keypad(stdscr, TRUE);
    nodelay(stdscr, TRUE);
    curs_set(0);

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
}

void options(int* ptr_delay) {
    char seconds[128];
    initscr();
    echo();
    curs_set(1);

    clear();
    mvprintw(LINES / 2, COLS / 2 - 15, "Ball delay (in seconds): ");
    getstr(seconds);

    *ptr_delay = atoi(seconds);
    if(*ptr_delay < 1) *ptr_delay = 1;
    endwin();
}

void credits() {
    initscr();
    clear();

    draw_box(
            COLS / 2 - 36 / 2,
            LINES / 2 - 2,
            COLS / 2 + 34 / 2,
            LINES / 2 + 2);
    mvprintw(LINES / 2 - 1, COLS / 2 - 34 / 2, "Created by Jimmy TEILLARD (!kamui)");
    mvprintw(LINES / 2,     COLS / 2 - 29 / 2, "University Gustave Eiffel IGM");
    mvprintw(LINES / 2 + 1, COLS / 2 - 14 / 2, "September 2020");

    refresh();

    getch();
    endwin();
}

void draw_menu(int choice, int delay) {
    clear();
    draw_box(
            COLS / 2 - 12 / 2,
            LINES / 2 - 6 / 2,
            COLS / 2 + 12 / 2,
            LINES / 2 + 5 / 2);

    if(choice == 1) attron(COLOR_PAIR(1));
    mvprintw(LINES / 2 - 2, COLS / 2 - 11 / 2, "1 - Start  ");
    if(choice == 1) attroff(COLOR_PAIR(1));

    if(choice == 2) attron(COLOR_PAIR(1));
    mvprintw(LINES / 2 - 1, COLS / 2 - 11 / 2, "2 - Options");
    if(choice == 2) attroff(COLOR_PAIR(1));

    if(choice == 3) attron(COLOR_PAIR(1));
    mvprintw(LINES / 2,     COLS / 2 - 11 / 2, "3 - Credits");
    if(choice == 3) attroff(COLOR_PAIR(1));

    if(choice == 4) attron(COLOR_PAIR(1));
    mvprintw(LINES / 2 + 1, COLS / 2 - 11 / 2, "4 - Exit   ");
    if(choice == 4) attroff(COLOR_PAIR(1));

    mvprintw(0, 0, "Delay: %d", delay);

    refresh();
}

void menu(int* ptr_delay) {
    int menu_choice;
    int validated;
    int key;

    initscr();
    noecho();
    cbreak();
    curs_set(0);

    start_color();
    init_pair(1, COLOR_BLACK, COLOR_CYAN);

    menu_choice = 1;
    draw_menu(menu_choice, *ptr_delay);

    validated = 0;
    while(!validated) {
        draw_menu(menu_choice, *ptr_delay);

        switch((key = getch())) {
            case '1':
            case '2':
            case '3':
            case '4':
                menu_choice = key - 48;
                validated = 1;
                break;
            case '\033': // is arrow
                getch();
                switch(getch()) {
                    case 'A': // up
                        menu_choice--;
                        if(menu_choice < 1) menu_choice = 4;
                        break;
                    case 'B': // down
                        menu_choice++;
                        if(menu_choice > 4) menu_choice = 1;
                        break;
                    default:
                        break;
                }
                break;
            case '\r':
            case '\n':
                validated = 1;
                break;
            default:
                break;
        }
    }

    endwin();

    switch(menu_choice) {
        case 1:
            ball_run(*ptr_delay);
            break;
        case 2:
            options(ptr_delay);
            menu(ptr_delay);
            break;
        case 3:
            credits();
            menu(ptr_delay);
            break;
        case 4:
            printf("Bye !\n");
            exit(EXIT_SUCCESS);
            break;
        default:
            exit(EXIT_FAILURE);
    }
}

int main() {
    int delay = 1;
    menu(&delay);
    return EXIT_SUCCESS;
}
