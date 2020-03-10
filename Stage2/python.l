%{
   #include "pythony.tab.c"
   #include<stdio.h>
   int current_indent = 0;
   int newline = 0;
   int scope = 0;
   void ReturnToken(char *token)
   {
	printf("\n %s \n",token);
   }

   int count_indent(char *text)
   {
	int count = 0;
	while(text[count]!='\0' && text[count]=='\t')
			count+=4;
	//printf("\n\n count : %d\n\n",count);
	scope = count;
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
    printf("Succesful Insert\n");
    count+=1;
}

void print()
{
	int i;
	printf("\n\n SYMBOL TABLE \n\n");
	for(i=0;i<count;i++)
	{
		printf("\n<%s, %s, %d, %d>\n",nodes[i].token, nodes[i].value, nodes[i].position,nodes[i].scp);
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


"if"	{ReturnToken("IF");insert((char*)"KEYWORD",(char*)yytext,yylineno); return IF;}
"elif"	{ReturnToken("ELIF");insert((char*)"KEYWORD",(char*)yytext,yylineno); return ELIF;}
"else"  {ReturnToken("ELSE");insert((char*)"KEYWORD",(char*)yytext,yylineno); return ELSE;}
"while" {ReturnToken("WHILE");insert((char*)"KEYWORD",(char*)yytext,yylineno); return WHILE;}
"for"   {ReturnToken("FOR");insert((char*)"KEYWORD",(char*)yytext,yylineno); return FOR;}
"print" {ReturnToken("PRINT");insert((char*)"KEYWORD",(char*)yytext,yylineno); return PRINT;}
"in"    {ReturnToken("IN");insert((char*)"KEYWORD",(char*)yytext,yylineno); return IN;}
"range" {ReturnToken("RANGE");insert((char*)"KEYWORD",(char*)yytext,yylineno); return RANGE;}

"or"    {ReturnToken("OR");insert((char*)"KEYWORD",(char*)yytext,yylineno); return OR;}
"and"    {ReturnToken("AND");insert((char*)"KEYWORD",(char*)yytext,yylineno); return AND;}
"not"    {ReturnToken("NOT");insert((char*)"KEYWORD",(char*)yytext,yylineno); return NOT;}

"("     {ReturnToken("LP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return LP;}
")"     {ReturnToken("RP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return RP;}
"["     {ReturnToken("LEFT_SQUARE_P");insert((char*)"OPERATOR",(char*)yytext,yylineno); return LEFT_SQUARE_P;}
"]"     {ReturnToken("RIGHT_SQUARE_P");insert((char*)"OPERATOR",(char*)yytext,yylineno); return RIGHT_SQUARE_P;}
"{"     {ReturnToken("LEFT_CURL_P");insert((char*)"OPERATOR",(char*)yytext,yylineno); return LEFT_CURL_P;}
"}"     {ReturnToken("RIGHT_CURL_P");insert((char*)"OPERATOR",(char*)yytext,yylineno); return RIGHT_CURL_P;}

":"     {ReturnToken("COLON");insert((char*)"OPERATOR",(char*)yytext,yylineno); return COLON;}


"="     {ReturnToken("ASSIGN_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return ASSIGN_OP;}

"=="    {ReturnToken("EQ");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return EQ;}
"!="    {ReturnToken("NEQ");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return NEQ;}
"<"     {ReturnToken("LT");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return LT;}
">"     {ReturnToken("GT");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return GT;}
"<="    {ReturnToken("LTE");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return LTE;}
">="    {ReturnToken("GTE");insert((char*)"LOGOPERATOR",(char*)yytext,yylineno); return GTE;}

"+"    {ReturnToken("PLUS_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return PLUS_OP;}
"-"    {ReturnToken("MINUS_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return MINUS_OP;}
"*"    {ReturnToken("MUL_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return MUL_OP;}
"/"    {ReturnToken("DIV_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return DIV_OP;}
"**"   {ReturnToken("POWER_OP");insert((char*)"OPERATOR",(char*)yytext,yylineno); return POWER_OP;}


\[({digit}+[,]?)+\] {

insert((char*)"IDENTFIER",(char*)yytext,yylineno);
return IDENTIFIER;
}


{alpha}({alpha}|{digit})* {ReturnToken("IDENTIFIER");insert((char*)"IDENTFIER",(char*)yytext,yylineno); return IDENTIFIER;}

{digit}+   {ReturnToken("DIGIT");insert((char*)"DIGIT",(char*)yytext,yylineno); return DIGIT;}

"\n" {ReturnToken("NEWLINE"); newline++;scope=0;insert((char*)"NEWLINE",(char*)yytext,yylineno);return NEWLINE;}

^[ \t]* {count_indent(yytext);}

%%

int yywrap(){}
