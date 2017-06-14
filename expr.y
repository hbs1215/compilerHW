%{
#include <ctype.h>
#include <stdio.h>
%}

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
%token UNARY_OP
%token IF
%token THEN
%token DIGIT
%token STRING


%{
struct triple
{
	int n;
	ast_nodes* C;
	char* s;
};

struct ast_node
{
	
};

triple* triple_table;
int triple_table_size=0;
ast_node* ast_table;
int ast_table_size=0;

void make_triple(int line_num, char* command)
{
	triple* new_triple;
	new_triple->n = lineNum; 
	new_triple->s = command;
	add_ast_to_triple(new_triple,lineNum);
	
}

void add_ast_to_triple(triple* new_triple, int line_num)
{
	int i=0;
	for(i=0;i<ast_table_size=0;i++)
	{
		if(ast_table[i]->lineNumber==line_num)
		{
			realloc(new_triple->ast_nodes, sizeof(ast_nodes)*(ast_table_size+1));
			
					
		}
	}
}



triple* triple_table;
ast_node* ast_table;

void execute(triple L)
{

}

%}

%%

program	: line
	| line program
	; 

line	: LINENUM command '\n'				{make_triple($1, $2);}
	;

command : REM STRING					{printf("This is comment\n");}	
	| GOTO INTEGER					{printf("goto statement number  %d", yylval);}
	| LET VAR '=' expr				{printf("this is assginment statemnt\n");}
	| LET VAR '[' expr ']''[' expr ']' '=' expr	{printf("this is also assignment\n");}
	| DIM VAR AS '[' expr ']''[' expr ']'		
	| LET VAR '[' expr ']' '=' expr			{printf("this is also assignment\n");}
	| DIM VAR AS '[' expr ']'	
	| PRINT expr					
	| INPUT VAR
	| IF expr THEN INTEGER
	;

expr	: expr PLUS term	
	| expr MINUS term
	| VAR
	| term
	;

term	: term DIVIDE factor
	| term MULTI factor
	| factor
	;

factor	: '(' expr ')'
	| INTEGER
	| UNARY_OP factor
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


