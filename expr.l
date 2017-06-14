%{
#include <stdlib.h>
#include "expr.tab.h"
%}

%x comment

newLine		"\n"
lineNum		^[0-9]+[\ ]
digit		[0-9]
variable	[a-zA-Z]+
plus		"+"
minus		"-"
multiply	"*"
divide		"/"
modulo		"%"
equal		"="
inequal		"<>"
and		"&"
or		"|"
greater		"<"
smaller		">"

negation	"!"

rem		(REM[\ ])

rstart		{rem}
rstop		"\n"
rinside		[0-9a-zA-Z\ .*]+

goto		(GOTO[\ ])

let		(LET[\ ])
input		(INPUT[\ ])
dim		(DIM[\ ])
as		(AS[\ ])
print_command	(PRINT[\ ])

if		(IF[\ ])
then		(THEN[\ ])
else		(ELSE[\ ])
elseif		(ELSEIF[\ ])
endif		(ENDIF[\ ])

dquote		\"
dinside		[^"]+
string		{dquote}{dinside}{dquote}

space		"\ "

%%
{lineNum}	{yylval = atoi(yytext); return LINENUM;}
{newLine}	{return *yytext;}
{digit}		{yylval = atoi(yytext);	printf("digit lex\n"); return DIGIT;}
{rstart}	{BEGIN(comment); return REM;}
{goto}{space}*	{yylval = atoi(yytext); return GOTO;}

<comment>{rstop}	{BEGIN(INITIAL); return *yytext;}
<comment>{rinside}	{return COMMENT;}

{divide}{space}*	{printf("divid \n"); return DIVIDE;}
{plus}{space}*			{yylval = atoi(yytext); return PLUS;}
{minus}{space}*	 	{yylval = atoi(yytext); return MINUS;}
{multiply}{space}*		{yylval = atoi(yytext); return MULTI;}
{equal}{space}*			{printf("equl lex\n"); return EQUAL;}
{inequal}{space}*		{printf("inequl lex\n"); return INEQUAL;}
{greater}{space}*		{printf("greater lex\n"); return GREATER;}
{smaller}{space}*		{printf("smaller lex\n"); return SMALLER;}
{and}{space}*			{printf("and lex\n"); return AND;}
{or}{space}*			{printf("or lex\n"); return OR;}
{negation}{space}*		{printf("negation lex\n"); return NEGATION;}
{greater}{equal}{space}*	{printf("greater equal equl lex\n"); return GREATEQUAL;}
{smaller}{equal}{space}*	{printf("greater small equl lex\n"); return SMALLEQUAL;}

{dim}{space}*			{printf("dim lex\n"); return DIM;}
{as}{space}*		{printf("as\n"); return AS;}
{let}{space}*		{yylval = atoi(yytext); printf("let lex\n"); return LET;}

{if}{space}*		{yylval = atoi(yytext); printf("if\n"); return IF;}
{then}{space}*		{printf("then\n"); return THEN;}
{else}{space}*		{printf("else\n"); return ELSE;}
{endif}{space}*		{printf("endif\n"); return ENDIF;}
{elseif}{space}*	{printf("elseif\n"); return ELSEIF;}

{print_command}{space}*		{printf("print lex \n"); return PRINT;}

{variable}{space}*	{yylval = atoi(yytext); printf("val lex\n"); return VAR;}

{space}			{yylval = atoi(yytext);}
{string}		{yylval = atoi(yytext); printf("return string"); return STRING;}
.			{printf("default"); return *yytext;} 		
%%

int yywrap(void)
{
	return 1;
}
