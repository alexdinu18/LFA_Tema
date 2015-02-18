Dinu Marian Alexandru 334CC
Tema 1 - Varianta 1

Tema a fost realizată sub Linux (Linux Mint 17), versiunea de flex fiind 2.5.35.

Rulare Temă:
	make build - creează executabilul exec
	make run1 - rulează tema pe testul test1.in
	make run2 - rulează tema pe testul test2.in
	make run3 - rulează tema pe testul test3.in
	make clean - șterge executabilul și fișierul lex.yy.c

Pentru rezolvarea temei am folosit 4 stări: IGNORE, ELEM, ATTRIBUTE, SEMICOLON.
IGNORE:
	Ignoră tagurile care încep cu <! și <?.
ELEM:
    Conține reguli care se ocupă cu indentarea și afișarea numelui elementului,
	precum și trecerea în starea ATTRIBUTE.
	Când avem la intrare un tag deschis "<", indentarea crește, iar când avem un
	tag închis ">", indentarea scade.
	Dacă după ce numele elementului a fost analizat și la intrare nu este tagul de 
	închidere, atunci se trece în starea ATTRIBUTE.
ATTRIBUTE:
	Conține reguli pentru afișarea atributelor și pentru înlocuirea ghilimelelor
	cu spații.
	Sunt afișate atributele cu valorile lor conform specificațiilor din enunț. 
	Dacă un element are mai mult de 1 atribut, atunci se trece în starea SEMICOLON.
	Am folosit yyless(yyleng-1) pentru a forța potrivirea pe unele reguli din starea
	INITIAL.
SEMICOLON:
	Conține reguli pentru separea atributelor prin ';' dacă sunt mai mult de 1
	atribut. 
