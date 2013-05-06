calc : y.tab.c lex.yy.c
	gcc lex.yy.c y.tab.c -o calc -lfl

y.tab.c : calc.y
	yacc -d calc.y

lex.yy.c : calc.l
	flex calc.l

