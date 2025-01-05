@i
M = 0;

@5
M = 0;

(LOOP_START)
	// zavrsava kad dodje do i > 4
	@i
	D = M;
	@4
	D = D - A;
	@LOOP_END
	D; JGT
	
	// je li pozitivan
	@i
	A = M;
	D = M;
	@NOT_POS
	D; JLE

	// ako je RAM[5] nula
	// stavlja RAM[i] na RAM[5]
	@5
	D = M;
	@RAM5_MIN
	D; JEQ
	
	// usporedba RAM[i] i RAM[5]
	@i
	A = M;
	D = M;
	@5
	D = D - M;
	@NOT_MIN
	D; JGE

	(RAM5_MIN)
	@i
	A = M;
	D = M;
	@5
	M = D;
	
	(NOT_POS)
	(NOT_MIN)
	@i
	M = M + 1;
	@LOOP_START
	0; JMP
(LOOP_END)

(END)
@END
0; JMP