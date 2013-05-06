#ifndef CALC_SYMTAB_H
#define CALC_SYMTAB_H

#define SYMTABSIZE 997
typedef struct node {
  char key[10];
  int value;
  struct node *next;
} Node;

typedef Node **SymTable;
typedef char *String;

SymTable createSymTable();

int lookup( SymTable symbolTable,
            String toBeFound,
            int* notFound );

void insert( SymTable symbolTable,
             String toBeInserted,
             int valueAssociated );

void modify( SymTable symbolTable,
             String toBeModified,
             int newValue,
             int* notFound);

#endif
