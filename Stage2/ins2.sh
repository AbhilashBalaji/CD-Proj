lex python.l
bison python.y --debug 
gcc lex.yy.c python.tab.c -lfl