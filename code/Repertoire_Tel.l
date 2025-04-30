%option noyywrap
%{
#include <stdio.h>
FILE *yyin;
%}

NOM     [A-Z][a-zA-Z0-9]*
PRENOM  [a-z]+
PRENOMS {PRENOM}([ ]+{PRENOM})*
SEP     [ ]*@[ ]*
NUM     [0-9]{2}
TEL     {NUM}([ ]{1}{NUM}){4}

%%

{NOM}[ ]+{PRENOMS}{SEP}{TEL}   {
    printf("Nom et prénoms reconnus : %s\n", yytext);
}

.|\n    ;
.*  { printf("Format invalide: %s\n", yytext); }

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
