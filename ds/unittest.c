#include <stdio.h>
#include "symtab.h"
#include <assert.h>
int main(void)
{
  SymTable table = createSymTable();
  assert(table);  // Table must be created

  insert(table,"AMAN",45);

  int flag;
  int val = lookup(table,"AMAN",&flag);

  assert(!flag); //AMAN must be found

  assert(val==45); //Value associated with AMAN should be 45

  val = lookup(table,"PAWAN",&flag);
  assert(flag); //PAWAN must NOT be found

  modify(table,"AMAN",55,&flag);
  assert(!flag);  //AMAN exists in table

  val = lookup(table,"AMAN",&flag);
  assert(val==55); //value must be updated

  printf("--- All tests succeeed ---\n");
  return 0;
}
