%{
#include <stdio.h>
FILE *yyin;
%}

%option noyywrap

pairpair (aa|bb)*((ab|ba)(aa|bb)*(ab|ba)(aa|bb)*)*

%%

(0|1)*           printf("(%s) -> est un nombre binaire", yytext);
.*            printf("(%s) -> est n est pas un nombre binaire \n", yytext);

%%

int main(int argc, char *argv[])  
{  
    ++argv, --argc;  

    if (argc > 0)  
        yyin = fopen(argv[0], "r");  
    else  
        yyin = stdin;

    // freopen("resultat.txt", "w", stdout); // Redirection supprimée pour affichage direct

    yylex();  
    return 0;
}
