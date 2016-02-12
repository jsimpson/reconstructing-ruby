%{
    #include <stdio.h>

    extern int yylex(void);
    extern void yyerror(const char * s);
%}

%left tPLUS

%token tSTRING tFLOAT tNUMBER tID tCONSTANT tEQUAL tGT tLT tGTE tLTE
%token tNEQUAL tPLUS tMINUS tMULT tDIV tMOD tEMARK tQMARK tAND tOR
%token tLSBRACE tRSBRACE tLPAREN tRPAREN tLBRACE tRBRACE tAT tDOT
%token tCOMMA tCOLON
%start program

%%

program: expressions

expressions: expressions expression
           | expression

expression: tNUMBER
          | expression tPLUS expression { printf("%d\n", $1 + $3); }

