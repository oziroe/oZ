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
%token IF
%token ELSE
%token IDENTIFIER
%token INTEGER
%token OPERATOR
%token UNARY
%token INDENT
%token DEDENT

%%

declarations:

    | declaration declarations
    ;

declaration:
      function_declaration
    ;

function_declaration:
      function_name function_type function_body { printf("Get a function declaration.\n"); }
    ;

function_name:
      IDENTIFIER    { printf("Get a function name.\n"); }
    ;

function_type:
      '(' arguments_type_list ')' return_type   { printf("Get a function type.\n"); }
    ;

arguments_type_list:

    | argument_name argument_type   { printf("Get an arguents type list.\n"); }
    | argument_name argument_type ',' arguments_type_list
    ;

argument_name:
      IDENTIFIER    { printf("Get an argument name.\n"); }
    ;

argument_type:
      type_declaration
    ;

return_type:
      type_declaration
    ;

type_declaration:
      ':' type_name
    ;

type_name:
      IDENTIFIER                { printf("Get a type name.\n"); }
    | type_modifier type_name   { printf("Get a type name.\n"); }
    ;

type_modifier:
      '>'   { printf("Get a type modifier.\n"); }
    ;

function_body:
      block
    ;

block:
      INDENT statements_list DEDENT
    ;

statements_list:
      statement
    | statement statements_list
    ;

statement:
      RETURN expression { printf("Get a return expression.\n"); }
    | IF expression block ELSE block    { printf("Get an if-else expression.\n"); }
    ;

expression:
      expression2 OPERATOR expression
    | expression2
    ;

expression2:
      UNARY expression3
    | expression3
    ;

expression3:
      expression4 '(' arguments_list ')'
    | expression4
    ;

expression4:
      INTEGER
    | IDENTIFIER
    | '(' expression ')'
    ;

arguments_list:

    | argument
    | argument ',' arguments_list
    ;

argument:
      expression
    ;

%%

int yyerror(char *s)
{
    printf("ERROR: %s\n", s);
    return 0;
}
