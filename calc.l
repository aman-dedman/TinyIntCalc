%{
#include "y.tab.h"
#include "ds/symtab.h"
extern SymTable table;
extern char *fromLex;
%}
number [0-9]+
id [a-zA-Z]+
%%

QUIT  {
        return QUIT;
      }

{number}  {
            yylval=atoi( yytext );
            return NUMBER;
          }

{id}  {
        fromLex = yytext;
        return VARIABLE;
      }

[^ \n]  { return yylval = yytext[0]; }

\n  {
      return ENDOFCMD;
    }

[ ]
