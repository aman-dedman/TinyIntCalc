#include "symtab.h"
#include <stdlib.h>
#include <string.h>
#include <assert.h>

SymTable createSymTable()
{
  SymTable ret = (SymTable)calloc(SYMTABSIZE,sizeof(Node*));
  return ret;
}

int hash(String s)
{
  int ret;
  for(ret=0; *s; s++)
    ret = (ret + (*s-64)) % 997;
  return ret;
}

Node *lookintable(SymTable table, String s)
{
  assert(s);
  int h = hash(s);
  Node *tmp = table[h];
  while(tmp) {
    if(strcmp(s,tmp->key)==0)
      return tmp;
    tmp = tmp->next;
  }
  return 0;
}

int lookup(SymTable table, String s, int *notFound)
{
  *notFound=0;
  Node *ret = lookintable(table,s);
  if(ret)
    return ret->value;
  *notFound=1;
  return 0;
}
  
void insert(SymTable table, String s, int value)
{
  assert(s);
  int h = hash(s);
  Node *tmp = (Node*)malloc(sizeof(Node));
  strcpy(tmp->key,s);
  tmp->next = table[h];
  table[h] = tmp;
  tmp->value = value;
}

void modify(SymTable table, String s, int value, int *notFound)
{
  *notFound=0;
  Node *ret = lookintable(table,s);
  if(ret)
    ret->value=value;
  else
    *notFound=1;
}
