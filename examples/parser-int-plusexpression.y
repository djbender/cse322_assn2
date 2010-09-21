%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token INTEGER
%left  '+'
%%

program: program expr '\n'	{ printf("%d\n", $2); }
	|
	;

expr:	INTEGER 		{ printf("INTEGER %d\n", $1);}	
	| expr '+' expr		{ printf("Found expr + expr: %d + %d \n", $1, $3); }	
	;

%%

void yyerror(char *s){
	printf("\n Syntax Error found: %s,", s);
}

int main(void){
	yyparse();
	return 0;
}
