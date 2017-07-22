/*
 * source/main.c
 *
 * Created by oziroe on July 22, 2017.
 */
#include <stdio.h>

extern int yylex(void);
extern FILE *yyin;

int main(int argc, char *argv[])
{
    if (argc == 2)
    {
        yyin = fopen(argv[1], "r");
        return yylex();
    }
    else
    {
        return 1;
    }
}
