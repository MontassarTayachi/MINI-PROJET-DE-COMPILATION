%option noyywrap
%{
#include <stdio.h>
#include <string.h>

int ligne = 1;

void erreur(const char* type, const char* texte) {
    fprintf(stderr, "** Erreur : ligne %d ** %s : %s\n", ligne, type, texte);
}
%}

DIGIT      [0-9]
LETTER     [a-zA-Z_]
ID         {LETTER}({LETTER}|{DIGIT})*
INT        {DIGIT}+
EXP        ([eE][+-]?{DIGIT}+)
REAL       (({DIGIT}*"."{DIGIT}+)|({DIGIT}+"."{DIGIT}*)){EXP}?
STR        \"([^\"\n]|\\\")*\"?

%%

[ \t\r]+                      ; // Ignore espaces et tabulations
\n                            { ligne++; }

"#".*                         { printf("COMMENTAIRE : %s\n", yytext); }

"if"|"else"|"while"           { printf("MOTCLE : %s\n", yytext); }

"<="|">="|"=="|"!="|"<"|">"   { printf("OP-REL : %s\n", yytext); }

"="                            { printf("AFFECT : %s\n", yytext); }

"+"|"-"|"*"|"/"                { printf("OP-ARTHM : %s\n", yytext); }

{REAL}                        { printf("REEL : %f\n", atof(yytext)); }

{INT}                         { printf("ENTIER : %s\n", yytext); }

{ID}                          { printf("IDENT : %s\n", yytext); }
\"[^\"\n]*\n                   { erreur("fin de chaîne attendue", yytext); ligne++; }
{STR}                         { 
    if (yytext[strlen(yytext)-1] != '"') {
        erreur("fin de chaîne attendue", yytext);
    } else {
        printf("CHAINE : %s\n", yytext);
    }
}

\[^\\n]*                    { erreur("fin de chaîne attendue", yytext); }

[0-9]+\.[0-9]*[eE]            { erreur("exposant attendu", yytext); }

[0-9]+[a-zA-Z_]+              { erreur("nombre attendu", yytext); }

.                             { erreur("caractère non reconnu", yytext); }

%%

int main(int argc, char **argv) {
      ++argv, --argc;  
    if (argc > 0)  
        yyin = fopen(argv[0], "r");  
    else  
        yyin = stdin;

    freopen("resultat.txt", "w", stdout); // Redirection

    yylex();  
    return 0;
}
