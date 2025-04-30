%option noyywrap
%{
#include <stdio.h>
#include "ex2.tab.h" // Inclusion du header généré par Bison
FILE *yyin;
%}

CREATE      ([cC][rR][eE][aA][tT][eE])
TABLE       ([tT][aA][bB][lL][eE])
IDENTIFIER  [a-zA-Z_][a-zA-Z0-9_]*
NUMBER      [0-9]+
COMMA       ,
LPAREN      \(
RPAREN      \)
VARCHAR     ([vV][aA][rR][cC][hH][aA][rR])
ESPACE      [ \t\n]+

%%

{CREATE}        { return CREATE; }
{TABLE}         { return TABLE; }
{VARCHAR}       { return VARCHAR; }
{IDENTIFIER}    { yylval.str = strdup(yytext); return IDENTIFIER; }
{NUMBER}        { yylval.num = atoi(yytext); return NUMBER; }
{COMMA}         { return COMMA; }
{LPAREN}        { return LPAREN; }
{RPAREN}        { return RPAREN; }
{ESPACE}        ; /* Ignorer les espaces */
.               { return yytext[0]; }

%%

int main(int argc, char *argv[])
{
    ++argv, --argc;
    if (argc > 0)
        yyin = fopen(argv[0], "r");
    else
        yyin = stdin;

    freopen("resultat.txt", "w", stdout); // Redirection

    yyparse();
    return 0;
}