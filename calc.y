%{
#include <stdio.h>
#include <ctype.h>
#include "ds/symtab.h"
int notFound;
char *fromLex;
SymTable table;
%}

%token NUMBER VARIABLE QUIT ENDOFCMD

%%

input : command input
      |
      ;

command : exp ENDOFCMD { printf("= %d\n",$1); }
        | QUIT ENDOFCMD {
                          printf("Bye!\n");
                          return 0;
                        }
        | ENDOFCMD { printf("= 0\n"); }
        ;

exp : exp '+' term { $$ = $1 + $3; }
    | exp '-' term { $$ = $1 - $3; }
    | term  { $$ = $1; }
    ;

term : term '*' factor { $$ = $1 * $3; }
     | factor { $$ = $1; }
     ;

factor : NUMBER  { $$ = $1; }
       | VARIABLE {
                    int val = lookup(table,fromLex,&notFound);
                    if(notFound) {
                      fprintf(stderr,"Warning: Symbol <%s> not defined, assuming 0\n",fromLex);
                      $$ = 0;
                    } else {
                      $$ = val;
                    }
                  }
       | '(' exp ')'  { $$ = $2; }
       ;

%%

int main(void)
{
  table = createSymTable();
  return yyparse();
}

int yyerror(char *s)
{
  fprintf(stderr,"%s\n",s);
  return 0;
}
