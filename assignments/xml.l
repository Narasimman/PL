%{
#include <iostream>
#include <stdlib.h>
#include "xml.tab.h"
using namespace std;
//efine YY_DECL extern "C" int yylex()
%}
%option noyywrap

%s START_TAG
%s END_TAG
%s CLOSE_TAG
TAG_NAME [a-zA-Z=0-9:\.]
%%
\<({TAG_NAME}+[ a-zA-Z=0-9:\.]*)> {
                                string matchedText = yytext;
                                size_t position = matchedText.find(" ");
                                position == string::npos? position = matchedText.length() - 2 : position = position;
                                string tag  =  matchedText.substr(1, position);
                                yylval.str = (char *)tag.c_str();
                                return START; }
\<\/({TAG_NAME}+)> { 
                    string matchedText = yytext; 
                    string tag = matchedText.substr(2, matchedText.length() - 3);
                    yylval.str = (char *)tag.c_str();
                    return STOP; }
%%
//t main(int argc, char *argv[]) {
  //  yylex();
//

