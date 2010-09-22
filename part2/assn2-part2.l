%{
#include <stdio.h>
void yyerror(char *);
#include "y.tab.h"
%}



%%

"<track>"	{return STRACK;}
"</track>"	{return ETRACK;}

[ \t\r\n]	                        //printf("Caught some whitespace: space\n");

.												{
												printf("Invalid token: %s\n", yytext);
												return 0;
												}


%%

int yywrap(void){return 1;}

/* Main is in yacc file */
