%{
#include <stdio.h>
#include <stdlib.h>

int nbMots = 0;
int nbLignes = 0;
int nbCaract = 0;
int somme = 0;

FILE *yyin;
%}

%option noyywrap

%%

[ \t]+              nbCaract += yyleng;
\n                  { nbLignes++; nbCaract++; }
[0-9]+              { nbMots++; nbCaract += yyleng; somme += atoi(yytext); }
[a-zA-Z]+           { nbMots++; nbCaract += yyleng; }
.                   nbCaract++;

%%

int main(int argc, char *argv[])
{
    ++argv; --argc;

    if (argc > 0)
        yyin = fopen(argv[0], "r");
    else
        yyin = stdin;

    // 🔽 Redirection de sortie vers resultat.txt
    freopen("resultat.txt", "w", stdout);

    yylex();

    printf("Nombre de mots       : %d\n", nbMots);
    printf("Nombre de lignes     : %d\n", nbLignes);
    printf("Nombre de caractères : %d\n", nbCaract);
    printf("Somme des nombres    : %d\n", somme);

    return 0;
}
