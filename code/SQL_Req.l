%option noyywrap
%{
#include <stdio.h>
FILE *yyin;
%}

CREATE      ([cC][rR][eE][aA][tT][eE])
TABLE       ([tT][aA][bB][lL][eE])
PRIMARY_KEY ([pP][rR][iI][mM][aA][rR][yY][_][kK][eE][yY])
NOT_NULL    ([nN][oO][tT][_][nN][uU][lL][lL])
ESPACE      [ \t\n]+
IDENTIFIER  [a-zA-Z_][a-zA-Z0-9_]*
NUMBER      [0-9]+
COMMA       ,
SEMICOLON   ;
LPAREN      \(
RPAREN      \)
DATATYPE    ([iI][nN][tT]|[fF][lL][oO][aA][tT]|[dD][aA][tT][eE]|[vV][aA][rR][cC][hH][aA][rR]\([0-9]+\))

%%

{CREATE}        { printf("Mot-clé CREATE détecté\n"); }
{TABLE}         { printf("Mot-clé TABLE détecté\n"); }
{PRIMARY_KEY}   { printf("Mot-clé PRIMARY_KEY détecté\n"); }
{NOT_NULL}      { printf("Mot-clé NOT_NULL détecté\n"); }
{DATATYPE}      { printf("Type de donnée : %s\n", yytext); }
{IDENTIFIER}    { printf("Identifiant : %s\n", yytext); }
{NUMBER}        { printf("Nombre : %s\n", yytext); }
{COMMA}         { printf("Virgule détectée\n"); }
{SEMICOLON}     { printf("Point-virgule détecté\n"); }
{LPAREN}        { printf("Parenthèse ouvrante détectée\n"); }
{RPAREN}        { printf("Parenthèse fermante détectée\n"); }
{ESPACE}        ; /* Ignorer les espaces */
.               { printf("Caractère non reconnu: %s\n", yytext); }

%%

int main(int argc, char *argv[])  
{  
    ++argv, --argc;  
    if (argc > 0)  
        yyin = fopen(argv[0], "r");  
    else  
        yyin = stdin;

    freopen("resultat.txt", "w", stdout); // Redirection

    yylex();  
    return 0;
}