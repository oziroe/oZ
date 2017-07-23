/*
 * source/grammer.y
 * Grammer parser for oz.
 *
 * Created by oziroe on July 23, 2017.
 */

%{

#include <stdio.h>

extern int yylex(void);
int yyerror(char *s);

%}

%token RETURN
%token IDENTIFIER
%token INTEGER
%token OPERATOR
%token INDENT
%token DEDENT

%%

declarations:

    | declarations declaration
    ;

declaration:
      funchead INDENT funcbody DEDENT   { printf("Get a function declaration.\n"); }
    ;

funchead:
      funcname '(' arglist ')' typedecl { printf("Get a function head.\n"); }
    | funcname '(' arglist ')'
    ;

funcname:
      IDENTIFIER        { printf("Get a function name.\n"); }
    ;

arglist:
    | arg
    | arglist ',' arg
    ;

arg:
      argname typedecl  { printf("Get a argument.\n"); }
    | argname
    ;

argname:
      IDENTIFIER        { printf("Get an argument name.\n"); }
    | INTEGER           { printf("Get an argument integer.\n"); }
    ;

typedecl:
      ':' typename

typename:
      IDENTIFIER
    | typemod typename
    ;

typemod:
      '>'
    ;

funcbody:
      statlist          { printf("Get a list of statement.\n"); }
    ;

statlist:

    | statlist statement
    ;

statement:
      RETURN expression
    ;

expression:
      funcname '(' arglist ')'  { printf("Get an expression.\n"); }
    ;

%%

int yyerror(char *s)
{
    printf("ERROR: %s\n", s);
    return 0;
}
