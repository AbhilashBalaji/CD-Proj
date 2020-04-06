%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#define INSLEN 200
	#define STKSIZE 1000
	int yy_debug = 1;
	int yylex();
	int yyerror(char *msg);
	int counter1 = 0;
	typedef struct indent1{
		int lno;
		int scope;
	}indent;
	indent indents[100];
	//dont even dare touch this 
	int tempno = 0;
	int branchno = 0;
	// Variables to keep track of scope
	int prevscope = 0, currentscope = 0;
	void istack(int line,int indent);
	int stack_len = -1;

	
	typedef struct StackNode
	{
		char *instruction;
	}InstructionStack;
	void insertInstruction(char *ins);
	int topofstack = 0;

	InstructionStack insStack[STKSIZE];

	/*
	for(int q=0;q<STKSIZE;q++)
	{
		insStack[q].instruction = (char *)malloc(sizeof(char)*INSLEN));
	}
	*/
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
start: list_stmt start {printf("\nVALID\n");}|%empty {printf("\nVALID\n");} | errer {printf("ERROR");}  ;

list_stmt: if_stmt{}| for_stmt {} | while_stmt {} ;

if_stmt: IF test COLON NEWLINE suite elif_stmt optional_else 
{
	//insertInstruction((char *)"iffalse ");
};

elif_stmt: %empty | ELIF test COLON NEWLINE suite elif_stmt ;

optional_else: %empty | ELSE COLON NEWLINE suite ;

for_stmt: FOR for_test COLON NEWLINE suite 
{

char *newins = (char *)malloc(sizeof(char)*INSLEN);

strcpy(newins,(char *)"go to L");

char num;
num = branchno+1+ '0';
strncat(newins,&num,1);

strncat(newins,(char *)"\n",strlen((char *)"\n"));

insertInstruction(newins);
free(newins);

printf("go to L%d:\n",branchno+1);
istack(branchno,getScope());
branchno+=2;
};

for_test: IDENTIFIER IN RANGE LP DIGIT RP 
{

char *newins;
char num;
/*
newins = (char *)malloc(sizeof(char)*INSLEN);
strcpy(newins,(char *)"\nt");

num = (tempno) + '0';
strncat(newins,&num,strlen(&num));

strncat(newins,(char *)" = ",strlen((char *)" = "));
strncat(newins,$1,strlen($1));
strncat(newins,(char *)"\n",strlen((char *)"\n"));
strncat(newins,(char *)"L",strlen((char *)"L"));

num = (branchno+1) + '0';
strncat(newins,&num,strlen(&num));
strncat(newins,(char *)":\n",strlen((char *)":\n"));
strncat(newins,(char *)"iffalse ",strlen((char *)"iffalse "));

strncat(newins,(char *)"t",strlen((char *)"t"));
num = (tempno) + '0';
strncat(newins,&num,strlen(&num));
strncat(newins,(char *)" > ",strlen((char *)" > "));
strncat(newins,$5,strlen($5));
strncat(newins,(char *)" goto L",strlen((char *)" goto L"));
num = (branchno) + '0';
strncat(newins,&num,strlen(&num));
strncat(newins,(char *)"\n",strlen((char *)"\n"));

strncat(newins,(char *)"t",strlen((char *)"t"));
num = (tempno) + '0';
strncat(newins,&num,strlen(&num));

strncat(newins,(char *)" = ",strlen((char *)" = "));
strncat(newins,(char *)$5,strlen((char *)$5));
strncat(newins,(char *)" + 1\n",strlen((char *)" + 1\n"));
strncat(newins,(char *)$1,strlen((char *)$1));
strncat(newins,(char *)" = t",strlen((char *)" = t"));
num = (tempno) + '0';
strncat(newins,&num,strlen(&num));
strncat(newins,(char *)"\n",strlen((char *)"\n"));
insertInstruction(newins);
free(newins);
*/

printf("\nt%d = %s\nL%d:iffalse t%d > %s goto L%d\nt%d = %s + 1\n%s = t%d\n",tempno,$1,branchno+1,tempno,$5,branchno,tempno,$1,$1,tempno);
tempno++;
};

while_stmt: WHILE test COLON NEWLINE suite ;


test: IDENTIFIER logical_op IDENTIFIER {printf("%s %s %s\n",$1,$2,$3);} | IDENTIFIER {printf("%s \n",$1);} ;

logical_op: EQ | NEQ | LT | GT | LTE | GTE ;

suite: assign_id_digit suite | %empty ;

assign_id_digit: IDENTIFIER ASSIGN_OP DIGIT NEWLINE 
{

char *newins = (char *)malloc(sizeof(char)*INSLEN);

strcpy(newins,$1);
strncat(newins,(char *)" ",strlen((char *)" "));
strncat(newins,$2,strlen($2));
strncat(newins,(char *)" ",strlen((char *)" "));
strncat(newins,$3,strlen($3));
strncat(newins,(char *)"\n",strlen((char *)"\n"));

insertInstruction(newins);
free(newins);

printf("%s %s %s\n",$1,$2,$3);
} 
| IDENTIFIER ASSIGN_OP IDENTIFIER NEWLINE 
{
char *newins = (char *)malloc(sizeof(char)*INSLEN);

strcpy(newins,$1);
strncat(newins,(char *)" ",strlen((char *)" "));
strncat(newins,$2,strlen($2));
strncat(newins,(char *)" ",strlen((char *)" "));
strncat(newins,$3,strlen($3));
strncat(newins,(char *)"\n",strlen((char *)"\n"));

insertInstruction(newins);
free(newins);

printf("%s %s %s\n",$1,$2,$3);
};

errer: error NEWLINE {};


%%

void insertInstruction(char *ins)
{
	insStack[topofstack].instruction = (char *)malloc(sizeof(char)*INSLEN);
	strcpy(insStack[topofstack].instruction,ins);
	strncat(insStack[topofstack].instruction,(char *)"\0",1);
	topofstack++;
}

void PrintIntermediateCode()
{
	printf("\n----------INTERMEDIATE CODE----------\n\n");
	for(int i=topofstack-1;i>=0;i--)
	{
		printf("%s",insStack[i].instruction);
	}

	printf("\n\n\n");
	for(int i=0;i<topofstack;i++)
	{
		printf("%s",insStack[i].instruction);
	}
	//printf("size of stack : %d",topofstack);
	printf("\n\n-------------------END---------------\n");
}

void istack(int line,int indent){
	if(stack_len==-1){
		stack_len+=1;
		indents[stack_len].lno = line;
		indents[stack_len].scope = indent;
	}

	else if(stack_len>=0){
		if(indent<=indents[stack_len].scope && stack_len>=0){
			printf("L%d\n",line);
			while(indent<=indents[stack_len].scope && stack_len>=0){
				printf("L%d\n",indents[stack_len].lno);
				stack_len--;
			}
		}
		if(indent>indents[stack_len].scope){
			stack_len++;
			indents[stack_len].lno = line;
			indents[stack_len].scope = indent;
		}
	}
}

int yyerror(char* msg)
{
	//printf("%s",msg);
}

int main()
{
	printf("Enter input\n");
	yyparse();
	PrintIntermediateCode();
	//printtree(head[index]);
	//printf("count: %d\n",counter1);
	//printf("-----lEVEL oRDER------(number in parenthesis in number of children that node has)\n\n");
	//printlevelorder(head[index]);
	//printf("\n-----END----------------\n");
}
