%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(char *s);
extern int yylex();
extern int yyparse();
extern FILE *yyin;
%}

%union {
    char* str;
    int num;
}

%token CREATE TABLE VARCHAR
%token <str> IDENTIFIER
%token <num> NUMBER
%token COMMA LPAREN RPAREN

%start requete

%%

requete:
    CREATE TABLE IDENTIFIER LPAREN champs RPAREN
        { printf("Syntaxe correcte : CREATE TABLE.\n"); YYACCEPT; }
    ;

champs:
    champ
    | champs COMMA champ
    ;

champ:
    IDENTIFIER VARCHAR LPAREN NUMBER RPAREN
        { /* champ de type varchar */ }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Erreur syntaxique: %s\n", s);
    // Retourner 1 pour signaler l'échec
}
