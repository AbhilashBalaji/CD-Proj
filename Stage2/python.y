%{
	#include<stdio.h>
	#include<stdlib.h>
	int yy_debug = 1;
	int yylex();
	int yyerror(char *msg);
	#define YYSTYPE struct node*
    extern char *yytext;

	typedef struct node {
        char* token;
        struct node *left;
        struct node *middle; 
        struct node *right;
    }node;

	node *mknode(char *token,node *left,node *middle,node *right);
	void printtree(node *tree);

%}

%token IF ELIF ELSE WHILE FOR PRINT IN RANGE 
%token OR AND NOT
%token LP RP LEFT_SQUARE_P RIGHT_SQUARE_P LEFT_CURL_P RIGHT_CURL_P
%token COLON
%token ASSIGN_OP EQ NEQ LT GT LTE GTE
%token PLUS_OP MINUS_OP MUL_OP DIV_OP POWER_OP
%token IDENTIFIER DIGIT NEWLINE

%%

start: list_stmt start |%empty {printtree(yytext());} | errer {printf("\nPanic mode VALID\n");}  ;

list_stmt: if_stmt | for_stmt | while_stmt {$$=mknode("CODE",$1,$2,NULL);};

if_stmt: IF test COLON NEWLINE suite elif_stmt optional_else ;

elif_stmt: %empty | ELIF test COLON NEWLINE suite elif_stmt ;

optional_else: %empty | ELSE COLON NEWLINE suite ;

for_stmt: FOR for_test COLON NEWLINE suite ;

for_test: IDENTIFIER IN RANGE LP DIGIT RP | IDENTIFIER IN IDENTIFIER ;	

while_stmt: WHILE test COLON NEWLINE suite;

test: IDENTIFIER logical_op IDENTIFIER | IDENTIFIER logical_op DIGIT | IDENTIFIER ;

logical_op: EQ | NEQ | LT | GT | LTE | GTE ;

suite: assign_id_digit suite |%empty;

assign_id_digit: IDENTIFIER ASSIGN_OP DIGIT NEWLINE | IDENTIFIER ASSIGN_OP IDENTIFIER NEWLINE;

errer: error NEWLINE {printf("%s","error");}

/*
arithmetic_op: IDENTIFIER ASSIGN_OP arithmetic_expression;

arithmetic_expression:  some_op id_dig | id_dig some_op id_dig | %empty;

id_dig: IDENTIFIER | DIGIT;

some_op: PLUS_OP | MINUS_OP | MUL_OP | DIV_OP | PO5WER_OP;
*/

%%

int yyerror(char* msg)
{
	//printf("%s",msg);
	// printf("%s - %s in line:%d \n",msg,yytext,counter);
}

int main()
{
	printf("Enter input\n");
	yyparse();
	print();
}

node *mknode(char *token, node *left, node *middle, node *right)
{
    node *newnode = (node*)malloc(sizeof(node));
    char *newstr = (char*)malloc(sizeof(token)+1);
    strcpy(newstr,token);
    newnode->left = left;
    newnode->middle = middle;
    newnode->right = right;
    newnode->token = newstr;
    return newnode;
}

void printtree(node *tree)
{
    printf("%s\n",tree->token);
    if(tree->left)
        printtree(tree->left);
    if(tree->middle)
        printtree(tree->middle);
    if(tree->right)
        printtree(tree->right);
}
