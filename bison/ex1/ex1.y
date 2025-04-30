%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(char *s);
%}

%token FIN
%token SOM
%token PROD
%token NB
%token SOUS
%token DIV

%%
liste
    : instructions FIN { printf("correct\n"); }
    ;

instructions
    : instruction
    | instruction instructions
    ;

instruction
    : SOM listesom '.' { printf("Somme = %d\n", $2); }
    | PROD listeprod '.' { printf("Produit = %d\n", $2); }
    | SOUS listesous '.' { printf("Soustraction = %d\n", $2); }
    | DIV listediv '.' { printf("Division = %d\n", $2); }
    ;

listesom
    : NB { $$ = $1; }
    | listesom ',' NB { $$ = $1 + $3; }
    ;

listeprod
    : NB { $$ = $1; }
    | listeprod ',' NB { $$ = $1 * $3; }
    ;

listesous
    : NB { $$ = $1; }
    | listesous ',' NB { $$ = $1 - $3; }
    ;

listediv
    : NB { $$ = $1; }
    | listediv ',' NB { if($3 != 0) $$ = $1 / $3; else { printf("Erreur: division par zéro\n"); exit(EXIT_FAILURE); } }
    ;
%%

int yyerror(char *s)
{
    printf("Erreur : %s\n", s);
    return 0;
}

int main()
{
    yyparse();
    return 0;
}