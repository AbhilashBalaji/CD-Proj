%{
	#include<stdio.h>
	#include<stdlib.h>
	int yy_debug = 1;
	int yylex();
	int yyerror(char *msg);
%}

%token IF ELIF ELSE WHILE FOR PRINT IN RANGE 
%token OR AND NOT
%token LP RP LEFT_SQUARE_P RIGHT_SQUARE_P LEFT_CURL_P RIGHT_CURL_P
%token COLON
%token ASSIGN_OP EQ NEQ LT GT LTE GTE
%token PLUS_OP MINUS_OP MUL_OP DIV_OP POWER_OP
%token IDENTIFIER DIGIT NEWLINE

%%

start: list_stmt start | %empty {printf("\nVALID GRAMMER !!\n");};

list_stmt: if_stmt | for_stmt | while_stmt;

if_stmt: IF test COLON NEWLINE suite elif_stmt optional_else;

elif_stmt: %empty | ELIF test COLON NEWLINE suite elif_stmt;

optional_else: %empty | ELSE COLON NEWLINE suite;

for_stmt: FOR for_test COLON NEWLINE suite;

for_test: IDENTIFIER IN RANGE LP DIGIT RP | IDENTIFIER IN IDENTIFIER;	

while_stmt: WHILE test COLON NEWLINE suite;

test: IDENTIFIER EQ IDENTIFIER | IDENTIFIER EQ DIGIT ;

suite: IDENTIFIER ASSIGN_OP IDENTIFIER NEWLINE suite | IDENTIFIER ASSIGN_OP DIGIT NEWLINE suite| %empty;  


%%

int yyerror(char* msg)
{
	printf("\n\nInvalid String\n\n");
}

int main()
{
	printf("Enter input\n");
	yyparse();
}
