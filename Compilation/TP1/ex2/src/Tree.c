#include "Tree.h"
#include <stdlib.h>
#include <stdio.h>

t_tree make_node(char value)
{
    t_tree  ret;

    if (!(ret = (t_tree) malloc(sizeof(t_node))))
        return NULL;
    ret->bro = NULL;
    ret->son = NULL;
    ret->val = value;
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

void print_tree(t_tree t, int indent)
{
    int i;

    if (!t)
        return ;
    for (i = 0; i < indent; i++)
        printf("| ");
    printf("%c\n", t->val);
    print_tree(t->son, indent + 1);
    print_tree(t->bro, indent);
}
