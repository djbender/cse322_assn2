%{
#include <stdio.h>
void yyerror(char *);
#include "y.tab.h"
%}

%%

"<track>"		{return STRACK;}
"<piece>"		{return SPIECE;}
"<station>"		{return SSTATION;}

"</track>"		{return ETRACK;}
"</piece>"		{return EPIECE;}
"</station>"	{return ESTATION;}

"<-"				{return SATTR;}
"->"				{return EATTR;}

"name"		{return NAME;}
"shape"		{return SHAPE;}
"size"		{return SIZE;}
"quantity" 	{yylval = atoi(yytext); return QUANTITY;}
"cost"		{yylval = atoi(yytext); return COST;}
"kind"		{return KIND;}
"location" 	{return LOCATION;}

"straight" 	{return STRAIGHT;}
"curve"		{return CURVE;}
"junction"	{return JUNCTION;}

=				{return EQUAL;}										

[0-9]+	{
			yylval = atoi(yytext);
			return INTEGER;
			}

[a-zA-Z]([a-zA-Z0-9])+ 	{return STRING;}

\"				{return Q;}

[ \t\r\n]	   /* do nothing */ 

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
