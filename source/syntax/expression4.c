//
// source/syntax/expression4.cpp
//
// Created by oziroe on July 24, 2017.
//

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

struct Expression4
{
    enum { INTEGER, IDENTIFIER, EXPRESSION } type;
    union
    {
        int integer_value;
        char *identifier_value;  // TODO: Change to pointer to symbol table.
    } value;
};

struct Expression4 *oz_create_expression4_integer(int v)
{
    struct Expression4 *ex4 = malloc(sizeof(struct Expression4));
    ex4->type = INTEGER;
    ex4->value.integer_value = v;
    return ex4;
}

struct Expression4 *oz_create_expression4_identifier(char *name)
{
    struct Expression4 *ex4 = malloc(sizeof(struct Expression4));
    ex4->type = IDENTIFIER;
    ex4->value.identifier_value = malloc(sizeof(char) * (strlen(name) + 1));
    strcpy(ex4->value.identifier_value, name);
    return ex4;
}

void oz_print_expression4(struct Expression4 *ex4)
{
    const char *type_name[] = { "int", "id", "expr" };
    printf("[ expr4 <%s> ", type_name[ex4->type]);
    switch (ex4->type)
    {
        case INTEGER: {
            printf("%d ]", ex4->value.integer_value);
            break;
        }
        case IDENTIFIER: {
            printf("%s ]", ex4->value.identifier_value);
            break;
        }
        default: {
            printf("expr ]");  // TODO: Call expression print.
            break;
        }
    }
}
