%{
#include <stdio.h>
void yyerror(char *);
#include"y.tab.h"  // new line added to include header file produced by yacc"
%}
%%

[ \t\n]		/* do nothing */
[0-9]+		{
			yylval = atoi(yytext); 
			return INTEGER;
		} 
[+]		{
			return *yytext;
		}		
.		printf("\n Lexer error %s found, ", yytext);

%%
int yywrap(void){
	return 1;
}

/* no main... the main is now in Yacc - YAcc drives the process */
