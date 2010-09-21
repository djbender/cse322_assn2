%{
#include <stdio.h>
%}

%%

[0-9]+						printf("Caught an integer : %s\n", yytext);
[a-zA-Z][a-zA-Z0-9]*		printf("Caught a letter: %s\n", yytext);

.								printf("Something else: %s\n", yytext);

%%

int yywrap(void){return 1;}

/*int main(void) {
	yylex();
	return 0;
}*/
