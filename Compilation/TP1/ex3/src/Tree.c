#include "Tree.h"
#include <stdlib.h>
#include <stdio.h>

t_tree make_node(int num, char op)
{
    t_tree  ret;

    if (!(ret = (t_tree) malloc(sizeof(t_node))))
        return NULL;
    ret->bro = NULL;
    ret->son = NULL;
    ret->num = num;
    ret->op = op;
    return ret;
}

int add_sibling(t_tree *t, t_tree bro)
{
    t_tree  tmp;

    for (tmp = *t; (*t)->bro; *t = (*t)->bro);
    (*t)->bro = bro;
    *t = tmp;
    return 0;
}

int add_child(t_tree *t, t_tree child)
{
    t_tree  tmp;

    if (!(*t)->son)
    {
        (*t)->son = child;
        return 0;
    }
    for (tmp = *t, *t = (*t)->son; (*t)->bro; *t = (*t)->bro);
    (*t)->bro = child;
    *t = tmp;
    return 0;
}

int is_node(t_tree t)
{
    return t->son != NULL;
}

void free_tree(t_tree *t)
{
    if (!*t)
        return ;
    free_tree(&((*t)->son));
    free_tree(&((*t)->bro));
    free(*t);
}

void print_tree(t_tree t, int indent)
{
    int i;

    if (!t)
        return ;
    for (i = 0; i < indent; i++)
        printf("| ");
    if (t->op)
        printf("%c => result %d\n", t->op, t->num);
    else
        printf("%d\n", t->num);
    print_tree(t->son, indent + 1);
    print_tree(t->bro, indent);
}
