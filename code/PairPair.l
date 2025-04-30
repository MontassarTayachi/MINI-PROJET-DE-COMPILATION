%{
#include <stdio.h>
FILE *yyin;
%}

%option noyywrap

pairpair (aa|bb)*((ab|ba)(aa|bb)*(ab|ba)(aa|bb)*)*

%%

{pairpair}    printf("(%s) -> nombre pair de a et de b \n", yytext);
a*b*          printf("(%s) -> suite de a puis de b \n", yytext);
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
