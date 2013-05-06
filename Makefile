calc : y.tab.c lex.yy.c symtab.o
	gcc lex.yy.c y.tab.c symtab.o -o calc -lfl

y.tab.c : calc.y
	yacc -d calc.y

lex.yy.c : calc.l
	flex calc.l

symtab.o : ds/symtab.c ds/symtab.h
	gcc -Wall -c ds/symtab.c

dstests : ds/unittest.c ds/symtab.o
	gcc -Wall ds/unittest.c ds/symtab.o -o dstests

clean :
	@rm lex.yy.c y.tab.* calc dstests ds/symtab.o
