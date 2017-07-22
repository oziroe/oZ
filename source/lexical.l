/*
 * source/lexical.l
 * The lexical scanner of oz.
 *
 * Created by oziroe on July 22, 2017.
 */

%option noyywrap

ID_CHARSET1         [a-zA-Z_]
ID_CHARSET2         [a-zA-Z0-9_]
ID_CHARSET3         [a-zA-Z0-9_!?]
OPERATOR_CHARSET    [!?@#%^&*-+_\'|/<>]
SPACE               [ \n]

%%

;.*\n       |
^" "*\n     { /* Ignore comments and blank lines. */ }

^" "*       { printf("\n<PRESPACE %lu> ", yyleng); }

" "=[ \n]   { printf(" <ASSIGN> "); }

{ID_CHARSET1}{ID_CHARSET2}*{ID_CHARSET3}?   { printf(" <ID %s> ", yytext); }

[0-9]+      { printf(" <INT %d> ", atoi(yytext)); }
