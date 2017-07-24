//
// source/syntax/expression3.c
//
// Created by oziroe on July 24, 2017.
//

#include <stdlib.h>
#include "expression4.h"

struct Expression3
{
    enum { APPLY, EXPRESSION4 } type;
    union {
        struct {
            OzExpression4 expression;
            void *arguments;  // TODO: Argument sequence.
        } apply_value;
        OzExpression4 expression4_value;
    } value;
};

struct Expression3 *oz_create_expression3_expression4(OzExpression4 ex4)
{
    struct Expression3 *ex3 = malloc(sizeof(struct Expression3));
    ex3->type = EXPRESSION4;
    ex3->value.expression4_value = ex4;
    return ex3;
}
