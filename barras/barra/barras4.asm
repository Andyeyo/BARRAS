
_main:

;barras4.c,6 :: 		void main() {
;barras4.c,7 :: 		init_setup();
	CALL        _init_setup+0, 0
;barras4.c,8 :: 		SUart0_Init_T();
	CALL        _SUart0_Init_T+0, 0
;barras4.c,9 :: 		while(1){
L_main0:
;barras4.c,10 :: 		detect();
	CALL        _detect+0, 0
;barras4.c,11 :: 		if(RJ45){
	BTFSS       PORTD+0, 6 
	GOTO        L_main2
;barras4.c,12 :: 		bloqueo();
	CALL        _bloqueo+0, 0
;barras4.c,13 :: 		counter();
	CALL        _counter+0, 0
;barras4.c,14 :: 		}
L_main2:
;barras4.c,16 :: 		}
	GOTO        L_main0
;barras4.c,17 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
