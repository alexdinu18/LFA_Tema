# Dinu Marian Alexandru 334CC
build:
	flex tema.l
	gcc lex.yy.c -o exec -lfl
run1:
	./exec < test1.in
run2:
	./exec < test2.in
run3:
	./exec < test3.in
clean:
	rm exec lex.yy.c
