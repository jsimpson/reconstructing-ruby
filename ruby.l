%{
    #include <stdio.h>
    #include "parse.tab.h"

    #define VTYPE(type, value) printf("%s(%s)\n", type, value)
    #define TOKEN(id) return t##id
%}

%option noyywrap
%option yylineno

NUMBER [0-9](_[0-9]|[0-9])*

%%

#.*$ {}
\"([^"]|\\.)*\" { VTYPE("STRING", yytext); }
\'([^']|\\.)*\' { VTYPE("STRING", yytext); }
{NUMBER}(\.{NUMBER}|(\.{NUMBER})?[eE][+-]?{NUMBER}) { VTYPE("FLOAT", yytext); }
{NUMBER} { yylval = atoi(yytext); return tNUMBER; }
[a-z_][a-zA-Z0-9_]* { VTYPE("ID", yytext); }
[A-Z][a-zA-Z0-9_]* { VTYPE("CONSTANT", yytext); }
"=" { TOKEN(EQUAL); }
">" { TOKEN(GT); }
"<" { TOKEN(LT); }
">=" { TOKEN(GTE); }
"<=" { TOKEN(LTE); }
"!=" { TOKEN(NEQUAL); }
"+" { return tPLUS; }
"-" { TOKEN(MINUS); }
"*" { TOKEN(MULT); }
"/" { TOKEN(DIV); }
"%" { TOKEN(MOD); }
"!" { TOKEN(EMARK); }
"?" { TOKEN(QMARK); }
"&" { TOKEN(AND); }
"|" { TOKEN(OR); }
"[" { TOKEN(LSBRACE); }
"]" { TOKEN(RSBRACE); }
"(" { TOKEN(LPAREN); }
")" { TOKEN(RPAREN); }
"{" { TOKEN(LBRACE); }
"}" { TOKEN(RBRACE); }
"@" { TOKEN(AT); }
"." { TOKEN(DOT); }
"," { TOKEN(COMMA); }
":" { TOKEN(COLON); }
[\t ] {}
\n {}
. { fprintf(stderr, "Unknown token: '%s'\n", yytext); }

%%

void yyerror(const char * s) {
    fprintf(stderr, "%s. Unexpected \"%s\" on line %d\n", s, yytext, yylineno);
}
