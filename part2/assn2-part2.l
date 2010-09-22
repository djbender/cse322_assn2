%{
#include <stdio.h>
void yyerror(char *);
#include "y.tab.h"
%}



%%

[ \t\r\n]	                        //printf("Caught some whitespace: space\n");
"<track>"|"<piece>"|"<station>"		{
												}

"</track>"|"</piece>"|"</station>"	{
												}

"<-"		                        	
"->"		                        	

name|shape|size|quantity|cost|kind|location {
												}

=												

\"[0-9]+\"                          {
												yylval = atoi(yytext);
												return INTEGER;
												}

\"[a-zA-Z]([a-zA-Z0-9])+\"           

.												{
												printf("Invalid token: %s\n", yytext);
												return 0;
												}


%%

int yywrap(void){return 1;}

/* Main is in yacc file */
