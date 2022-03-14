	Am implementat patru module : sensors_input, square_root, display_and_drop si baggage_drop.
	In cadrul modulului sensors_input am calculat inaltimea de la care va fi lansat pachetul, 
aceasta fiind egala cu media aritmetica a senzorilor. Daca senzorul 1 sau senzorul 3 este 0, 
inaltimea este media dintre senzorul 2 si senzorul 4. Daca senzorul 2 sau senzorul 4 este 0, 
inaltimea este media dintre senzorul 1 si senzorul 3.
	Totusi, in Verilog, aproximarea rezultatului unei impartiri se face prin lipsa. Spre 
exemplu, daca inaltimea este 139.5, va fi interpretata ca 139, si nu 140 asa cum ar trebui. Prin 
urmare, am testat in cadrul programului restul impartirii sumei senzorilor la 2 sau la 4. Daca 
ultimul bit al sumei este 1, adica daca restul este 1 (in cazul impartirii la 2), sau daca ultimii 2 
biti ai sumei sunt 10 sau 11, adica daca restul este 2 sau 3 (in cazul impartirii la 4), atunci adaug 
1 valorii inaltimii.
	In cadrul modulului square_root am implementat algoritmul de pe Wikipedia
(https://en.wikipedia.org/wiki/Methods_of_computing_square_roots, sectiunea "Digit-by-digit calculation")
pentru aflarea radicalului unui numar binar, cu anumite modificari.
	Outputul are 16 biti. Deoarece inputul este pe 8 biti, radicalul va avea cel mult 4 biti pe 
partea intreaga. Astfel, primii 4 biti din out vor fi 0, iar urmatorii 12 biti vor fi rezultatul calculat
in variabila res.
	Deoarece prima bucla are rolul de a micsora variabila b (“bit” pe Wikipedia) astfel incat 
sa fie mai mica decat variabila num, res se egaleaza cu b la prima iteratie in cadrul celei de a 
doua bucle. res se va shifta la dreapta cu 1 de i ori, unde i este numarul de iteratii al buclei; de 
fapt, res se va shifta de i-1 ori, deoarece la prima shiftare, res este egal cu 0. b se va shifta la 
dreapta cu 2 de i ori. Totodata, res trebuie sa aiba rezultatul propriu-zis pe 12 biti.
Daca aleg b initial pe 23 de biti (si num tot pe 23 de biti, dintre care primii 8 vor avea 
inputul propriu zis), acesta se va putea shifta de maxim 12 ori (in functie de cat de mult a fost 
shiftat in prima bucla) pana va ajunge la 0. Asadar, res va putea avea initial pana la 23 de biti, si 
se va putea shifta de maxim 11 ori pana ce rezultatul va cuprinde ultimii 12 biti. In concluzie,
bucla va contine 12 iteratii.
	In cadrul modulului display_and_drop, am determinat daca se indeplinesc conditiile de 
lansare a pachetului si am transmis mesajele aferente cu ajutorul a 4 display-uri cu cate 7 
segmente. Daca pachetul nu poate fi lansat (drop_en = 0), atunci se afiseaza mesajul COLD. 
Daca pachetul poate fi lansat, dar a trecut timpul de actiune (drop_en = 1 si t_act > t_lim), 
atunci se afiseaza mesajul HOT. Daca pachetul poate fi lansat, iar timpul de actiune inca nu a 
depasit timpul limita (drop_en = 1 si t_act <= t_lim), atunci pachetul va fi aruncat 
(drop_activated = 1) si se afiseaza mesajul DROP.
	In cadrul top modulului baggage_drop am instantiat cele 3 module de mai sus, dar nu 
inainte de a declara cateva fire intermediare : height (pentru sensors_input, echivalent cu in din 
square_root), out (pentru square_root) si t_act (pentru display_and_drop). Conform cerintei, 
am aplicat formula t = sqrt(height) / 2, asadar t_act este egal cu out / 2
