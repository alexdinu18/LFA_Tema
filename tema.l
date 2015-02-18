    /* Dinu Marian Alexandru 334CC */
%{
int indentation = 0;
%}
litera [A-Za-z]
start_ignore "<!"|"<?"
stop_ignore ">"
opening_tag "<"[ ]* 
closing_tag "</"[^<>]*">"|"/>"
between_tags ">"[^<]*"<"
    /* numele atributelor pot fi formate din litere si ":" */
atribut [A-Za-z:]
    /* valoare atribut */
value "\""[^<>\"]*"\""

%x IGNORE ELEM ATTRIBUTE SEMICOLON

%%
    /* ignorarea tagurilor care incep cu <! si <? */
<INITIAL>{start_ignore}             {BEGIN(IGNORE);}
<IGNORE>[^>]*                       {}
<IGNORE>{stop_ignore}               {BEGIN(0);}

    /* element */
<INITIAL>{opening_tag}              {printf("\n"); indentation++; BEGIN(ELEM);}
<ELEM,INITIAL>{closing_tag}         {indentation--; BEGIN(0);}
<ELEM>{opening_tag}                 {indentation++;}
<ELEM>">"                           {}
    /* afisarea elementelor cu indentarea corespunzatoare */
<ELEM>[^>< ]*                       {int i = indentation; 
                                     while(i > 1) {
                                         printf(" ");                 
                                         i--;
                                     }
                                    printf("%s", yytext);
                                    }
<ELEM>" "+{litera}                  {printf(" :"); BEGIN(ATTRIBUTE); REJECT;}


    /* atribute */
<ATTRIBUTE>" "                      {}
<ATTRIBUTE>{atribut}+               {printf(" %s", yytext);}
<ATTRIBUTE>"="                      {printf(" %s", yytext);}
    /* inlocuirea "" cu spatii si afisarea valorii atributului */
<ATTRIBUTE>{value}                  {yytext[0] = ' ';
                                     yytext[yyleng - 1] = ' ';
                                     printf("%s", yytext);
                                     BEGIN(SEMICOLON);}
<ATTRIBUTE>">"                      {yyless(yyleng-1); BEGIN(0);}
<ATTRIBUTE>"<"                      {yyless(yyleng-1); BEGIN(0);}
    /* separarea atributelor */
<SEMICOLON>" "+[^>]                 {printf(";"); BEGIN(ATTRIBUTE); REJECT;}
<SEMICOLON>">"                      {yyless(yyleng-1); BEGIN(0);}

    /* ignorarea caracterelor dintre taguri si a celor pt care nu exista reguli */
<INITIAL,IGNORE,ELEM,ATTRIBUTE>{between_tags} {yyless(yyleng-1); BEGIN(0);}
.|\n  {}
%%

main() { 
	yylex();
}

