%{
	#include<stdio.h>
	#include<stdlib.h>
	int yy_debug = 1;
	int yylex();
	int yyerror(char *msg);
	int counter1 = 0;
	int index = 0;
	//dont even dare touch this 
	int tempno = 0;
	int branchno = 0;
	// Variables to keep track of scope
	int prevscope = 0, currentscope = 0;
	// To get currentscope call getScope() it returns an integer denoting the number of tabs preceding a given statement
	// so first time for is encountered keep track of scope in prevscope amd every time a new for is encountered 
	// call getScope() and check if the returned value matches prevscope or is greater than previous scope
%}

%union
{
	char String_value[300];
}

%token <String_value> IF 
%token <String_value> ELIF 
%token <String_value> ELSE 
%token <String_value> WHILE 
%token <String_value> FOR 
%token <String_value> PRINT 
%token <String_value> IN 
%token <String_value> RANGE 
%token <String_value> OR
%token <String_value> AND
%token <String_value> NOT
%token <String_value> LP
%token <String_value> RP
%token <String_value> LEFT_SQUARE_P 
%token <String_value> RIGHT_SQUARE_P 
%token <String_value> LEFT_CURL_P 
%token <String_value> RIGHT_CURL_P
%token <String_value> COLON
%token <String_value> ASSIGN_OP
%token <String_value> EQ 
%token <String_value> NEQ 
%token <String_value> LT 
%token <String_value> GT 
%token <String_value> LTE 
%token <String_value> GTE
%token <String_value> PLUS_OP
%token <String_value> MINUS_OP
%token <String_value> MUL_OP
%token <String_value> DIV_OP
%token <String_value> POWER_OP
%token <String_value> IDENTIFIER 
%token <String_value> DIGIT 
%token <String_value> NEWLINE

%type <String_value> list_stmt
%type <String_value> if_stmt
%type <String_value> elif_stmt
%type <String_value> optional_else
%type <String_value> for_stmt
%type <String_value> for_test
%type <String_value> while_stmt
%type <String_value> test
%type <String_value> logical_op
%type <String_value> suite
%type <String_value> assign_id_digit

%%
start: list_stmt start |%empty {printf("\nVALID\n");} | errer {}  ;

list_stmt: if_stmt | for_stmt  | while_stmt ;

if_stmt: IF test COLON NEWLINE suite elif_stmt optional_else ;

elif_stmt: %empty | ELIF test COLON NEWLINE suite elif_stmt ;

optional_else: %empty | ELSE COLON NEWLINE suite ;

for_stmt: FOR for_test COLON NEWLINE suite {printf("go to L%d\nL%d:\n",branchno+1,branchno);branchno+=2;};

for_test: IDENTIFIER IN RANGE LP DIGIT RP {printf("\nt%d = %s\nL%d:iffalse t%d > %s goto L%d\nt%d = %s + 1\n%s = t%d\n",tempno,$1,branchno+1,tempno,$5,branchno,tempno,$1,$1,tempno);tempno++;};

while_stmt: WHILE test COLON NEWLINE suite ;


test: IDENTIFIER logical_op IDENTIFIER {printf("%s %s %s\n",$1,$2,$3);} | IDENTIFIER {printf("%s \n",$1);} ;

logical_op: EQ | NEQ | LT | GT | LTE | GTE ;

suite: assign_id_digit suite | %empty ;

assign_id_digit: IDENTIFIER ASSIGN_OP DIGIT NEWLINE {printf("%s %s %s\n",$1,$2,$3);} | IDENTIFIER ASSIGN_OP IDENTIFIER NEWLINE {printf("%s %s %s\n",$1,$2,$3);};

errer: error NEWLINE ;


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
	//printf("-----lEVEL oRDER------(number in parenthesis in number of children that node has)\n\n");
	//printlevelorder(head[index]);
	//printf("\n-----END----------------\n");
}
