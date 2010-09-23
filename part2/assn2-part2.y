%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);

int shape_c = 0;
int size_c = 0;
int quantity_c = 0;
int cost_c = 0;
int station_c = 0;

%}

%token STRACK SPIECE SSTATION ETRACK EPIECE ESTATION SATTR EATTR NAME SHAPE SIZE QUANTITY COST KIND LOCATION EQUAL INTEGER Q STRING

%%

track: STRACK track_name pieces ETRACK  	{printf("\nTrack found!\n\n");}
	|													{printf("Empty file!\n");}
	;

pieces: pieces SPIECE piece_attrs EPIECE  {
		if(   (shape_c == 1) 
			&& (size_c == 1) 
			&& (quantity_c == 1) 
			&& (cost_c == 1)
			&& ((station_c == 1) || (station_c == 0))
			) {
				shape_c = 0;
				size_c = 0;
				quantity_c = 0;
				cost_c = 0;
				station_c = 0;
			} else { 
				yyerror("Piece Error: ");
				if(station_c > 1) {
					yyerror("Station is greater than 1\n");
				} else {
					yyerror("Piece didn't have one of each attribute\n");
				}
				return 0;
			}
		}
	|
	;

piece_attrs: piece_attr piece_attrs
	|
	;

piece_attr:	SATTR SHAPE EQUAL string EATTR	{shape_c++;}
	| SATTR SIZE EQUAL integer EATTR				{size_c++;}
	| SATTR QUANTITY EQUAL integer EATTR		{quantity_c++;}
	| SATTR COST EQUAL integer EATTR				{cost_c++;}
	| station											{station_c++;}
	;

station: SSTATION station_attrs ESTATION
	;

station_attrs: station_attrs station_attr
	|
	;

station_attr: SATTR KIND EQUAL string EATTR
	| SATTR LOCATION EQUAL integer EATTR
	;

track_name: SATTR NAME EQUAL string EATTR
	|
	;

string: Q STRING Q
	| STRING
	;

integer: Q INTEGER Q
	| INTEGER
	;

%%

void yyerror(char *s){
		printf("\n Syntax Error found: %s\n", s);
}

int main( void ) {
	yydebug=1;
	yyparse();
}
