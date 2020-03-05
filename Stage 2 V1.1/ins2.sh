lex python.l
yacc python.y --debug
gcc lex.yy.c y.tab.c -lfl
