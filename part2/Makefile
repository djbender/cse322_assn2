all: lex yacc 
	cc lex.yy.c y.tab.c -o trains
lex:
	lex assn2-part2.l
yacc:
	yacc -d assn2-part2.y
clean:
	rm lex.yy.c y.tab.c y.tab.h trains
