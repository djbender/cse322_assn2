%{
#include <stdio.h>
void yyerror(char *);
#include "y.tab.h"
%}

%%

[ \t\r\n]	   /* do nothing */ 

"<track>"		{ECHO;return STRACK;}
"<piece>"		{return SPIECE;}
"<station>"		{return SSTATION;}

"</track>"		{ECHO;return ETRACK;}
"</piece>"		{return EPIECE;}
"</station>"	{return ESTATION;}

"<-"				{return SATTR;}
"->"				{return EATTR;}

"name"		{return NAME;}
"shape"		{return SHAPE;}
"size"		{return SIZE;}
"quantity" 	{return QUANTITY;}
"cost"		{return COST;}
"kind"		{return KIND;}
"location" 	{return LOCATION;}

=				{return EQUAL;}										

[0-9]+	{
			yylval = atoi(yytext);
			return INTEGER;
			}

[a-zA-Z]([a-zA-Z0-9])+ 	{
								ECHO;
								return STRING;
								}

\"				{return Q;}

.												{
												printf("Invalid token: %s\n", yytext);
												//return 0;
												}


%%

int yywrap(void){return 1;}

/* Main is in yacc file */
/*
int main() {
	yylex();
	return 0;
}
*/
