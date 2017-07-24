/*
 * source/grammer.y
 * Grammer parser for oz.
 *
 * Created by oziroe on July 23, 2017.
 */

%{

#include <stdio.h>

#include "syntax/expression4.h"

// Prevent compiler warnings.
extern int  yylex(void);
int         yyerror(char *s);

typedef void *Node;

%}

%union {
    int     integer_value;
    double  double_value;
    char *  string_value;
    // Can not use `Node` as its type, because lexical rule cannot know it.
    void *  node_value;
}

%token RETURN IF ELSE
%token INDENT DEDENT
%token <string_value> IDENTIFIER OPERATOR UNARY
%token <integer_value> INTEGER

%type <node_value> expression4

%%

declarations:

    | declarations declaration
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
      '(' arguments_type_sequence ')' return_type
    ;

arguments_type_sequence:

    | argument_name argument_type
    | argument_name argument_type ',' arguments_type_sequence
    ;

argument_name:
      IDENTIFIER
    ;

argument_type:

    | type_declaration
    ;

return_type:

    | type_declaration
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
      INDENT statements_sequence DEDENT
    ;

statements_sequence:
      statement
    | statement statements_sequence
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
      expression4 '(' arguments_sequence ')'
    | expression4
    ;

expression4:
      INTEGER               { $$ = (Node)oz_create_expression4_integer($1); }
    | IDENTIFIER            { $$ = (Node)oz_create_expression4_identifier($1); }
    | '(' expression ')'
    ;

arguments_sequence:

    | argument
    | argument ',' arguments_sequence
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
