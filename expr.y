%{
#include <ctype.h>
#include <stdio.h>
%}

%token COMMENT
%token LINENUM
%token REM
%token GOTO
%token LET

%token DIM
%token AS

%token PRINT
%token INPUT

%token VAR

%token PLUS
%token MINUS
%token MODULO
%token MULTI
%token DIVIDE
%token GREATER
%token SMALLER
%token GREATEQUAL
%token SMALLEQUAL
%token INEQUAL
%token EQUAL
%token AND
%token OR

%token NEGATION

%token IF
%token THEN
%token ENDIF
%token ELSEIF
%token ELSE

%token DIGIT
%token STRING


%%


program	: line
	| line program
	; 

line	: LINENUM command '\n'		{printf("one line\n");}
	| '\n'
	;

command : REM COMMENT			{printf("This is comment\n");}	
	| GOTO INTEGER			{printf("goto statement number  %d", yylval);}
	| LET VAR EQUAL expr		{printf("this is assginment statemnt\n");}
	| LET VAR '[' expr ']' EQUAL expr	{printf("2d array statment\n");}
	| DIM VAR AS '[' expr ']'	{printf("2d array change statement\n");}
	| PRINT expr			{printf("print command\n");}
	| INPUT VAR			{printf("input variable\n");}
	| ifstmt			{printf("if statement \n");}
	;

ifstmt	: IF expr THEN INTEGER		{printf("if then integer\n");}
	| IF expr THEN			{printf("if then \n");}
	| ELSEIF expr THEN INTEGER	{printf("elseif then integer\n");}
	| ELSEIF expr THEN		{printf("elseif then\n");}
	| ELSE INTEGER			{printf("else integer\n");}
	| ELSE 				{printf("else\n");}
	| ENDIF				{printf("end if\n");}
	;	




expr	: STRING			{printf("string bison\n");}
	| expr PLUS term		{printf("+ bison\n");}
	| expr MINUS term		{printf("- bison \n");}
	| expr GREATER term		{printf(" > bison \n");}
	| expr SMALLER term		{printf(" < bison \n");}
	| expr GREATEQUAL term		{printf(" >= bison \n");}
	| expr SMALLEQUAL term		{printf(" <= bison \n");}
	| expr EQUAL term		{printf(" = bison \n");}
	| expr INEQUAL term		{printf(" <> bison \n");}
	| expr OR term			{printf("or\n");}
	| expr AND term			{printf("and\n");}
	| term
	;

term	: term DIVIDE factor
	| term MULTI  factor
	| factor
	;

factor	: '(' expr ')'
	| INTEGER
	| MINUS factor
	| NEGATION factor
	| VAR				{printf("variable factor\n");}
	;

INTEGER : INTEGER DIGIT
	| DIGIT
	;
%%


int yyerror(char const* s)
{
	fprintf(stderr, "%s\n", s);
}



int main(void)
{
	yyparse();
	return 0;
}


