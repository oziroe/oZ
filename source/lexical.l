/*
 * source/lexical.l
 * The lexical scanner of oz.
 *
 * Created by oziroe on July 22, 2017.
 * Last modified by oziroe on July 23, 2017.
 */

%option noyywrap

ID_CHARSET1         [a-zA-Z_]
ID_CHARSET2         [a-zA-Z0-9_]
ID_CHARSET3         [a-zA-Z0-9_!?]
OPERATOR_CHARSET1   [!?@#%^&*\-+_\'|/<>=]
OPERATOR_CHARSET2   [a-zA-Z_]
OPERATOR_CHARSET3   [!?@#%^&*\-+_\'|/<=]

%x PRESPACE

%{

#include "y.tab.h"

int prespace_indent_level(int count);
char *strip(char *origin);

%}

%%

(\n" "*)?;.*$       { /* Ignore comments. */ }

\n                  { BEGIN(PRESPACE); }

<PRESPACE>" "*/.    |
<PRESPACE><<EOF>>   {
                        switch (prespace_indent_level(yyleng)) {
                            case 1: {
                                BEGIN(INITIAL);
                                return INDENT;
                            }
                            case -1: {
                                return DEDENT;
                            }
                            default: {
                                BEGIN(INITIAL);
                                break;
                            }
                        }
                    }

\n" "*$             { /* Ignore blank lines. */ }

return              { return RETURN; }
if                  { return IF; }
else                { return ELSE; }

-?[0-9]+            { return INTEGER; }

{ID_CHARSET1}{ID_CHARSET2}*{ID_CHARSET3}?   { printf("<ID %s>\n", yytext); return IDENTIFIER; }

" "{OPERATOR_CHARSET1}+" "                  |
" *"{OPERATOR_CHARSET2}+"* "                { return OPERATOR; }

" "{OPERATOR_CHARSET1}+/"("                 { return UNARY; }
" "{OPERATOR_CHARSET3}+/{ID_CHARSET1}       { return UNARY; }
" "{OPERATOR_CHARSET1}+/[0-9]               { return UNARY; }

" "+                { /* Ignore seperated spaces. */ }

.                   { printf("<Unknown %c>\n", yytext[0]); return yytext[0]; }

%%

int prespace_indent_level(int count)
{
    static int previous = 0, remain = 0, mode = 0;

    if (mode == 1)  // dedent counting mode
    {
        if (remain != 0)
        {
            remain--;
            return -1;
        }
        else
        {
            mode = 0;
            return 0;
        }
    }
    else  // mode == 0, normal mode
    {
        int level = count / 4;
        if (level == previous)
            return 0;
        else if (level == previous + 1)
        {
            previous++;
            return 1;
        }
        else if (level > previous + 1)
        {
            fprintf(stderr, "ERROR: Indent more than one level at a time.\n");
            exit(1);
        }
        else
        {
            remain = previous - level - 1;
            mode = 1;
            previous = level;
            return -1;
        }
    }
}

char *strip(char *origin)
{
    int i, start;

    for (i = 0; origin[i] == ' '; i++)
        ;
    start = i;

    for (; origin[i] != ' ' && origin[i] != '\0'; i++)
        ;
    origin[i] = '\0';

    return origin + start;
}
