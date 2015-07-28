%{
#include <iostream>
#include <stdlib.h>
#include "lisp.tab.h"  
%}

%option noyywrap

%%
[0-9]+                  { yylval.val = atoi(yytext); return NUM; }
-[0-9]+                  { yylval.val = atoi(yytext); return NUM; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }
"*"                     { return MUL; }
"/"                     { return DIV; }
"("                     { }
")"                     { }
[ \t\r\n]+              { /* Ignore white characters. */ }
.                       { std::cerr << "Invalid token" << std::endl; exit(1); }

%%

