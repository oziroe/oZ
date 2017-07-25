/*
 * source/grammer.y
 * Grammer parser for oz.
 *
 * Created by oziroe on July 23, 2017.
 */

%{

#include <stdio.h>

#include "syntax/expression4.h"
#include "syntax/expression3.h"

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

%type <node_value> expression4 expression3

%%

declarations:
      /* empty */

    | /* declaration */
      declarations declaration
    ;

declaration:
      /* function */
      function_declaration
    ;

function_declaration:
      /* default */
      function_name function_type function_body
    ;

function_name:
      /* identifier */
      IDENTIFIER
    ;

function_type:
      /* default */
      '(' arguments_type_sequence ')' return_type
    ;

arguments_type_sequence:
      /* empty */

    | /* simgle */
      argument_name argument_type
    | /* sequence */
      arguments_type_sequence ',' argument_name argument_type
    ;

argument_name:
      /* identifier */
      IDENTIFIER
    ;

argument_type:
      /* omit */

    | /* declaration */
      type_declaration
    ;

return_type:
      /* omit */

    | /* declaration */
      type_declaration
    ;

type_declaration:
      /* colon */
      ':' type_name
    ;

type_name:
      /* identifier */
      IDENTIFIER
    | /* modifier */
      type_modifier type_name
    ;

type_modifier:
      /* pointer */
      '>'
    ;

function_body:
      /* block */
      block
    ;

block:
      /* default */
      INDENT statements_sequence DEDENT
    ;

statements_sequence:
      /* statement */
      statement
    | /* sequence */
      statements_sequence statement
    ;

statement:
      /* return */
      RETURN expression
    | /* if */
      IF expression block ELSE block
    ;

expression:
      /* operator */
      expression2 OPERATOR expression
    | /* expression2 */
      expression2
    ;

expression2:
      /* unary */
      UNARY expression3
    | /* expression3 */
      expression3
    ;

expression3:
      /* apply */
      expression4 '(' arguments_sequence ')'
    | /* expression4 */
      expression4
    {
        $$ = (Node)oz_create_expression3_expression4((OzExpression4)$1);
    }
    ;

expression4:
      /* integer */
      INTEGER               { $$ = (Node)oz_create_expression4_integer($1);     }
    | /* identifier */
      IDENTIFIER            { $$ = (Node)oz_create_expression4_identifier($1);  }
    | /* expression */
      '(' expression ')'
    ;

arguments_sequence:
      /* empty */

    | /* argument */
      argument
    | /* sequence */
      argument ',' arguments_sequence
    ;

argument:
      /* expression */
      expression
    ;

%%

int yyerror(char *s)
{
    printf("ERROR: %s\n", s);
    return 0;
}
