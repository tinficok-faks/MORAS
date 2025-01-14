def _parse_macro(self):
    self._counter = 0
    self._stack = []
    self._iter_lines(self._parse_macro_naredbe)

def _parse_macro_naredbe(self, line, p, o):
    if line[0] == '$': # pocetak naredbi

        # $MV(A,B)
        # @A
        # D=M;
        # @B
        # M=D;
        if line[1] + line[2] == "MV":
            A = line[4]
            B = line[6]
            l = "@" + A + "\nD=M\n@" + B + "\nM=D\n"
        

        # $SWP(A,B)
        # @A
        # D=M;
        # @15
        # M=D;
        # @B
        # D=M;
        # @A
        # M=D;
        # @15
        # D=M;
        # @B
        # M=D;
        elif line[1] + line[2] + line[3] == "SWP":
            A = line[5]
            B = line[7]
            l = "@" + A + "\nD=M\n"
            l += "@15\nM=D\n@" + B + "\nD=M\n"
            l += "@" + A + "\nM=D\n@15\nD=M\n@" + B + "\nM=D\n"
        

        # $ADD(A,B,D)
        # @A
        # D=M;
        # @B
        # D=D+M;
        # @D
        # M=D;
        elif line[1] + line[2] + line[3] == "ADD":
            A = line[5]
            B = line[7]
            D = line[9]
            l = "@" + A + "\nD=M\n@" + B + "\nD=D+M\n@" + D + "\nM=D\n"


        #$WHILE(A)
        # primjer
        # (WHILE1)
        # @A
        # D=M
        # @END1
        # D;JEQ
        # *program*
        # (END1)
        # $END
        elif (len(line)>=5):
            if line[1] + line[2] + line[3] + line[4] + line[5] == "WHILE":
                self._counter += 1
                self._stack.append(self._counter)
                A = line[7]
                l = "(WHILE" + str(self._counter) + ")"
                l += "\n@" + A + "\nD=M\n"
                l += "@END" + str(self._counter)
                l += "\nD;JEQ\n"
        
        # $END
        # 0; JMP
        elif line[1] + line[2] + line[3] == "END":
            n = self._stack.pop()
            l = "@WHILE" + str(n) + "\n0;JMP\n"
            l += "(END" + str(n) + ")\n"
        
        # error msg
        else:
            self._flag = False
            self._line = o
            self._errm = "Invalid macro name."
        
        return l
    else:
        return line
    