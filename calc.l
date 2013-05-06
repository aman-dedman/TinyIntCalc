%{
#include "y.tab.h"
%}
number [0-9]+
%%
{number}  {
            yylval=atoi( yytext );
            return NUMBER;
          }
[^ \n]  {
            return yytext[0];
          }
\n        {
            return 0;
          }
