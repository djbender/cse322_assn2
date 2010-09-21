%{
#include <stdio.h>
void yyerror(char *);
#include"y.tab.h"  // new line added to include header file produced by yacc"
%}
%%

[ \t]		/* do nothing */
[\n]		{
			return *yytext;
		}
[0-9]+		{
			yylval = atoi(yytext); 
			return INTEGER;
		} 
[+]		{
			return *yytext;
		}		
[-]		{
			return *yytext;
		}
[*]		{
			return *yytext;
		}
[/]		{
			return *yytext;
		}
[(]		{
			return *yytext;
		}
[)]		{
			return *yytext;
		}
.		printf("\n Lexer error %s found, ", yytext);

%%
int yywrap(void){
	return 1;
}

