%{
#include <stdio.h>
#include <ctype.h>
#include "ds/symtab.h"
#include <assert.h>
int notFound;
SymTable table;
%}

%union {
  int number;
  char *string;
}

%token <number> NUMBER
%token <number> QUIT
%token <number> ENDOFCMD
%token <string> VARIABLE

%type <number> factor
%type <number> exp
%type <number> command
%type <number> input
%type <number> term
%type <number> assignment

%right '='
%left '*'
%left '+'
%left '-'
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
        | assignment ENDOFCMD { printf("= %d\n",$1);  }
        ;

assignment : VARIABLE '=' exp {
                                $$ = $3;
                                lookup(table,$1,&notFound);
                                if(notFound) {
                                  fprintf(stderr,"New variable %s = %d\n",$1,$3);
                                  insert(table,$1,$3);
                                } else {
                                  modify(table,$1,$3,&notFound);
                                  assert(notFound==0); //Must be found in table
                                }
                              }
           ;

exp : exp '+' term { $$ = $1 + $3; }
    | exp '-' term { $$ = $1 - $3; }
    | term  { $$ = $1; }
    | assignment { $$ = $1; }
    ;

term : term '*' factor { $$ = $1 * $3; }
     | factor { $$ = $1; }
     ;

factor : NUMBER  { $$ = $1; }
       | VARIABLE {
                    int val = lookup(table,$1,&notFound);
                    if(notFound) {
                      fprintf(stderr,"Warning: Symbol <%s> not defined, assuming 0\n",$1);
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
