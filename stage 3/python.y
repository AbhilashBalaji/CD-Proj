%{
	#include<stdio.h>
	#include<stdlib.h>
	int yy_debug = 1;
	int yylex();
	int yyerror(char *msg);
	typedef struct node1{
		struct node *left;
		struct node *middle;
		struct node *right;
		struct node *childfour;
		int scope;
		char *token;
	}node;
	node *mknode(node *left, node *middle,node *right,node *childfour, char *token);
	void printtree(node *tree);
	node* head[100];
	int counter1 = 0;
	int index = 0;
	//dont even dare touch this 
	#define YYSTYPE struct node1 *

	// Variables to keep track of scope
	int prevscope = 0, currentscope = 0;
	// To get currentscope call getScope() it returns an integer denoting the number of tabs preceding a given statement
	// so first time for is encountered keep track of scope in prevscope amd every time a new for is encountered 
	// call getScope() and check if the returned value matches prevscope or is greater than previous scope
%}

%token IF ELIF ELSE WHILE FOR PRINT IN RANGE 
%token OR AND NOT
%token LP RP LEFT_SQUARE_P RIGHT_SQUARE_P LEFT_CURL_P RIGHT_CURL_P
%token COLON
%token ASSIGN_OP EQ NEQ LT GT LTE GTE
%token PLUS_OP MINUS_OP MUL_OP DIV_OP POWER_OP
%token IDENTIFIER DIGIT NEWLINE

%%
/*
the code has been tested on for loops. has a bug for for loop. mentioned in for_test

TODO:
 - get for bug fixed
- test if and while
- add some basic stuff for suite just for demo

HINTS: mknode inserts into tree. consists of left middle and right child(feel free to change that especially for including the suite part inyo AST)
*/
start: list_stmt start |%empty {printf("\nVALID\n");} | errer {}  ;

list_stmt: if_stmt{counter1+=1;$$ = mknode($1,NULL,NULL,NULL,"IF_BLOCK");if(head[index]){printtree(head[index]);index++;head[index] = $$;}else{head[index] = $$;}}
| for_stmt {counter1+=1;$$ = mknode($1,NULL,NULL,NULL,"FOR_BLOCK");if(head[index]){printtree(head[index]);index++;head[index] = $$;}else{head[index] = $$;}}
| while_stmt {counter1+=1;$$ = mknode($1,NULL,NULL,NULL,"WHILE_BLOCK");if(head[index]){printtree(head[index]);index++;head[index] = $$;}else{head[index] = $$;}}

if_stmt: IF test COLON NEWLINE suite elif_stmt optional_else {$$ = mknode($2,$6,$7,$5,"IF");};

elif_stmt: %empty {$$ = mknode(NULL,NULL,NULL,NULL,"empty_elif");}| ELIF test COLON NEWLINE suite elif_stmt {$$ = mknode($2,$6,NULL,NULL,"ELIF");};

optional_else: %empty {$$ = mknode(NULL,NULL,NULL,NULL,"empty_else");}| ELSE COLON NEWLINE suite {$$ = mknode(NULL,NULL,NULL,NULL,"ELSE");};

for_stmt: FOR for_test COLON NEWLINE suite {$$ = mknode($2,$5,NULL,NULL,"FOR");};

// Create Nodes for all $ variables $1 , $2 , $3 if its supposed to be a token else it gets ot value from the its child branch
for_test: IDENTIFIER IN RANGE LP DIGIT RP {$1 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$3 = mknode(NULL,NULL,NULL,NULL,"RANGE");$5 = mknode(NULL,NULL,NULL,NULL,"DIGIT");$$ = mknode($1,$3,$5,NULL,"IN");}| IDENTIFIER IN IDENTIFIER {$1 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$3 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$$ = mknode($1,$3,NULL,NULL,"IN");};

while_stmt: WHILE test COLON NEWLINE suite{$$ = mknode($2,$5,NULL,NULL,"WHILE");};

//test: IDENTIFIER logical_op IDENTIFIER {$1 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$2 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$$ = mknode($1,$3,NULL,NULL,$2);}| IDENTIFIER logical_op DIGIT {$1 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$2 = mknode(NULL,NULL,NULL,NULL,"DIGIT");$$ = mknode($1,$3,NULL,NULL,$2);}| IDENTIFIER {$$ = mknode(NULL,NULL,NULL,NULL,$1);};

test: IDENTIFIER logical_op IDENTIFIER {$1 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$2 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$$ = mknode($1,$3,NULL,NULL,$2);}| IDENTIFIER logical_op DIGIT {$1 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$3 = mknode(NULL,NULL,NULL,NULL,"DIGIT");$$ = mknode($1,$3,NULL,NULL,$2);}| IDENTIFIER {$$ = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");};

logical_op: EQ {$$=(char*)"EQ";}| NEQ {$$=(char*)"NEQ";}| LT {$$=(char*)"LT";}| GT {$$=(char*)"GT";}| LTE {$$=(char*)"LTE";}| GTE {$$=(char*)"GTE";};

// Added chids for suite
suite: assign_id_digit suite {$$ = mknode($1,$2,NULL,NULL,"suite");}|%empty {$$ = mknode(NULL,NULL,NULL,NULL,"empty_suite");};

// Added chid for suite (ie need to increase number of children for each node in mknode function)
assign_id_digit: IDENTIFIER ASSIGN_OP DIGIT NEWLINE{$1 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$2 = mknode(NULL,NULL,NULL,NULL,"ASSIGN_OP");$3 = mknode(NULL,NULL,NULL,NULL,"DIGIT");$$ = mknode($1,$2,$3,NULL,"asign_id_digit");}; | IDENTIFIER ASSIGN_OP IDENTIFIER NEWLINE {$1 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$2 = mknode(NULL,NULL,NULL,NULL,"ASSIGN_OP");$3 = mknode(NULL,NULL,NULL,NULL,"IDENTIFIER");$$ = mknode($1,$2,$3,NULL,"asign_id_digit");};

errer: error NEWLINE {}

/*
arithmetic_op: IDENTIFIER ASSIGN_OP arithmetic_expression;
arithmetic_expression:  some_op id_dig | id_dig some_op id_dig | %empty;
id_dig: IDENTIFIER | DIGIT;
some_op: PLUS_OP | MINUS_OP | MUL_OP | DIV_OP | POWER_OP;
*/

%%

int yyerror(char* msg)
{
	//printf("%s",msg);
}

int main()
{
	printf("Enter input\n");
	yyparse();
	//printtree(head[index]);
	//printf("count: %d\n",counter1);
	printf("-----lEVEL oRDER------(number in parenthesis in number of children that node has)\n\n");
	printlevelorder(head[index]);
	printf("\n-----END----------------\n");
}


node *mknode(node *left, node* middle,node *right,node *childfour ,char *token) {
	printf("%s Success!!\n",token);
	/* malloc the node */
	node *newnode = (node *)malloc(sizeof(node));
	char *newstr = (char *)malloc(strlen(token)+1);
	strcpy(newstr, token);
	newnode->left = left;
	newnode->middle = middle;
	newnode->right = right;
	newnode->token = newstr;
	newnode->childfour = childfour;
	newnode->scope = getScope();
	return(newnode);
}
 
void printtree(node *tree) {

	//printf("For i have entered the devil's belly");
	int i;
	printf("\n\n");
	printf(" ROOT: %s \n", tree->token);
	if (tree->left){
		printf("Left: "); 
		printtree(tree->left);
		printf("\n");
	}
	if (tree->middle){
		printf("Mid: ");
		printtree(tree->middle);
		printf("\n");
	}
	if(tree->right){
		printf("Right: ");
		printtree(tree->right);
		printf("\n");
	}
	if(tree->childfour){
		printf("Childfour: ");
		printtree(tree->childfour);
		print("\n");
	}
//	printf("Token: %s\n",tree->token);
}

void printlevelorder(node *tree)
{
	node *queue[200];
	int front = 0, back  = 0;
	queue[back++] = tree;
	int nocld = 0;
	//printf("%s\n",tree->token);
	while(front<back)
	{
		nocld = 0;
		if(queue[front]->left)
		{
			queue[back++] = queue[front]->left;
			nocld++;
		}
		if(queue[front]->middle)
		{
			queue[back++] = queue[front]->middle;
			nocld++;
		}
		if(queue[front]->right)
		{
			queue[back++] = queue[front]->right;
			nocld++;
		}
		if(queue[front]->childfour)
		{
			queue[back++] = queue[front]->childfour;
			nocld++;
		}
		printf("%s (%d)\n",queue[front]->token,nocld);
		front++;
	}
}

