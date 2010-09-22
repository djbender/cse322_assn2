%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token STRACK SPIECE SSTATION ETRACK EPIECE ESTATION SATTR EATTR NAME SHAPE SIZE QUANTITY COST KIND LOCATION EQUAL INTEGER Q STRING

%%

track: STRACK ETRACK  	{printf("Track found!\n");}
	|							{printf("what\n");}
	;


%%

void yyerror(char *s){
		printf("\n Syntax Error found: %s", s);
}

int main( void ) {
	yyparse();
	return 0;
}
