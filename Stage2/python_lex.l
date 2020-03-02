%{
   //#include "y.tab.h"
   #include<stdio.h>
   int current_indent = 0;
   void ReturnToken(char *token)
   {
	printf("%s ",token);
	/*
	if(yytext!="\n" && yytext!="\t")
		printf("< %s, %s > ",yytext,token);
	else
		printf("< %s > ",token);
	*/
   }

   int count_indent(char *text)
   {
	int count = 0;
	while(text[count]!='\0' && text[count]=='\t')
		count+=1;
	//printf("\n\n count : %d\n\n",count);
	return count;
   }
%}

multicomment ['''][^''']*['''][\n]?[\t]?
singlecomment [#].*[\n][\t]?

digit [0-9]
alpha [a-zA-Z]

%%

[#].*[\n][\t]? {}
['''][^''']*['''][\n]?[\t]? {}
[ ] {}


"if"	{ReturnToken("IF");}
"elif"	{ReturnToken("ELIF");}
"else"  {ReturnToken("ELSE");}
"while" {ReturnToken("WHILE");}
"for"   {ReturnToken("FOR");}
"print" {ReturnToken("PRINT");}
"in"    {ReturnToken("IN");}
"range" {ReturnToken("RANGE");}

"or"    {ReturnToken("OR");}
"and"    {ReturnToken("AND");}
"not"    {ReturnToken("NOT");}

"("     {ReturnToken("LP");}
")"     {ReturnToken("RP");}
"["     {ReturnToken("LEFT_SQUARE_P");}
"]"     {ReturnToken("RIGHT_SQUARE_P");}
"{"     {ReturnToken("LEFT_CURL_P");}
"}"     {ReturnToken("RIGHT_CURL_P");}

":"     {ReturnToken("COLON");}


"="     {ReturnToken("ASSIGN_OP");}

"=="    {ReturnToken("EQ");}
"!="    {ReturnToken("NEQ");}
"<"     {ReturnToken("LT");}
">"     {ReturnToken("GT");}
"<="    {ReturnToken("LTE");}
">="    {ReturnToken("GTE");}

"+"    {ReturnToken("PLUS_OP");}
"-"    {ReturnToken("MINUS_OP");}
"*"    {ReturnToken("MUL_OP");}
"/"    {ReturnToken("DIV_OP");}
"**"   {ReturnToken("POWER_OP");}


{alpha}({alpha}|{digit})* {ReturnToken("IDENTIFIER");}

{digit}+   {ReturnToken("DIGIT");}

"\n" {ReturnToken("NEWLINE");}

^[ \t]* {}

%%

int yywrap(){}
int main(){ 
yylex();
printf("\n");
return 0;
} 

