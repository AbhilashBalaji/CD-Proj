
/*** Definition Section has one variable 
which can be accessed inside yylex()  
and main() ***/
%option yylineno
%{ 
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>



int newline1=0;
int count = 0;
struct node
{
    char* token;
    char* value;
    int position;
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
    printf("Succesful Insert\n");
    count+=1;
}
 
  
void print()
{
	int i;
	printf("\n\n SYMBOL TABLE \n\n");
	for(i=0;i<count;i++)
	{
		printf("\n<%s, %s, %d>\n",nodes[i].token, nodes[i].value, nodes[i].position);
	}
}

%}
/*** 
elif {insert((char*)"ELIF",(char*)yylineno);}
"==" {insert((char*)"=",(char*)yylineno);}
else {insert((char*)"ELSE",(char*)yylineno);}
***/

digit [0-9]
alpha [a-zA-Z_]
newline (\n)
indent \n[\t]+
space [ ]

singlecomment [#].*[\n\t]*
multicommentsingle  [\']{3}(.|[\r\n])*[\']{3}[\n\t]*
multicommentdouble  [\"]{3}(.|[\r\n])*[\"]{3}[\n\t]*



relop (=|==|<|>|<=|>=|!=)

%% 
\n newline1++;
{singlecomment} {}
{multicommentsingle} {} 
{multicommentdouble} {}
^([.]*)([ ]|\n) {}
(\t)\n {}


END {print();}
if {insert((char*)"KEYWORD",(char*)yytext,yylineno);}
elif {insert((char*)"KEYWORD",(char*)yytext,yylineno);}
else {insert((char*)"KEYWORD",(char*)yytext,yylineno);}

while {insert((char*)"KEYWORD",(char*)yytext,yylineno);}

for {insert((char*)"KEYWORD", (char*)yytext, yylineno);}

"=" {insert((char*)"OPERATOR",(char*)yytext , yylineno);}
"==" {insert((char*)"OPERATOR",(char*)yytext, yylineno);}
"<" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
">" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
"<=" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
">=" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
"!=" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}

or {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
and {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
not {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
in {insert((char*)"OPERATOR", (char*)yytext, yylineno);}

"(" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
")" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
"{" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
"}" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
"[" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
"]" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}

":" {insert((char*)"OPERATOR", (char*)yytext, yylineno);}
{indent} {insert((char*)"INDENT", (char*)"\t", yylineno);}

{digit}+ {insert((char*)"NUMBER", (char*)yytext, yylineno);}

{alpha}({alpha}|{digit})* {insert((char*)"INDENTIFIER", (char*)yytext, yylineno);}

{space} {}

. {insert((char*)"ERROR", (char*)yytext, yylineno);}


%% 
  
/*** Code Section prints the number of 
capital letter present in the given input***/
void yyerror()
{
	insert((char*)"ERROR", (char*)yytext, yylineno);
}
int yywrap(){} 
int main(){ 
yylex();
printf("\n\nNum of lines %d\n",newline1);
return 0;
} 

