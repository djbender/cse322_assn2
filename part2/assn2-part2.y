%{
#include <stdio.h>
#include <string.h>
int yylex(void);
void yyerror(char *);

int yydebug;

int shape_c = 0;
int size_c = 0;
int quantity_c = 0;
int cost_c = 0;
int station_c = 0;

int size = 0;
char * shape;
int isJunction = 0;
int isStation = 0;

%}

%token STRACK SPIECE SSTATION ETRACK EPIECE ESTATION SATTR EATTR NAME SHAPE SIZE QUANTITY COST STRAIGHT CURVE JUNCTION KIND LOCATION EQUAL INTEGER Q STRING

%%

track: STRACK track_name pieces ETRACK  	{printf("\nTrack found!\n\n");}
	|													{printf("Empty file!\n");}
	;

pieces: pieces SPIECE piece_attrs EPIECE  {
			if	(   (shape_c == 1) 
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
					yyerror("Station is greater than 1.");
				} else {
					yyerror("Piece didn't have one of each attribute.");
				}
				return 0;
			}
			if ( isJunction ) {
				if (size != 1) {
					yyerror("Junction Piece's size is not 1.");
					return 0;
				} else {
					size = 0;
				}
			}
			if (isStation){
				if ( strcmp(shape, "STRAIGHT") == 0) {//strcmp returns 0 when equal
					isStation = 0; //reset isStation
				} else {
					yyerror("Station not on a straight piece!");
					//printf("shape: %s",shape);
					return 0;
				}
			}
		}
	|
	;

piece_attrs: piece_attr piece_attrs {}
	|
	;

piece_attr:	SATTR SHAPE EQUAL shape EATTR	{
			shape_c++;}
	| SATTR SIZE EQUAL integer EATTR				{
			if($4 < 1) {
				printf("\n\tsize given: %i.\n\n", $4);
				yyerror("Piece's quantity must be at least 1.");
				return 0;
			}
			size = $4;
			size_c++;
		}
	| SATTR QUANTITY EQUAL integer EATTR		{
			if($4 < 1) {
				printf("\n\tquantity given: %i.\n\n", $4);
				yyerror("Piece's quantity must be at least 1.");
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
	| station											{station_c++; isStation = 1;}
	;

shape: Q STRAIGHT Q		{shape = "STRAIGHT";}
	| Q CURVE Q				{shape = "CURVE";}
	| Q JUNCTION Q			{shape = "JUNCTION"; isJunction = 1;}
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
		printf("\n Syntax Error found: %s\n", s);
}

int main( void ) {
	yydebug=1;
	yyparse();
}
