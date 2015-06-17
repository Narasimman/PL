%{
#include <iostream>
#include <string>
#include <cstdio>
#include <stack>
#include <string.h>
using namespace std;
int yylex();
int yyerror(const char *p) { std::cerr << "error: " << p << std::endl; };
stack<string> xmlstack;
bool isValid = true;
extern "C" FILE *yyin;
%}
%union {
  int val;
  char* str;
};
%start simple_xml

%token <str> START STOP STR NUM
%type <str> tag_start 
%type <str> tag_end
%%
simple_xml : tag_set { (isValid)?cout << "Valid" << endl: cout << "Invalid" << endl;}
;
tag_set: tag_start tag_set tag_end {}
       | tag_start val tag_end {}
;
tag_start: START {
                xmlstack.push($1);
                }
;
tag_end: STOP {
                char *token  = $1;
                string poppedval = string(xmlstack.top());
                if(strcmp(poppedval.c_str(), token) != 0) {
                    isValid = false;
                }
                xmlstack.pop();
    }
;
val: {  } 
   | STR {}
;
%%

int main(){
    FILE *myfile = fopen("a.snazzle.file", "r");
    if (!myfile) {
        cout << "I can't open a.snazzle.file!" << endl;
        return -1;
    }
    yyin = myfile;
    do {
      yyparse();
    } while (!feof(yyin));
    return 0;



//    yyparse(); // A parsing
  //  return 0;
}

