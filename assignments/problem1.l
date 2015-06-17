%option noyywrap
%{
#include <iostream>
#include <string>

using namespace std;
#define YY_DECL extern "C" int yylex()
%}
%s START_TAG
%s END_TAG
%s CLOSE_TAG
TAG_NAME [a-zA-Z=0-9:\.]
%%
"<" BEGIN(START_TAG);
"<\/" BEGIN(END_TAG);
">" BEGIN(CLOSE_TAG);
<START_TAG>({TAG_NAME}+)([ a-zA-Z=0-9:\.]*)> { 
                                               string matchedText = yytext;
                                               size_t position = matchedText.find(" ");
                                               position == string::npos? position = matchedText.length() - 1 : position = position;
                                               cout << "Start " << matchedText.substr(0, position);
                                             }
<END_TAG>({TAG_NAME}+)> { string matchedText = yytext; cout << "End " <<  matchedText.substr(0, matchedText.length() - 1); }
.                       {} 
%%

int main(int argc, char *argv[]) {
    yylex();
}
