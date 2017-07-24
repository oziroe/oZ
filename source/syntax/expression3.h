//
// source/syntax/expression3.h
// Level-3 expression. Either a function applying, or a level-4 expression.
//
// Created by oziroe on July 24, 2017.
//

#ifndef OZ_SOURCE_SYNTAX_EXPRESSION3_H
#define OZ_SOURCE_SYNTAX_EXPRESSION3_H

#include "expression4.h"

typedef struct Expression3 *OzExpression3;

OzExpression4   oz_create_expression3_expression4   (OzExpression4 ex4);
void            oz_print_expression3                (OzExpression3 ex3);

#endif
