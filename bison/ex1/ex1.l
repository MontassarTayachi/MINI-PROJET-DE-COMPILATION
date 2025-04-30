%{
#include <stdio.h>
#include <stdlib.h>
#include "ex1.tab.h"
%}

%option caseless

%%
[0-9]+      { yylval = atoi(yytext); return NB; }
"somme"     { return SOM; }
"produit"   { return PROD; }
"soustraction" { return SOUS; }
"division"  { return DIV; }
","         { return ','; }
"."         { return '.'; }
"[$]"       { return FIN; }
[ \t\n]+    { /* Ignorer les espaces et les retours à la ligne */ }
.           { if(yytext[0] != EOF) printf("Caractère inconnu : %s\n", yytext); }
%%

int yywrap() {
    return 1;
}
