//
// source/syntax/expression4.h
// Level-4 expression. Either an integer, identifier, or an expression
// surrounded by parenthesis.
//
// Created by oziroe on July 24, 2017.
//

#ifndef OZ_SOURCE_SYNTAX_EXPRESSION4_H
#define OZ_SOURCE_SYNTAX_EXPRESSION4_H

typedef struct Expression4 *OzExpression4;

OzExpression4 oz_create_expression4_integer(int value);
OzExpression4 oz_create_expression4_identifier(char *name);

#endif
