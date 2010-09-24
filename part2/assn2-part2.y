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

int curve_count = 0;
int quantity_count = 0;
int curr_quantity = 0;
%}

%token STRACK SPIECE SSTATION ETRACK EPIECE ESTATION SATTR EATTR NAME SHAPE SIZE QUANTITY COST STRAIGHT CURVE JUNCTION KIND LOCATION EQUAL INTEGER Q STRING

%%

track: STRACK track_name pieces ETRACK  	{
			//printf("\t\ncurve_count: %i\n", curve_count); //DEBUG
			if((curve_count <= 4) || (curve_count % 2 != 0)) {
				yyerror("Semantic: 4");
				return 0;
			}
			if(quantity_count >= 100) {
				yyerror("Semantic: 5");
				return 0;
			}
			printf("Success: %i track pieces collected\n", quantity_count);
		}
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
				//yyerror("Piece Error:");
				if(station_c > 1) {
					yyerror("Syntax: Can only have one Station tag per piece");
				} else {
					yyerror("Piece didn't have one of each attribute.");
				}
				return 0;
			}
			if ( isJunction ) {
				if (size != 1) {
					yyerror("Semantic: 2");
					return 0;
				} else {
					size = 0;
				}
			}
			if (isStation){
				if ( strcmp(shape, "STRAIGHT") == 0) {//strcmp returns 0 when equal
					isStation = 0; //reset isStation
				} else {
					yyerror("Semantic: 3");
					//printf("shape: %s",shape);
					return 0;
				}
			}
			if (strcmp(shape,"CURVE")==0) { //strcmp returns 0 on TRUE
				curve_count += curr_quantity;
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
				//printf("\n\tsize given: %i.\n\n", $4); //DEBUG
				yyerror("Semantic: 1");
				return 0;
			}
			size = $4;
			size_c++;
		}
	| SATTR QUANTITY EQUAL integer EATTR		{
			if($4 < 1) {
				printf("\n\tquantity given: %i.\n\n", $4);
				yyerror("Semantic: 1");
				return 0;
			}
			curr_quantity = $4;
			quantity_count += $4;
			//printf("\n\tquantity_count: %i, quantity just added: %i\n\n", quantity_count, $4); //DEBUG
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
		fprintf(stderr, "%s\n", s);
}

int main( void ) {
	yydebug=1;
	yyparse();
	return 0;
}
