%{
#include <stdio.h>
%}

%%

[ \t\r\n]	                        //printf("Caught some whitespace: space\n");
"<track>"|"<piece>"|"<station>"		printf("Start Tag: %s\n", yytext);
"</track>"|"</piece>"|"</station>"	printf("End Tag: %s\n", yytext);
"<-"		                        printf("Start Attribute: %s\n", yytext);
"->"		                        printf("End Attribute: %s\n", yytext);
name|shape|size|quantity|cost|kind|location printf("Attribute: %s\n", yytext);
=		                            printf("Assignment: %s\n", yytext);
\"[0-9]+\"                          printf("Number: %s\n", yytext);
\"[a-zA-Z]([a-zA-Z0-9])+\"          printf("String: %s\n", yytext);
.			{
				printf("Invalid token: %s\n", yytext);
				return 0;
			}


%%

int yywrap(void){return 1;}

/*int main(void) {
	yylex();
	return 0;
}*/
