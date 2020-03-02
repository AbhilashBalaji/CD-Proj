lex python.l
yacc python.y -d
gcc lex.yy.c y.tab.c
