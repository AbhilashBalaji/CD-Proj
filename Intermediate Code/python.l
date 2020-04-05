%{
   #include <stdio.h>
   #include <stdlib.h>	
   #include "python.tab.h"
   int current_indent = 0;
   int newline = 0;
   int scope = 0;
   void ReturnToken(char *token)
   {
	//printf("\n %s \n",token);
   }

   int count_indent(char *text)
   {
	int count = 0;
	while(text[count]!='\0' && text[count]=='\t')
			count+=4;
	//printf("\n\n count : %d\n\n",count);
	scope = count;
   }

   int getScope()
   {
	return scope;
   }

   int newline1=0;
   int count = 0;
	struct node
	{
	    char* token;
	    char* value;
	    int position;
		int scp;
	};

struct node nodes[1000];
//(struct node*)malloc(sizeof(struct node)*1000);

void insert(char* token,char *value,int position){
    nodes[count].token = (char*)malloc(100);
    nodes[count].value = (char*)malloc(100);
    strcpy(nodes[count].token,token);
    strcpy(nodes[count].value,value);
    //strcpy(nodes[count].position,position);
    nodes[count].position = position;
	nodes[count].scp = scope;
    //printf("Succesful Insert\n");
    count+=1;
}

void print()
{
	int i;
	//printf("\n\n SYMBOL TABLE \n\n");
	for(i=0;i<count;i++)
	{
		//printf("\n<%s, %s, %d, %d>\n",nodes[i].token, nodes[i].value, nodes[i].position,nodes[i].scp);
	}
}

%}

multicomment ['''][^''']*['''][\n]?[\t]?
singlecomment [#].*[\n][\t]?

digit [0-9]
alpha [a-zA-Z]

%%

[#].*[\n][\t]? {}
['''][^''']*['''][\n]?[\t]? {}


"if"	{strcpy(yylval.String_value, yytext);ReturnToken("IF");insert((char*)"KEYWORD",(char*)yytext,yylineno); return IF;}
"elif"	{strcpy(yylval.String_value, yytext);ReturnToken("ELIF");insert((char*)"KEYWORD",(char*)yytext,yylineno); return ELIF;}
"else"  {strcpy(yylval.String_value, yytext);ReturnToken("ELSE");insert((char*)"KEYWORD",(char*)yytext,yylineno); return ELSE;}
"while" {strcpy(yylval.String_value, yytext);ReturnToken("WHILE");insert((char*)"KEYWORD",(char*)yytext,yylineno); return WHILE;}
"for"   {strcpy(yylval.String_value, yytext);ReturnToken("FOR");insert((char*)"KEYWORD",(char*)yytext,yylineno); return FOR;}
"print" {strcpy(yylval.String_value, yytext);ReturnToken("PRINT");insert((char*)"KEYWORD",(char*)yytext,yylineno); return PRINT;}
"in"    {strcpy(yylval.String_value, yytext);ReturnToken("IN");insert((char*)"KEYWORD",(char*)yytext,yylineno); return IN;}
"range" {strcpy(yylval.String_value, yytext);ReturnToken("RANGE");insert((char*)"KEYWORD",(char*)yytext,yylineno); return RANGE;}

"or"    {strcpy(yylval.String_value, yytext);ReturnToken("OR");insert((char*)"KEYWORD",(char*)yytext,yylineno); return OR;}
"and"    {strcpy(yylval.String_value, yytext);ReturnToken("AND");insert((char*)"KEYWORD",(char*)yytext,yylineno); return AND;}
"not"    {strcpy(yylval.String_value, yytext);ReturnToken("NOT");insert((char*)"KEYWORD",(char*)yytext,yylineno); return NOT;}

"("     {strcpy(yylval.String_value, yytext);ReturnToken("LP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return LP;}
")"     {strcpy(yylval.String_value, yytext);ReturnToken("RP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return RP;}
"["     {strcpy(yylval.String_value, yytext);ReturnToken("LEFT_SQUARE_P");insert((char*)"OPERATOR",(char*)yytext,yylineno); return LEFT_SQUARE_P;}
"]"     {strcpy(yylval.String_value, yytext);ReturnToken("RIGHT_SQUARE_P");insert((char*)"OPERATOR",(char*)yytext,yylineno); return RIGHT_SQUARE_P;}
"{"     {strcpy(yylval.String_value, yytext);ReturnToken("LEFT_CURL_P");insert((char*)"OPERATOR",(char*)yytext,yylineno); return LEFT_CURL_P;}
"}"     {strcpy(yylval.String_value, yytext);ReturnToken("RIGHT_CURL_P");insert((char*)"OPERATOR",(char*)yytext,yylineno); return RIGHT_CURL_P;}

":"     {strcpy(yylval.String_value, yytext);ReturnToken("COLON");insert((char*)"OPERATOR",(char*)yytext,yylineno); return COLON;}


"="     {strcpy(yylval.String_value, yytext);ReturnToken("ASSIGN_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return ASSIGN_OP;}

"=="    {strcpy(yylval.String_value, yytext);ReturnToken("EQ");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return EQ;}
"!="    {strcpy(yylval.String_value, yytext);ReturnToken("NEQ");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return NEQ;}
"<"     {strcpy(yylval.String_value, yytext);ReturnToken("LT");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return LT;}
">"     {strcpy(yylval.String_value, yytext);ReturnToken("GT");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return GT;}
"<="    {strcpy(yylval.String_value, yytext);ReturnToken("LTE");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return LTE;}
">="    {strcpy(yylval.String_value, yytext);ReturnToken("GTE");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return GTE;}

"+"    {strcpy(yylval.String_value, yytext);ReturnToken("PLUS_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return PLUS_OP;}
"-"    {strcpy(yylval.String_value, yytext);ReturnToken("MINUS_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return MINUS_OP;}
"*"    {strcpy(yylval.String_value, yytext);ReturnToken("MUL_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return MUL_OP;}
"/"    {strcpy(yylval.String_value, yytext);ReturnToken("DIV_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return DIV_OP;}
"**"   {strcpy(yylval.String_value, yytext);ReturnToken("POWER_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return POWER_OP;}


\[({digit}+[,]?)+\] {
strcpy(yylval.String_value, yytext);
insert((char*)"IDENTFIER",(char*)yytext,yylineno);
return IDENTIFIER;
}


{alpha}({alpha}|{digit})* {strcpy(yylval.String_value, yytext);ReturnToken("IDENTIFIER");insert((char*)"IDENTFIER",(char*)yytext,yylineno); return IDENTIFIER;}

{digit}+   {strcpy(yylval.String_value, yytext);ReturnToken("DIGIT");insert((char*)"DIGIT",(char*)yytext,yylineno); return DIGIT;}

"\n" {strcpy(yylval.String_value, yytext);ReturnToken("NEWLINE"); newline++;scope=0;insert((char*)"NEWLINE",(char*)yytext,yylineno);return NEWLINE;}

^[ \t]* {count_indent(yytext);}
[ ] {}
%%

int yywrap(){}
