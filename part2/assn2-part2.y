%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token INTEGER

%%

%%

void yyerror(char *s){
		printf("\n Syntax Error found: %s,", s);
}

int main( void ) {
	yyparse();
	return 0;
}
