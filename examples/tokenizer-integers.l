%{
#include <stdlib.h>

%}
%%

[ ]				/* do nothing */
[0-9]+				printf("\n %s: integer", yytext); 
.				printf("\n Error %s found", yytext);

%%
int yywrap(void){
	return 1;
}

int main(){
	yylex();
	return 0;
}

