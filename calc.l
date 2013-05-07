%{
#include "y.tab.h"
#include "ds/symtab.h"
#include <assert.h>
extern SymTable table;
%}
number [0-9]+
id [a-zA-Z]+
%%

QUIT  {
        return QUIT;
      }

{number}  {
            yylval.number = atoi( yytext );
            return NUMBER;
          }

{id}  {
        yylval.string = strdup(yytext);
        return VARIABLE;
      }

[^ \n]  { return yylval.number = yytext[0]; }

\n  {
      return ENDOFCMD;
    }

[ ]
