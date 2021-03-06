/**计算器的最简版本*/

%{
#include <stdio.h>
int yylex();
void yyerror(char *s);
%}

/*declare tokens */

%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL


/**
每个bison规则中的语法符号都有一个语义值，目标符号（冒号左边的语法符号）的值在动作中代码用$$代替，
右边语法符号的语义值依次为$1, $2,直到这条规则的结束。
当词法分析器返回记号时，记号值总是储存在yyval里。其他语法符号的语义值则在语法分析器的规则里进行设置。

*/
%%

calclist:/*空规则*/
    | calclist exp EOL { printf("=%d\n", $2); }
    ;

exp: factor {$$ = $1}
   | exp ADD factor { $$ = $1 + $3; }
   | exp SUB factor { $$ = $1 - $3; }
   ;
factor: term  {$$ = $1}
   | factor MUL term { $$ = $1 * $3; }
   | factor DIV term { $$ = $1 / $3; }
   ;
term: NUMBER {$$ = $1}
    | ABS term {$$ = $1 >= 0 ? $2 : -$2}
    ;

%%
int main(int argc, char ** argv)
{
    yyparse();
}
void yyerror(char *s)
{
    fprintf(stderr, "error:%s\n", s);
}
