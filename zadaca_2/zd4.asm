@SCREEN
D = A

@i
M = D

@j
M = 0

@SCREEN
D = A

@VRH
M = D

(VERTIKALNA_START)
    // zavrsi kada je j >= 128
    @j
    D = M
    @128
    D = D - A
    @VERTIKALNA_END
    D; JGE

    @i
    A = M
    M = 1

    @32
    D = A

    @i
    M = M + D

    @j
    M = M + 1

    @VERTIKALNA_START
    0; JMP
(VERTIKALNA_END)

@i
D = M

@SJECISTE
M = D

@j
M = 0

(HORIZONTALNA_START)
    // zavrsi kad je j >= 8
    @j
    D = M
    @8
    D = D - A
    @HORIZONTALNA_END
    D; JGE

    @i
    A = M
    M = -1

    @i
    M = M + 1

    @j
    M = M + 1

    @HORIZONTALNA_START
    0; JMP
(HORIZONTALNA_END)

@SJECISTE
D = M

@i
M = D

@32
D = A

@i
M = M - D

@2
D = A

@i
A = M
M = D

@i
M = M - 1

@k
M = 0

@VRH
D = M

@i
M = D
M = M - 1

@2
D = A

@VRH
A = M
M = D

(END_ROWS)
@i
M = M + 1

@brojac
M = 1

@j
M = 0

(HIPOTENUZA_START)
    @k
    D = M
    @128
    D = D - A
    @HIPOTENUZA_END
    D; JGE

    @j
    D = M
    @16
    D = D - A
    @END_ROWS
    D; JGE

    @brojac
    D = M
    M = M + D

    @i
    A = M
    M = M + D

    @j
    M = M + 1

    @k
    M = M + 1

    @32
    D = A
    @i
    M = M + D

    @HIPOTENUZA_START
    0; JMP
(HIPOTENUZA_END)

@SJECISTE
D = M

@i
M = D

@32
D = A

@i
M = M - D

@2
D = A

@i
A = M
M = D

@i
M = M - 1

@k
M = 0

(END_ROW)
@i
M = M + 1

@brojac
M = 1

@j
M = 0

(OKOMICA_HYP_START)
    @k
    D = M
    @64
    D = D - A
    @OKOMICA_HYP_END
    D; JGE

    @j
    D = M
    @16
    D = D - A
    @END_ROW
    D; JGE

    @brojac
    D = M
    M = M + D

    @i
    A = M
    M = M + D

    @j
    M = M + 1

    @k
    M = M + 1

    @32
    D = A
    @i
    M = M - D

    @OKOMICA_HYP_START
    0; JMP
(OKOMICA_HYP_END)

(END)
@END
0; JMP