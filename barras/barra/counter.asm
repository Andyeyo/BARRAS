
_counter:

;counter.c,3 :: 		void counter(void){
;counter.c,5 :: 		if(aa!=0 && bb!=0 && cc!=0 && dd!=0 && ee!=0){ //cuando todo estan recibiendo luz
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
L__counter72:
;counter.c,6 :: 		if(bk==1){
	BTFSS       _bk+0, BitPos(_bk+0) 
	GOTO        L_counter3
;counter.c,7 :: 		contador_seg=0;
	CLRF        _contador_seg+0 
;counter.c,8 :: 		BUZZER = 1;
	BSF         PORTD+0, 5 
;counter.c,9 :: 		bk=0;
	BCF         _bk+0, BitPos(_bk+0) 
;counter.c,10 :: 		}
L_counter3:
;counter.c,11 :: 		if(pp==1){ //flanco descendente
	BTFSS       _pp+0, BitPos(_pp+0) 
	GOTO        L_counter4
;counter.c,13 :: 		if(logC>=2){ //piso plano
	MOVLW       2
	SUBWF       _logC+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_counter5
;counter.c,17 :: 		if(Apm!=-1 && Apn!=-1 && Apx!=-1 && Apy!=-1){
	MOVF        _Apm+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter8
	MOVF        _Apn+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter8
	MOVF        _Apx+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter8
	MOVF        _Apy+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter8
L__counter71:
;counter.c,18 :: 		if(Apm>Apx){
	MOVLW       128
	XORWF       _Apx+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apm+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter9
;counter.c,20 :: 		if(Apn>Apy){ // entra-entra
	MOVLW       128
	XORWF       _Apy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter10
;counter.c,22 :: 		resultadoA='E';
	MOVLW       69
	MOVWF       _resultadoA+0 
;counter.c,23 :: 		}
	GOTO        L_counter11
L_counter10:
;counter.c,26 :: 		resultadoA='Q';
	MOVLW       81
	MOVWF       _resultadoA+0 
;counter.c,27 :: 		}
L_counter11:
;counter.c,28 :: 		}
	GOTO        L_counter12
L_counter9:
;counter.c,31 :: 		if(Apn>Apy){ //entra-sale
	MOVLW       128
	XORWF       _Apy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter13
;counter.c,33 :: 		resultadoA='P';
	MOVLW       80
	MOVWF       _resultadoA+0 
;counter.c,34 :: 		}
	GOTO        L_counter14
L_counter13:
;counter.c,37 :: 		resultadoA='S';
	MOVLW       83
	MOVWF       _resultadoA+0 
;counter.c,38 :: 		}
L_counter14:
;counter.c,39 :: 		}
L_counter12:
;counter.c,40 :: 		}
L_counter8:
;counter.c,44 :: 		if(Bpm!=-1 && Bpn!=-1 && Bpx!=-1 && Bpy!=-1){
	MOVF        _Bpm+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter17
	MOVF        _Bpn+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter17
	MOVF        _Bpx+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter17
	MOVF        _Bpy+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_counter17
L__counter70:
;counter.c,45 :: 		if(Bpm>Bpx){
	MOVLW       128
	XORWF       _Bpx+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpm+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter18
;counter.c,47 :: 		if(Bpn>Bpy){ // entra-entra
	MOVLW       128
	XORWF       _Bpy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter19
;counter.c,49 :: 		resultadoB='E';
	MOVLW       69
	MOVWF       _resultadoB+0 
;counter.c,50 :: 		}
	GOTO        L_counter20
L_counter19:
;counter.c,53 :: 		resultadoB='Q';
	MOVLW       81
	MOVWF       _resultadoB+0 
;counter.c,54 :: 		}
L_counter20:
;counter.c,55 :: 		}
	GOTO        L_counter21
L_counter18:
;counter.c,58 :: 		if(Bpn>Bpy){ //entro-sale
	MOVLW       128
	XORWF       _Bpy+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpn+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_counter22
;counter.c,60 :: 		resultadoB='P';
	MOVLW       80
	MOVWF       _resultadoB+0 
;counter.c,61 :: 		}
	GOTO        L_counter23
L_counter22:
;counter.c,64 :: 		resultadoB='S';
	MOVLW       83
	MOVWF       _resultadoB+0 
;counter.c,65 :: 		}
L_counter23:
;counter.c,66 :: 		}
L_counter21:
;counter.c,67 :: 		}
L_counter17:
;counter.c,69 :: 		if(resultadoA!='X' && resultadoB!='X'){
	MOVF        _resultadoA+0, 0 
	XORLW       88
	BTFSC       STATUS+0, 2 
	GOTO        L_counter26
	MOVF        _resultadoB+0, 0 
	XORLW       88
	BTFSC       STATUS+0, 2 
	GOTO        L_counter26
L__counter69:
;counter.c,70 :: 		if(resultadoB=='S' || (resultadoA=='S' && resultadoB=='P')){
	MOVF        _resultadoB+0, 0 
	XORLW       83
	BTFSC       STATUS+0, 2 
	GOTO        L__counter67
	MOVF        _resultadoA+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L__counter68
	MOVF        _resultadoB+0, 0 
	XORLW       80
	BTFSS       STATUS+0, 2 
	GOTO        L__counter68
	GOTO        L__counter67
L__counter68:
	GOTO        L_counter31
L__counter67:
;counter.c,71 :: 		resultadoT='S';
	MOVLW       83
	MOVWF       _resultadoT+0 
;counter.c,72 :: 		}
L_counter31:
;counter.c,73 :: 		if(resultadoB=='E' || (resultadoA=='E' && resultadoB=='Q')){
	MOVF        _resultadoB+0, 0 
	XORLW       69
	BTFSC       STATUS+0, 2 
	GOTO        L__counter65
	MOVF        _resultadoA+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L__counter66
	MOVF        _resultadoB+0, 0 
	XORLW       81
	BTFSS       STATUS+0, 2 
	GOTO        L__counter66
	GOTO        L__counter65
L__counter66:
	GOTO        L_counter36
L__counter65:
;counter.c,74 :: 		resultadoT='E';
	MOVLW       69
	MOVWF       _resultadoT+0 
;counter.c,75 :: 		}
L_counter36:
;counter.c,76 :: 		}
L_counter26:
;counter.c,78 :: 		if(pos==1){
	MOVF        _pos+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_counter37
;counter.c,79 :: 		if(resultadoT=='E'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter38
	MOVLW       88
	MOVWF       _resultadoT+0 
L_counter38:
;counter.c,80 :: 		}
	GOTO        L_counter39
L_counter37:
;counter.c,81 :: 		else if(pos==11){
	MOVF        _pos+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_counter40
;counter.c,82 :: 		if(resultadoT=='S'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter41
	MOVLW       88
	MOVWF       _resultadoT+0 
L_counter41:
;counter.c,83 :: 		}
	GOTO        L_counter42
L_counter40:
;counter.c,84 :: 		else if(pos==111){
	MOVF        _pos+0, 0 
	XORLW       111
	BTFSS       STATUS+0, 2 
	GOTO        L_counter43
;counter.c,85 :: 		if(resultadoT=='E'){ resultadoT='S'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter44
	MOVLW       83
	MOVWF       _resultadoT+0 
	GOTO        L_counter45
L_counter44:
;counter.c,86 :: 		else if(resultadoT=='S'){ resultadoT='E'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter46
	MOVLW       69
	MOVWF       _resultadoT+0 
L_counter46:
L_counter45:
;counter.c,87 :: 		}
	GOTO        L_counter47
L_counter43:
;counter.c,88 :: 		else if(pos==110){
	MOVF        _pos+0, 0 
	XORLW       110
	BTFSS       STATUS+0, 2 
	GOTO        L_counter48
;counter.c,89 :: 		if(resultadoT=='E'){ resultadoT='S'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter49
	MOVLW       83
	MOVWF       _resultadoT+0 
	GOTO        L_counter50
L_counter49:
;counter.c,90 :: 		else if(resultadoT=='S'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter51
	MOVLW       88
	MOVWF       _resultadoT+0 
L_counter51:
L_counter50:
;counter.c,91 :: 		}
	GOTO        L_counter52
L_counter48:
;counter.c,92 :: 		else if(pos==100){
	MOVF        _pos+0, 0 
	XORLW       100
	BTFSS       STATUS+0, 2 
	GOTO        L_counter53
;counter.c,93 :: 		if(resultadoT=='E'){ resultadoT='X'; }
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter54
	MOVLW       88
	MOVWF       _resultadoT+0 
	GOTO        L_counter55
L_counter54:
;counter.c,94 :: 		else if(resultadoT=='S'){ resultadoT='E'; }
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter56
	MOVLW       69
	MOVWF       _resultadoT+0 
L_counter56:
L_counter55:
;counter.c,95 :: 		}
L_counter53:
L_counter52:
L_counter47:
L_counter42:
L_counter39:
;counter.c,98 :: 		if(resultadoT=='E'){
	MOVF        _resultadoT+0, 0 
	XORLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L_counter57
;counter.c,99 :: 		ENTRAN++;
	MOVLW       1
	ADDWF       _ENTRAN+0, 1 
	MOVLW       0
	ADDWFC      _ENTRAN+1, 1 
	ADDWFC      _ENTRAN+2, 1 
	ADDWFC      _ENTRAN+3, 1 
;counter.c,100 :: 		NUMPER=ENTRAN+SALEN;
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
;counter.c,101 :: 		resultadoT='X';
	MOVLW       88
	MOVWF       _resultadoT+0 
;counter.c,104 :: 		save_data();
	CALL        _save_data+0, 0
;counter.c,105 :: 		}
L_counter57:
;counter.c,106 :: 		if(resultadoT=='S'){
	MOVF        _resultadoT+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_counter58
;counter.c,107 :: 		SALEN++;
	MOVLW       1
	ADDWF       _SALEN+0, 1 
	MOVLW       0
	ADDWFC      _SALEN+1, 1 
	ADDWFC      _SALEN+2, 1 
	ADDWFC      _SALEN+3, 1 
;counter.c,108 :: 		NUMPER=ENTRAN+SALEN;
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
;counter.c,109 :: 		resultadoT='X';
	MOVLW       88
	MOVWF       _resultadoT+0 
;counter.c,117 :: 		save_data();
	CALL        _save_data+0, 0
;counter.c,118 :: 		}
L_counter58:
;counter.c,120 :: 		}
L_counter5:
;counter.c,122 :: 		logC=0;
	CLRF        _logC+0 
;counter.c,123 :: 		Bpm=-1; Bpn=-1; Bpx=-1; Bpy=-1;
	MOVLW       255
	MOVWF       _Bpm+0 
	MOVLW       255
	MOVWF       _Bpn+0 
	MOVLW       255
	MOVWF       _Bpx+0 
	MOVLW       255
	MOVWF       _Bpy+0 
;counter.c,124 :: 		Apm=-1; Apn=-1; Apx=-1; Apy=-1;
	MOVLW       255
	MOVWF       _Apm+0 
	MOVLW       255
	MOVWF       _Apn+0 
	MOVLW       255
	MOVWF       _Apx+0 
	MOVLW       255
	MOVWF       _Apy+0 
;counter.c,125 :: 		iyn=0; ixm = 0; jyn=0; jxm=0;
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
;counter.c,126 :: 		aa=2; bb=2; cc=2; dd=2; ee=2;
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
;counter.c,127 :: 		pp=0; //flag de presencia
	BCF         _pp+0, BitPos(_pp+0) 
;counter.c,128 :: 		}
L_counter4:
;counter.c,129 :: 		}
L_counter2:
;counter.c,131 :: 		if(aa==0 || bb==0 || cc==0 || dd==0 || ee==0){ //cuando alguno esta bloqueado
	MOVF        _aa+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__counter64
	MOVF        _bb+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__counter64
	MOVF        _cc+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__counter64
	MOVF        _dd+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__counter64
	MOVF        _ee+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__counter64
	GOTO        L_counter61
L__counter64:
;counter.c,132 :: 		if(pp==0){ //flanco ascendete
	BTFSC       _pp+0, BitPos(_pp+0) 
	GOTO        L_counter62
;counter.c,133 :: 		pp=1;
	BSF         _pp+0, BitPos(_pp+0) 
;counter.c,134 :: 		resultadoA='X';
	MOVLW       88
	MOVWF       _resultadoA+0 
;counter.c,135 :: 		resultadoB='X';
	MOVLW       88
	MOVWF       _resultadoB+0 
;counter.c,136 :: 		resultadoT='X';
	MOVLW       88
	MOVWF       _resultadoT+0 
;counter.c,137 :: 		}
L_counter62:
;counter.c,138 :: 		if (bk==0){ bk=1; }
	BTFSC       _bk+0, BitPos(_bk+0) 
	GOTO        L_counter63
	BSF         _bk+0, BitPos(_bk+0) 
L_counter63:
;counter.c,139 :: 		}
L_counter61:
;counter.c,140 :: 		}
L_end_counter:
	RETURN      0
; end of _counter
