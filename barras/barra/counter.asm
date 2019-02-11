
_counter:

;counter.c,3 :: 		void counter(void){
;counter.c,5 :: 		if(aa!=0 && bb!=0 && cc!=0 && dd!=0 && ee!=0) //cuando todo estan recibiendo luz
	MOVF        _aa+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_counter2
	MOVF        _bb+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_counter2
	MOVF        _cc+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_counter2
	MOVF        _dd+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_counter2
	MOVF        _ee+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_counter2
L__counter140:
;counter.c,7 :: 		if(bk==1)
	BTFSS       _bk+0, BitPos(_bk+0) 
	GOTO        L_counter3
;counter.c,9 :: 		contador_seg=0;
	CLRF        _contador_seg+0 
;counter.c,10 :: 		BUZZER = 0;
	BCF         PORTD+0, 2 
;counter.c,11 :: 		bk=0;
	BCF         _bk+0, BitPos(_bk+0) 
;counter.c,12 :: 		}
L_counter3:
;counter.c,13 :: 		if(pp==1) //flanco descendente
	BTFSS       _pp+0, BitPos(_pp+0) 
	GOTO        L_counter4
;counter.c,16 :: 		if(jumper4==1 && logC>0)    //gradas
	BTFSS       PORTD+0, 5 
	GOTO        L_counter7
	MOVF        _logC+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_counter7
L__counter139:
;counter.c,19 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,20 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,21 :: 		SUart0_Write('-');
	MOVLW       45
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,22 :: 		SUart0_Write('G');
	MOVLW       71
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,23 :: 		SUart0_Write('R');
	MOVLW       82
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,24 :: 		SUart0_Write('A');
	MOVLW       65
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,25 :: 		SUart0_Write('-');
	MOVLW       45
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,26 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,27 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,30 :: 		if(Apm!=-1 && Apn!=-1 && Apx!=-1 && Apy!=-1)
	MOVF        _Apm+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter10
	MOVF        _Apn+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter10
	MOVF        _Apx+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter10
	MOVF        _Apy+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter10
L__counter138:
;counter.c,32 :: 		if(Apm>Apx)
	MOVLW       128
	XORWF       _Apx+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apm+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter11
;counter.c,35 :: 		if(Apn>Apy) // entra-entra
	MOVLW       128
	XORWF       _Apy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter12
;counter.c,38 :: 		resultadoA='E';
	MOVLW       69
	MOVWF       _resultadoA+0 
;counter.c,39 :: 		}
	GOTO        L_counter13
L_counter12:
;counter.c,43 :: 		resultadoA='Q';
	MOVLW       81
	MOVWF       _resultadoA+0 
;counter.c,44 :: 		}
L_counter13:
;counter.c,45 :: 		}
	GOTO        L_counter14
L_counter11:
;counter.c,48 :: 		if(Apn>Apy)  //entra-sale
	MOVLW       128
	XORWF       _Apy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter15
;counter.c,51 :: 		resultadoA='P';
	MOVLW       80
	MOVWF       _resultadoA+0 
;counter.c,52 :: 		}
	GOTO        L_counter16
L_counter15:
;counter.c,56 :: 		resultadoA='S';
	MOVLW       83
	MOVWF       _resultadoA+0 
;counter.c,57 :: 		}
L_counter16:
;counter.c,58 :: 		}
L_counter14:
;counter.c,59 :: 		}
L_counter10:
;counter.c,62 :: 		if(Bpm!=-1 && Bpn!=-1 && Bpx!=-1 && Bpy!=-1)
	MOVF        _Bpm+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter19
	MOVF        _Bpn+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter19
	MOVF        _Bpx+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter19
	MOVF        _Bpy+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter19
L__counter137:
;counter.c,64 :: 		if(Bpm>Bpx)
	MOVLW       128
	XORWF       _Bpx+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpm+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter20
;counter.c,67 :: 		if(Bpn>Bpy)  // entra-entra
	MOVLW       128
	XORWF       _Bpy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter21
;counter.c,70 :: 		resultadoB='E';
	MOVLW       69
	MOVWF       _resultadoB+0 
;counter.c,71 :: 		}
	GOTO        L_counter22
L_counter21:
;counter.c,75 :: 		resultadoB='Q';
	MOVLW       81
	MOVWF       _resultadoB+0 
;counter.c,76 :: 		}
L_counter22:
;counter.c,77 :: 		}
	GOTO        L_counter23
L_counter20:
;counter.c,81 :: 		if(Bpn>Bpy) //entro-sale
	MOVLW       128
	XORWF       _Bpy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter24
;counter.c,84 :: 		resultadoB='P';
	MOVLW       80
	MOVWF       _resultadoB+0 
;counter.c,85 :: 		}
	GOTO        L_counter25
L_counter24:
;counter.c,89 :: 		resultadoB='S';
	MOVLW       83
	MOVWF       _resultadoB+0 
;counter.c,90 :: 		}
L_counter25:
;counter.c,91 :: 		}
L_counter23:
;counter.c,92 :: 		}
L_counter19:
;counter.c,94 :: 		if(resultadoA!='X' && resultadoB!='X')
	MOVF        _resultadoA+0, 0 
	XORLW       88
	BTFSC       STATUS+0, 2 
	GOTO        L_counter28
	MOVF        _resultadoB+0, 0 
	XORLW       88
	BTFSC       STATUS+0, 2 
	GOTO        L_counter28
L__counter136:
;counter.c,96 :: 		if(resultadoB=='S' || (resultadoA=='S' && resultadoB=='P'))
	MOVF        _resultadoB+0, 0 
	XORLW       83
	BTFSC       STATUS+0, 2 
	GOTO        L__counter134
	MOVF        _resultadoA+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L__counter135
	MOVF        _resultadoB+0, 0 
	XORLW       80
	BTFSS       STATUS+0, 2 
	GOTO        L__counter135
	GOTO        L__counter134
L__counter135:
	GOTO        L_counter33
L__counter134:
;counter.c,98 :: 		resultadoT='S';
	MOVLW       83
	MOVWF       _resultadoT+0 
;counter.c,99 :: 		}
L_counter33:
;counter.c,100 :: 		if(resultadoB=='E' || (resultadoA=='E' && resultadoB=='Q'))
	MOVF        _resultadoB+0, 0 
	XORLW       69
	BTFSC       STATUS+0, 2 
	GOTO        L__counter132
	MOVF        _resultadoA+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L__counter133
	MOVF        _resultadoB+0, 0 
	XORLW       81
	BTFSS       STATUS+0, 2 
	GOTO        L__counter133
	GOTO        L__counter132
L__counter133:
	GOTO        L_counter38
L__counter132:
;counter.c,102 :: 		resultadoT='E';
	MOVLW       69
	MOVWF       _resultadoT+0 
;counter.c,103 :: 		}
L_counter38:
;counter.c,104 :: 		}
L_counter28:
;counter.c,106 :: 		if(pos==1){
	MOVF        _pos+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_counter39
;counter.c,107 :: 		if(resultadoT=='E'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter40
	MOVLW       88
	MOVWF       _resultadoT+0 
L_counter40:
;counter.c,108 :: 		}
	GOTO        L_counter41
L_counter39:
;counter.c,109 :: 		else if(pos==11){
	MOVF        _pos+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_counter42
;counter.c,110 :: 		if(resultadoT=='S'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter43
	MOVLW       88
	MOVWF       _resultadoT+0 
L_counter43:
;counter.c,111 :: 		}
	GOTO        L_counter44
L_counter42:
;counter.c,112 :: 		else if(pos==111){
	MOVF        _pos+0, 0 
	XORLW       111
	BTFSS       STATUS+0, 2 
	GOTO        L_counter45
;counter.c,113 :: 		if(resultadoT=='E'){ resultadoT='S'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter46
	MOVLW       83
	MOVWF       _resultadoT+0 
	GOTO        L_counter47
L_counter46:
;counter.c,114 :: 		else if(resultadoT=='S'){ resultadoT='E'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter48
	MOVLW       69
	MOVWF       _resultadoT+0 
L_counter48:
L_counter47:
;counter.c,115 :: 		}
	GOTO        L_counter49
L_counter45:
;counter.c,116 :: 		else if(pos==110){
	MOVF        _pos+0, 0 
	XORLW       110
	BTFSS       STATUS+0, 2 
	GOTO        L_counter50
;counter.c,117 :: 		if(resultadoT=='E'){ resultadoT='S'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter51
	MOVLW       83
	MOVWF       _resultadoT+0 
	GOTO        L_counter52
L_counter51:
;counter.c,118 :: 		else if(resultadoT=='S'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter53
	MOVLW       88
	MOVWF       _resultadoT+0 
L_counter53:
L_counter52:
;counter.c,119 :: 		}
	GOTO        L_counter54
L_counter50:
;counter.c,120 :: 		else if(pos==100){
	MOVF        _pos+0, 0 
	XORLW       100
	BTFSS       STATUS+0, 2 
	GOTO        L_counter55
;counter.c,121 :: 		if(resultadoT=='E'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter56
	MOVLW       88
	MOVWF       _resultadoT+0 
	GOTO        L_counter57
L_counter56:
;counter.c,122 :: 		else if(resultadoT=='S'){ resultadoT='E'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter58
	MOVLW       69
	MOVWF       _resultadoT+0 
L_counter58:
L_counter57:
;counter.c,123 :: 		}
L_counter55:
L_counter54:
L_counter49:
L_counter44:
L_counter41:
;counter.c,126 :: 		if(resultadoT=='E'){
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter59
;counter.c,127 :: 		ENTRAN++;
	MOVLW       1
	ADDWF       _ENTRAN+0, 1 
	MOVLW       0
	ADDWFC      _ENTRAN+1, 1 
	ADDWFC      _ENTRAN+2, 1 
	ADDWFC      _ENTRAN+3, 1 
;counter.c,128 :: 		NUMPER=ENTRAN+SALEN;
	MOVF        _SALEN+0, 0 
	ADDWF       _ENTRAN+0, 0 
	MOVWF       _NUMPER+0 
	MOVF        _SALEN+1, 0 
	ADDWFC      _ENTRAN+1, 0 
	MOVWF       _NUMPER+1 
	MOVF        _SALEN+2, 0 
	ADDWFC      _ENTRAN+2, 0 
	MOVWF       _NUMPER+2 
	MOVF        _SALEN+3, 0 
	ADDWFC      _ENTRAN+3, 0 
	MOVWF       _NUMPER+3 
;counter.c,129 :: 		resultadoT='X';
	MOVLW       88
	MOVWF       _resultadoT+0 
;counter.c,132 :: 		save_data();          //cmt PC para evitar que se guarde cada que pasa alguna persona
	CALL        _save_data+0, 0
;counter.c,133 :: 		}
L_counter59:
;counter.c,134 :: 		if(resultadoT=='S'){
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter60
;counter.c,135 :: 		SALEN++;
	MOVLW       1
	ADDWF       _SALEN+0, 1 
	MOVLW       0
	ADDWFC      _SALEN+1, 1 
	ADDWFC      _SALEN+2, 1 
	ADDWFC      _SALEN+3, 1 
;counter.c,136 :: 		NUMPER=ENTRAN+SALEN;
	MOVF        _SALEN+0, 0 
	ADDWF       _ENTRAN+0, 0 
	MOVWF       _NUMPER+0 
	MOVF        _SALEN+1, 0 
	ADDWFC      _ENTRAN+1, 0 
	MOVWF       _NUMPER+1 
	MOVF        _SALEN+2, 0 
	ADDWFC      _ENTRAN+2, 0 
	MOVWF       _NUMPER+2 
	MOVF        _SALEN+3, 0 
	ADDWFC      _ENTRAN+3, 0 
	MOVWF       _NUMPER+3 
;counter.c,137 :: 		resultadoT='X';
	MOVLW       88
	MOVWF       _resultadoT+0 
;counter.c,145 :: 		save_data();          //cmt PC para evitar que se guarde cada que pasa alguna persona
	CALL        _save_data+0, 0
;counter.c,146 :: 		}
L_counter60:
;counter.c,148 :: 		}
	GOTO        L_counter61
L_counter7:
;counter.c,149 :: 		else if(jumper4 == 0 && logC>=2) //piso plano
	BTFSC       PORTD+0, 5 
	GOTO        L_counter64
	MOVLW       2
	SUBWF       _logC+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_counter64
L__counter131:
;counter.c,152 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,153 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,154 :: 		SUart0_Write('-');
	MOVLW       45
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,155 :: 		SUart0_Write('P');
	MOVLW       80
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,156 :: 		SUart0_Write('L');
	MOVLW       76
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,157 :: 		SUart0_Write('A');
	MOVLW       65
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,158 :: 		SUart0_Write('-');
	MOVLW       45
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,159 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,160 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;counter.c,163 :: 		if(Apm!=-1 && Apn!=-1 && Apx!=-1 && Apy!=-1)
	MOVF        _Apm+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter67
	MOVF        _Apn+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter67
	MOVF        _Apx+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter67
	MOVF        _Apy+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter67
L__counter130:
;counter.c,165 :: 		if(Apm>Apx)
	MOVLW       128
	XORWF       _Apx+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apm+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter68
;counter.c,168 :: 		if(Apn>Apy) // entra-entra
	MOVLW       128
	XORWF       _Apy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter69
;counter.c,171 :: 		resultadoA='E';
	MOVLW       69
	MOVWF       _resultadoA+0 
;counter.c,172 :: 		}
	GOTO        L_counter70
L_counter69:
;counter.c,176 :: 		resultadoA='Q';
	MOVLW       81
	MOVWF       _resultadoA+0 
;counter.c,177 :: 		}
L_counter70:
;counter.c,178 :: 		}
	GOTO        L_counter71
L_counter68:
;counter.c,181 :: 		if(Apn>Apy)  //entra-sale
	MOVLW       128
	XORWF       _Apy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter72
;counter.c,184 :: 		resultadoA='P';
	MOVLW       80
	MOVWF       _resultadoA+0 
;counter.c,185 :: 		}
	GOTO        L_counter73
L_counter72:
;counter.c,189 :: 		resultadoA='S';
	MOVLW       83
	MOVWF       _resultadoA+0 
;counter.c,190 :: 		}
L_counter73:
;counter.c,191 :: 		}
L_counter71:
;counter.c,192 :: 		}
L_counter67:
;counter.c,195 :: 		if(Bpm!=-1 && Bpn!=-1 && Bpx!=-1 && Bpy!=-1)
	MOVF        _Bpm+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter76
	MOVF        _Bpn+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter76
	MOVF        _Bpx+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter76
	MOVF        _Bpy+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter76
L__counter129:
;counter.c,197 :: 		if(Bpm>Bpx)
	MOVLW       128
	XORWF       _Bpx+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpm+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter77
;counter.c,200 :: 		if(Bpn>Bpy)  // entra-entra
	MOVLW       128
	XORWF       _Bpy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter78
;counter.c,203 :: 		resultadoB='E';
	MOVLW       69
	MOVWF       _resultadoB+0 
;counter.c,204 :: 		}
	GOTO        L_counter79
L_counter78:
;counter.c,208 :: 		resultadoB='Q';
	MOVLW       81
	MOVWF       _resultadoB+0 
;counter.c,209 :: 		}
L_counter79:
;counter.c,210 :: 		}
	GOTO        L_counter80
L_counter77:
;counter.c,214 :: 		if(Bpn>Bpy) //entro-sale
	MOVLW       128
	XORWF       _Bpy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter81
;counter.c,217 :: 		resultadoB='P';
	MOVLW       80
	MOVWF       _resultadoB+0 
;counter.c,218 :: 		}
	GOTO        L_counter82
L_counter81:
;counter.c,222 :: 		resultadoB='S';
	MOVLW       83
	MOVWF       _resultadoB+0 
;counter.c,223 :: 		}
L_counter82:
;counter.c,224 :: 		}
L_counter80:
;counter.c,225 :: 		}
L_counter76:
;counter.c,227 :: 		if(resultadoA!='X' && resultadoB!='X')
	MOVF        _resultadoA+0, 0 
	XORLW       88
	BTFSC       STATUS+0, 2 
	GOTO        L_counter85
	MOVF        _resultadoB+0, 0 
	XORLW       88
	BTFSC       STATUS+0, 2 
	GOTO        L_counter85
L__counter128:
;counter.c,229 :: 		if(resultadoB=='S' || (resultadoA=='S' && resultadoB=='P'))
	MOVF        _resultadoB+0, 0 
	XORLW       83
	BTFSC       STATUS+0, 2 
	GOTO        L__counter126
	MOVF        _resultadoA+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L__counter127
	MOVF        _resultadoB+0, 0 
	XORLW       80
	BTFSS       STATUS+0, 2 
	GOTO        L__counter127
	GOTO        L__counter126
L__counter127:
	GOTO        L_counter90
L__counter126:
;counter.c,231 :: 		resultadoT='S';
	MOVLW       83
	MOVWF       _resultadoT+0 
;counter.c,232 :: 		}
L_counter90:
;counter.c,233 :: 		if(resultadoB=='E' || (resultadoA=='E' && resultadoB=='Q'))
	MOVF        _resultadoB+0, 0 
	XORLW       69
	BTFSC       STATUS+0, 2 
	GOTO        L__counter124
	MOVF        _resultadoA+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L__counter125
	MOVF        _resultadoB+0, 0 
	XORLW       81
	BTFSS       STATUS+0, 2 
	GOTO        L__counter125
	GOTO        L__counter124
L__counter125:
	GOTO        L_counter95
L__counter124:
;counter.c,235 :: 		resultadoT='E';
	MOVLW       69
	MOVWF       _resultadoT+0 
;counter.c,236 :: 		}
L_counter95:
;counter.c,237 :: 		}
L_counter85:
;counter.c,239 :: 		if(pos==1){
	MOVF        _pos+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_counter96
;counter.c,240 :: 		if(resultadoT=='E'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter97
	MOVLW       88
	MOVWF       _resultadoT+0 
L_counter97:
;counter.c,241 :: 		}
	GOTO        L_counter98
L_counter96:
;counter.c,242 :: 		else if(pos==11){
	MOVF        _pos+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_counter99
;counter.c,243 :: 		if(resultadoT=='S'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter100
	MOVLW       88
	MOVWF       _resultadoT+0 
L_counter100:
;counter.c,244 :: 		}
	GOTO        L_counter101
L_counter99:
;counter.c,245 :: 		else if(pos==111){
	MOVF        _pos+0, 0 
	XORLW       111
	BTFSS       STATUS+0, 2 
	GOTO        L_counter102
;counter.c,246 :: 		if(resultadoT=='E'){ resultadoT='S'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter103
	MOVLW       83
	MOVWF       _resultadoT+0 
	GOTO        L_counter104
L_counter103:
;counter.c,247 :: 		else if(resultadoT=='S'){ resultadoT='E'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter105
	MOVLW       69
	MOVWF       _resultadoT+0 
L_counter105:
L_counter104:
;counter.c,248 :: 		}
	GOTO        L_counter106
L_counter102:
;counter.c,249 :: 		else if(pos==110){
	MOVF        _pos+0, 0 
	XORLW       110
	BTFSS       STATUS+0, 2 
	GOTO        L_counter107
;counter.c,250 :: 		if(resultadoT=='E'){ resultadoT='S'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter108
	MOVLW       83
	MOVWF       _resultadoT+0 
	GOTO        L_counter109
L_counter108:
;counter.c,251 :: 		else if(resultadoT=='S'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter110
	MOVLW       88
	MOVWF       _resultadoT+0 
L_counter110:
L_counter109:
;counter.c,252 :: 		}
	GOTO        L_counter111
L_counter107:
;counter.c,253 :: 		else if(pos==100){
	MOVF        _pos+0, 0 
	XORLW       100
	BTFSS       STATUS+0, 2 
	GOTO        L_counter112
;counter.c,254 :: 		if(resultadoT=='E'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter113
	MOVLW       88
	MOVWF       _resultadoT+0 
	GOTO        L_counter114
L_counter113:
;counter.c,255 :: 		else if(resultadoT=='S'){ resultadoT='E'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter115
	MOVLW       69
	MOVWF       _resultadoT+0 
L_counter115:
L_counter114:
;counter.c,256 :: 		}
L_counter112:
L_counter111:
L_counter106:
L_counter101:
L_counter98:
;counter.c,259 :: 		if(resultadoT=='E'){
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter116
;counter.c,260 :: 		ENTRAN++;
	MOVLW       1
	ADDWF       _ENTRAN+0, 1 
	MOVLW       0
	ADDWFC      _ENTRAN+1, 1 
	ADDWFC      _ENTRAN+2, 1 
	ADDWFC      _ENTRAN+3, 1 
;counter.c,261 :: 		NUMPER=ENTRAN+SALEN;
	MOVF        _SALEN+0, 0 
	ADDWF       _ENTRAN+0, 0 
	MOVWF       _NUMPER+0 
	MOVF        _SALEN+1, 0 
	ADDWFC      _ENTRAN+1, 0 
	MOVWF       _NUMPER+1 
	MOVF        _SALEN+2, 0 
	ADDWFC      _ENTRAN+2, 0 
	MOVWF       _NUMPER+2 
	MOVF        _SALEN+3, 0 
	ADDWFC      _ENTRAN+3, 0 
	MOVWF       _NUMPER+3 
;counter.c,262 :: 		resultadoT='X';
	MOVLW       88
	MOVWF       _resultadoT+0 
;counter.c,265 :: 		save_data();          //cmt PC para evitar que se guarde cada que pasa alguna persona
	CALL        _save_data+0, 0
;counter.c,266 :: 		}
L_counter116:
;counter.c,267 :: 		if(resultadoT=='S'){
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter117
;counter.c,268 :: 		SALEN++;
	MOVLW       1
	ADDWF       _SALEN+0, 1 
	MOVLW       0
	ADDWFC      _SALEN+1, 1 
	ADDWFC      _SALEN+2, 1 
	ADDWFC      _SALEN+3, 1 
;counter.c,269 :: 		NUMPER=ENTRAN+SALEN;
	MOVF        _SALEN+0, 0 
	ADDWF       _ENTRAN+0, 0 
	MOVWF       _NUMPER+0 
	MOVF        _SALEN+1, 0 
	ADDWFC      _ENTRAN+1, 0 
	MOVWF       _NUMPER+1 
	MOVF        _SALEN+2, 0 
	ADDWFC      _ENTRAN+2, 0 
	MOVWF       _NUMPER+2 
	MOVF        _SALEN+3, 0 
	ADDWFC      _ENTRAN+3, 0 
	MOVWF       _NUMPER+3 
;counter.c,270 :: 		resultadoT='X';
	MOVLW       88
	MOVWF       _resultadoT+0 
;counter.c,278 :: 		save_data();          //cmt PC para evitar que se guarde cada que pasa alguna persona
	CALL        _save_data+0, 0
;counter.c,279 :: 		}
L_counter117:
;counter.c,281 :: 		}
L_counter64:
L_counter61:
;counter.c,283 :: 		logC=0;
	CLRF        _logC+0 
;counter.c,284 :: 		Bpm=-1; Bpn=-1; Bpx=-1; Bpy=-1;
	MOVLW       255
	MOVWF       _Bpm+0 
	MOVLW       255
	MOVWF       _Bpn+0 
	MOVLW       255
	MOVWF       _Bpx+0 
	MOVLW       255
	MOVWF       _Bpy+0 
;counter.c,285 :: 		Apm=-1; Apn=-1; Apx=-1; Apy=-1;
	MOVLW       255
	MOVWF       _Apm+0 
	MOVLW       255
	MOVWF       _Apn+0 
	MOVLW       255
	MOVWF       _Apx+0 
	MOVLW       255
	MOVWF       _Apy+0 
;counter.c,286 :: 		iyn=0; ixm = 0; jyn=0; jxm=0;
	CLRF        _iyn+0 
	CLRF        _ixm+0 
	CLRF        _ixm+1 
	CLRF        _ixm+2 
	CLRF        _ixm+3 
	CLRF        _jyn+0 
	CLRF        _jxm+0 
	CLRF        _jxm+1 
	CLRF        _jxm+2 
	CLRF        _jxm+3 
;counter.c,287 :: 		aa=2; bb=2; cc=2; dd=2; ee=2;
	MOVLW       2
	MOVWF       _aa+0 
	MOVLW       2
	MOVWF       _bb+0 
	MOVLW       2
	MOVWF       _cc+0 
	MOVLW       2
	MOVWF       _dd+0 
	MOVLW       2
	MOVWF       _ee+0 
;counter.c,288 :: 		pp=0; //flag de presencia
	BCF         _pp+0, BitPos(_pp+0) 
;counter.c,289 :: 		}
L_counter4:
;counter.c,290 :: 		}
L_counter2:
;counter.c,292 :: 		if(aa==0 || bb==0 || cc==0 || dd==0 || ee==0){ //cuando alguno esta bloqueado
	MOVF        _aa+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__counter123
	MOVF        _bb+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__counter123
	MOVF        _cc+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__counter123
	MOVF        _dd+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__counter123
	MOVF        _ee+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__counter123
	GOTO        L_counter120
L__counter123:
;counter.c,293 :: 		if(pp==0){ //flanco ascendete
	BTFSC       _pp+0, BitPos(_pp+0) 
	GOTO        L_counter121
;counter.c,294 :: 		pp=1;
	BSF         _pp+0, BitPos(_pp+0) 
;counter.c,295 :: 		resultadoA='X';
	MOVLW       88
	MOVWF       _resultadoA+0 
;counter.c,296 :: 		resultadoB='X';
	MOVLW       88
	MOVWF       _resultadoB+0 
;counter.c,297 :: 		resultadoT='X';
	MOVLW       88
	MOVWF       _resultadoT+0 
;counter.c,298 :: 		}
L_counter121:
;counter.c,299 :: 		if (bk==0){ bk=1; }
	BTFSC       _bk+0, BitPos(_bk+0) 
	GOTO        L_counter122
	BSF         _bk+0, BitPos(_bk+0) 
L_counter122:
;counter.c,300 :: 		}
L_counter120:
;counter.c,301 :: 		}
L_end_counter:
	RETURN      0
; end of _counter
