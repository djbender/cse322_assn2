%{
#include <stdio.h>
void yyerror(char *);
#include "y.tab.h"
%}



%%

[ \t\r\n]		/* do nothing */	

"<track>"		{return STRACK;}
"</track>"		{return ETRACK;}

.												{
												printf("Invalid token: %s\n", yytext);
												//return 0;
												}


%%

int yywrap(void){return 1;}

/* Main is in yacc file */
/*
int main() {
	yylex();
	return 0;
}
*/
