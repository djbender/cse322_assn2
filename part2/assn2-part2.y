%{
#include <stdio.h>
#include <string.h>
int yylex(void);
void yyerror(char *);

int shape_c = 0;
int size_c = 0;
int quantity_c = 0;
int cost_c = 0;
int station_c = 0;
char * shape = "";

%}

%token STRACK SPIECE SSTATION ETRACK EPIECE ESTATION SATTR EATTR NAME SHAPE SIZE QUANTITY COST STRAIGHT CURVE JUNCTION KIND LOCATION EQUAL INTEGER Q STRING

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
				yyerror("Piece Error:");
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

piece_attrs: piece_attr piece_attrs {
			if( strcmp(shape, "JUNCTION") && (size_c != 1)) {
				yyerror("Size of Junction was not one.\n");
			}
		}
	|
	;

piece_attr:	SATTR SHAPE EQUAL shape EATTR	{shape_c++;}
	| SATTR SIZE EQUAL integer EATTR				{size_c++;}
	| SATTR QUANTITY EQUAL integer EATTR		{
			if($4 < 1) {
				printf("quantity given: %i.\n", $4);
				yyerror("Piece's quantity must be at least 1");
				return 0;
			}
			quantity_c++;
		}
	| SATTR COST EQUAL integer EATTR				{
			if($4 < 1) {
				yyerror("Piece's cost must be at least 1");
				return 0;
			}
			cost_c++;
		}
	| station											{station_c++;}
	;

shape: STRAIGHT		{shape = "STRAIGHT";}
	| CURVE				{shape = "CURVE";}
	| JUNCTION			{shape = "JUNCTION";}
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

integer: Q INTEGER Q	{$$ = $2;} 
	| INTEGER 			{$$ = $1;}
	;

%%

void yyerror(char *s){
		printf("\n Syntax Error found: %i %s\n", __LINE__, s);
}

int main( void ) {
	yydebug=1;
	yyparse();
}
