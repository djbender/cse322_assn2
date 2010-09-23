all: lex yacc 
	cc lex.yy.c y.tab.c -o trains
debug: lex yaccd
	cc lex.yy.c y.tab.c -o trains
lex:
	lex assn2-part2.l
yacc:
	yacc -d assn2-part2.y
yaccd:
	yacc --verbose --debug -d assn2-part2.y
clean:
	rm *.output *.c *.h trains
