%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token STRACK ETRACK

%%

track: STRACK ETRACK		{printf("Got a track!\n");}
	;

%%

void yyerror(char *s){
		printf("\n Syntax Error found: %s,", s);
}

int main( void ) {
	yyparse();
	return 0;
}
