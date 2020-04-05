lex python.l
bison -d python.y
gcc lex.yy.c python.tab.c -lfl
