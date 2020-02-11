lex lexer.l
gcc lex.yy.c -lfl
cat Sample.py | ./a.out
