
_bloqueo:

;block.c,4 :: 		void bloqueo(void){
;block.c,5 :: 		contador++;
	INFSNZ      _contador+0, 1 
	INCF        _contador+1, 1 
;block.c,6 :: 		if (contador>=limit){
	MOVLW       54
	SUBWF       _contador+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueo21
	MOVLW       176
	SUBWF       _contador+0, 0 
L__bloqueo21:
	BTFSS       STATUS+0, 0 
	GOTO        L_bloqueo0
;block.c,7 :: 		contador=0;
	CLRF        _contador+0 
	CLRF        _contador+1 
;block.c,8 :: 		if(aa+bb+cc+dd+ee<=6 && bk==1){
	MOVF        _bb+0, 0 
	ADDWF       _aa+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        _cc+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        _dd+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVF        _ee+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueo22
	MOVF        R2, 0 
	SUBLW       6
L__bloqueo22:
	BTFSS       STATUS+0, 0 
	GOTO        L_bloqueo3
	BTFSS       _bk+0, BitPos(_bk+0) 
	GOTO        L_bloqueo3
L__bloqueo19:
;block.c,9 :: 		contador_seg++;
	INCF        _contador_seg+0, 1 
;block.c,10 :: 		if(contador_seg==5){
	MOVF        _contador_seg+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_bloqueo4
;block.c,11 :: 		BLOQUEOS++;
	MOVLW       1
	ADDWF       _BLOQUEOS+0, 1 
	MOVLW       0
	ADDWFC      _BLOQUEOS+1, 1 
	ADDWFC      _BLOQUEOS+2, 1 
	ADDWFC      _BLOQUEOS+3, 1 
;block.c,12 :: 		}
L_bloqueo4:
;block.c,13 :: 		}
L_bloqueo3:
;block.c,14 :: 		}
L_bloqueo0:
;block.c,16 :: 		if((contador==0 || contador==(limit*0.5)) && (contador_seg>=5)){
	MOVLW       0
	XORWF       _contador+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueo23
	MOVLW       0
	XORWF       _contador+0, 0 
L__bloqueo23:
	BTFSC       STATUS+0, 2 
	GOTO        L__bloqueo18
	MOVF        _contador+0, 0 
	MOVWF       R0 
	MOVF        _contador+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       90
	MOVWF       R6 
	MOVLW       139
	MOVWF       R7 
	CALL        _Equals_Double+0, 0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueo18
	GOTO        L_bloqueo9
L__bloqueo18:
	MOVLW       5
	SUBWF       _contador_seg+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_bloqueo9
L__bloqueo17:
;block.c,17 :: 		BUZZER=0;
	BCF         PORTD+0, 5 
;block.c,18 :: 		}
L_bloqueo9:
;block.c,20 :: 		if((contador==(limit*0.17) || contador==(limit*0.67)) && (contador_seg>=5)){
	MOVF        _contador+0, 0 
	MOVWF       R0 
	MOVF        _contador+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       20
	MOVWF       R6 
	MOVLW       138
	MOVWF       R7 
	CALL        _Equals_Double+0, 0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueo16
	MOVF        _contador+0, 0 
	MOVWF       R0 
	MOVF        _contador+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       144
	MOVWF       R5 
	MOVLW       18
	MOVWF       R6 
	MOVLW       140
	MOVWF       R7 
	CALL        _Equals_Double+0, 0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__bloqueo16
	GOTO        L_bloqueo14
L__bloqueo16:
	MOVLW       5
	SUBWF       _contador_seg+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_bloqueo14
L__bloqueo15:
;block.c,21 :: 		BUZZER=1;
	BSF         PORTD+0, 5 
;block.c,22 :: 		}
L_bloqueo14:
;block.c,23 :: 		}
L_end_bloqueo:
	RETURN      0
; end of _bloqueo
