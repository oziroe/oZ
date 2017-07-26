//
// source/syntax/expression3.c
//
// Created by oziroe on July 24, 2017.
//

#include <stdlib.h>
#include <stdio.h>
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

void oz_print_expression3(struct Expression3 *ex3)
{
    const char *type_name[] = { "apply", "expr4" };
    printf("[ expr3 <%s> ", type_name[ex3->type]);
    switch (ex3->type)
    {
        case APPLY: {
            oz_print_expression4(ex3->value.apply_value.expression);
            printf(" ]");  // TODO: print arugments
            break;
        }
        case EXPRESSION4: {
            oz_print_expression4(ex3->value.expression4_value);
            printf(" ]");
            break;
        }
        default: {
            printf("*unknown* ]");
            break;
        }
    }
}
