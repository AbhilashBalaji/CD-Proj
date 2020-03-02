%{
   #include "y.tab.h"
   #include<stdio.h>
   int current_indent = 0;
   int newline = 0;
   void ReturnToken(char *token)
   {
	printf("%s ",token);
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


"if"	{ReturnToken("IF"); return IF;}
"elif"	{ReturnToken("ELIF"); return ELIF;}
"else"  {ReturnToken("ELSE"); return ELSE;}
"while" {ReturnToken("WHILE"); return WHILE;}
"for"   {ReturnToken("FOR"); return FOR;}
"print" {ReturnToken("PRINT"); return PRINT;}
"in"    {ReturnToken("IN"); return IN;}
"range" {ReturnToken("RANGE"); return RANGE;}

"or"    {ReturnToken("OR"); return OR;}
"and"    {ReturnToken("AND"); return AND;}
"not"    {ReturnToken("NOT"); return NOT;}

"("     {ReturnToken("LP"); return LP;}
")"     {ReturnToken("RP"); return RP;}
"["     {ReturnToken("LEFT_SQUARE_P"); return LEFT_SQUARE_P;}
"]"     {ReturnToken("RIGHT_SQUARE_P"); return RIGHT_SQUARE_P;}
"{"     {ReturnToken("LEFT_CURL_P"); return LEFT_CURL_P;}
"}"     {ReturnToken("RIGHT_CURL_P"); return RIGHT_CURL_P;}

":"     {ReturnToken("COLON"); return COLON;}


"="     {ReturnToken("ASSIGN_OP"); return ASSIGN_OP;}

"=="    {ReturnToken("EQ"); return EQ;}
"!="    {ReturnToken("NEQ"); return NEQ;}
"<"     {ReturnToken("LT"); return LT;}
">"     {ReturnToken("GT"); return GT;}
"<="    {ReturnToken("LTE"); return LTE;}
">="    {ReturnToken("GTE"); return GTE;}

"+"    {ReturnToken("PLUS_OP"); return PLUS_OP;}
"-"    {ReturnToken("MINUS_OP"); return MINUS_OP;}
"*"    {ReturnToken("MUL_OP"); return MUL_OP;}
"/"    {ReturnToken("DIV_OP"); return DIV_OP;}
"**"   {ReturnToken("POWER_OP"); return POWER_OP;}


{alpha}({alpha}|{digit})* {ReturnToken("IDENTIFIER"); return IDENTIFIER;}

{digit}+   {ReturnToken("DIGIT"); return DIGIT;}

"\n" {ReturnToken("NEWLINE"); newline++;return NEWLINE;}

^[ \t]* {}

%%

int yywrap(){}
