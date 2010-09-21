%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);

int pluses = 0;
int minuses = 0;

/* Check: Must have the same number of pluses and minuses  */
%}

%token INTEGER
%left '-' '+' '*' '/' 

%%

program: program expr '\n'	{if (pluses!=minuses) printf("\n Wrong +/- combo \n");	}	
	|
	;

expr:	INTEGER 			
	| expr '+' expr		{pluses += 1;}	
	| expr '-' expr	  	{minuses += 1;}		
	| expr '*' expr			
	| expr '/' expr			
	;

%%

void yyerror(char *s){
	printf("\n Syntax Error found: %s", s);
}

int main(void){
	yyparse();
	return 0;
}
