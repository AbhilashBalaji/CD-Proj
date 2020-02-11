
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
    int position;
};


struct node nodes[1000];
//(struct node*)malloc(sizeof(struct node)*1000);

void insert(char* token,int position){
    nodes[count].token = (char*)malloc(100);
    strcpy(nodes[count].token,token);
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
		printf("\n%s %d\n",nodes[i].token,nodes[i].position);
	}
}

%}
/*** 
elif {insert((char*)"ELIF",(char*)yylineno);}
"==" {insert((char*)"=",(char*)yylineno);}
else {insert((char*)"ELSE",(char*)yylineno);}
***/

digit [0-9]
alpha [a-zA-Z]
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
if {insert((char*)"IF",yylineno);}
elif {insert((char*)"ELIF",yylineno);}
else {insert((char*)"ELSE",yylineno);}

while {insert((char*)"WHILE",yylineno);}

for {insert((char*)"FOR",yylineno);}

"=" {insert((char*)"=",yylineno);}
"==" {insert((char*)"==",yylineno);}
"<" {insert((char*)"<",yylineno);}
">" {insert((char*)">",yylineno);}
"<=" {insert((char*)"<=",yylineno);}
">=" {insert((char*)">=",yylineno);}
"!=" {insert((char*)"!=",yylineno);}

or {insert((char*)"OR",yylineno);}
and {insert((char*)"AND",yylineno);}
not {insert((char*)"NOT",yylineno);}
in {insert((char*)"IN",yylineno);}

"(" {insert((char*)"(",yylineno);}
")" {insert((char*)")",yylineno);}
"{" {insert((char*)"{",yylineno);}
"}" {insert((char*)"}",yylineno);}
"[" {insert((char*)"[",yylineno);}
"]" {insert((char*)"]",yylineno);}

":" {insert((char*)":",yylineno);}
{indent} {insert((char*)"INDENT",yylineno);}

{digit}+ {insert((char*)yytext,yylineno);}

{alpha}({alpha}|{digit})* {insert((char*)yytext,yylineno);}



%% 
  
/*** Code Section prints the number of 
capital letter present in the given input***/
int yywrap(){} 
int main(){ 
yylex();
printf("\n\nNum of lines %d\n",newline1);
return 0;
} 

