/*
 * source/grammer.y
 * Grammer parser for oz.
 *
 * Created by oziroe on July 23, 2017.
 */

%{

#include <stdio.h>

// Prevent compiler warnings.
extern int  yylex(void);
int         yyerror(char *s);

%}

%union {
    int     integer_value;
    double  double_value;
    char *  string_value;
}

%token RETURN IF ELSE
%token INDENT DEDENT
%token <string_value> IDENTIFIER OPERATOR UNARY
%token <integer_value> INTEGER

%%

declarations:

    | declaration declarations
    ;

declaration:
      function_declaration
    ;

function_declaration:
      function_name function_type function_body
    ;

function_name:
      IDENTIFIER
    ;

function_type:
      '(' arguments_type_list ')' return_type
    ;

arguments_type_list:

    | argument_name argument_type
    | argument_name argument_type ',' arguments_type_list
    ;

argument_name:
      IDENTIFIER
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
      IDENTIFIER
    | type_modifier type_name
    ;

type_modifier:
      '>'
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
      RETURN expression
    | IF expression block ELSE block
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
