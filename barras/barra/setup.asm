
_init_setup:

;setup.c,7 :: 		void init_setup(void){
;setup.c,10 :: 		NUMPER = 0;
	CLRF        _NUMPER+0 
	CLRF        _NUMPER+1 
	CLRF        _NUMPER+2 
	CLRF        _NUMPER+3 
;setup.c,11 :: 		if(read_long(92)==555){
	MOVLW       92
	MOVWF       FARG_read_long_addr+0 
	MOVLW       0
	MOVWF       FARG_read_long_addr+1 
	CALL        _read_long+0, 0
	MOVLW       0
	MOVWF       R4 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__init_setup26
	MOVF        R4, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__init_setup26
	MOVLW       2
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__init_setup26
	MOVF        R0, 0 
	XORLW       43
L__init_setup26:
	BTFSS       STATUS+0, 2 
	GOTO        L_init_setup0
;setup.c,12 :: 		read_data();
	CALL        _read_data+0, 0
;setup.c,13 :: 		}
	GOTO        L_init_setup1
L_init_setup0:
;setup.c,15 :: 		SALEN = 0;
	CLRF        _SALEN+0 
	CLRF        _SALEN+1 
	CLRF        _SALEN+2 
	CLRF        _SALEN+3 
;setup.c,16 :: 		ENTRAN = 0;
	CLRF        _ENTRAN+0 
	CLRF        _ENTRAN+1 
	CLRF        _ENTRAN+2 
	CLRF        _ENTRAN+3 
;setup.c,17 :: 		BLOQUEOS = 0;
	CLRF        _BLOQUEOS+0 
	CLRF        _BLOQUEOS+1 
	CLRF        _BLOQUEOS+2 
	CLRF        _BLOQUEOS+3 
;setup.c,18 :: 		save_data();
	CALL        _save_data+0, 0
;setup.c,19 :: 		}
L_init_setup1:
;setup.c,21 :: 		ADCON1= 0b00001111; // Configure AN pins as digital I/O
	MOVLW       15
	MOVWF       ADCON1+0 
;setup.c,22 :: 		CMCON = 0b00000111; // Disable comparators
	MOVLW       7
	MOVWF       CMCON+0 
;setup.c,24 :: 		PORTA = 0;
	CLRF        PORTA+0 
;setup.c,25 :: 		PORTB = 0;
	CLRF        PORTB+0 
;setup.c,26 :: 		PORTC = 0;
	CLRF        PORTC+0 
;setup.c,27 :: 		PORTD = 0;
	CLRF        PORTD+0 
;setup.c,28 :: 		PORTE = 0;
	CLRF        PORTE+0 
;setup.c,30 :: 		TRISA = 0b11011011; // salidas =0  entradas=1
	MOVLW       219
	MOVWF       TRISA+0 
;setup.c,31 :: 		TRISB = 0b11111001;
	MOVLW       249
	MOVWF       TRISB+0 
;setup.c,32 :: 		TRISC = 0b11011011;
	MOVLW       219
	MOVWF       TRISC+0 
;setup.c,33 :: 		TRISD = 0b11011011;
	MOVLW       219
	MOVWF       TRISD+0 
;setup.c,34 :: 		TRISE = 0b00000110;
	MOVLW       6
	MOVWF       TRISE+0 
;setup.c,37 :: 		init_led();
	CALL        _init_led+0, 0
;setup.c,38 :: 		init_485();
	CALL        _init_485+0, 0
;setup.c,39 :: 		init_var();
	CALL        _init_var+0, 0
;setup.c,41 :: 		logA_reset();
	CALL        _logA_reset+0, 0
;setup.c,42 :: 		logB_reset();
	CALL        _logB_reset+0, 0
;setup.c,45 :: 		PWM1_Init(36000);
	BSF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       69
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;setup.c,46 :: 		PWM1_Set_Duty(25);
	MOVLW       25
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;setup.c,47 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;setup.c,50 :: 		SUart0_Init_T();
	CALL        _SUart0_Init_T+0, 0
;setup.c,52 :: 		Delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_init_setup2:
	DECFSZ      R13, 1, 1
	BRA         L_init_setup2
	DECFSZ      R12, 1, 1
	BRA         L_init_setup2
	DECFSZ      R11, 1, 1
	BRA         L_init_setup2
	NOP
	NOP
;setup.c,53 :: 		}
L_end_init_setup:
	RETURN      0
; end of _init_setup

_init_485:

;setup.c,55 :: 		void init_485(void)
;setup.c,72 :: 		}
L_end_init_485:
	RETURN      0
; end of _init_485

_init_var:

;setup.c,74 :: 		void init_var(void){
;setup.c,77 :: 		contador = 0;
	CLRF        _contador+0 
	CLRF        _contador+1 
;setup.c,78 :: 		contador_seg = 0;
	CLRF        _contador_seg+0 
;setup.c,79 :: 		bk = 0; //flag
	BCF         _bk+0, BitPos(_bk+0) 
;setup.c,82 :: 		iyn = 0;
	CLRF        _iyn+0 
;setup.c,83 :: 		ixm = 0;
	CLRF        _ixm+0 
	CLRF        _ixm+1 
	CLRF        _ixm+2 
	CLRF        _ixm+3 
;setup.c,84 :: 		sumi = 1;
	MOVLW       1
	MOVWF       _sumi+0 
;setup.c,85 :: 		jyn = 0;
	CLRF        _jyn+0 
;setup.c,86 :: 		jxm = 0;
	CLRF        _jxm+0 
	CLRF        _jxm+1 
	CLRF        _jxm+2 
	CLRF        _jxm+3 
;setup.c,87 :: 		sumj = 1;
	MOVLW       1
	MOVWF       _sumj+0 
;setup.c,90 :: 		aa=2;
	MOVLW       2
	MOVWF       _aa+0 
;setup.c,91 :: 		bb=2;
	MOVLW       2
	MOVWF       _bb+0 
;setup.c,92 :: 		cc=2;
	MOVLW       2
	MOVWF       _cc+0 
;setup.c,93 :: 		dd=2;
	MOVLW       2
	MOVWF       _dd+0 
;setup.c,94 :: 		ee=2;
	MOVLW       2
	MOVWF       _ee+0 
;setup.c,98 :: 		logAindex=100;
	MOVLW       100
	MOVWF       _logAindex+0 
;setup.c,100 :: 		logBindex=100;
	MOVLW       100
	MOVWF       _logBindex+0 
;setup.c,101 :: 		logC=0;
	CLRF        _logC+0 
;setup.c,102 :: 		pp=0; //variable para presencia
	BCF         _pp+0, BitPos(_pp+0) 
;setup.c,103 :: 		pos=0;
	CLRF        _pos+0 
;setup.c,104 :: 		Apm=-1; Apn=-1; Apx=-1; Apy=-1;
	MOVLW       255
	MOVWF       _Apm+0 
	MOVLW       255
	MOVWF       _Apn+0 
	MOVLW       255
	MOVWF       _Apx+0 
	MOVLW       255
	MOVWF       _Apy+0 
;setup.c,105 :: 		Bpm=-1; Bpn=-1; Bpx=-1; Bpy=-1;
	MOVLW       255
	MOVWF       _Bpm+0 
	MOVLW       255
	MOVWF       _Bpn+0 
	MOVLW       255
	MOVWF       _Bpx+0 
	MOVLW       255
	MOVWF       _Bpy+0 
;setup.c,108 :: 		resultadoA='X';
	MOVLW       88
	MOVWF       _resultadoA+0 
;setup.c,109 :: 		resultadoB='X';
	MOVLW       88
	MOVWF       _resultadoB+0 
;setup.c,110 :: 		resultadoT='X';
	MOVLW       88
	MOVWF       _resultadoT+0 
;setup.c,112 :: 		}
L_end_init_var:
	RETURN      0
; end of _init_var

_init_led:

;setup.c,114 :: 		void init_led(void){
;setup.c,115 :: 		BUZZER = 1; //ADD PC
	BSF         PORTD+0, 5 
;setup.c,116 :: 		LED_V = 1;
	BSF         PORTE+0, 0 
;setup.c,117 :: 		LED_A = 0;
	BCF         PORTC+0, 5 
;setup.c,118 :: 		LED_R = 0;
	BCF         PORTA+0, 5 
;setup.c,120 :: 		Delay_ms(500);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_init_led3:
	DECFSZ      R13, 1, 1
	BRA         L_init_led3
	DECFSZ      R12, 1, 1
	BRA         L_init_led3
	DECFSZ      R11, 1, 1
	BRA         L_init_led3
	NOP
;setup.c,122 :: 		LED_V = 0;
	BCF         PORTE+0, 0 
;setup.c,123 :: 		LED_A = 1;
	BSF         PORTC+0, 5 
;setup.c,124 :: 		LED_R = 0;
	BCF         PORTA+0, 5 
;setup.c,126 :: 		Delay_ms(500);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_init_led4:
	DECFSZ      R13, 1, 1
	BRA         L_init_led4
	DECFSZ      R12, 1, 1
	BRA         L_init_led4
	DECFSZ      R11, 1, 1
	BRA         L_init_led4
	NOP
;setup.c,128 :: 		LED_V = 0;
	BCF         PORTE+0, 0 
;setup.c,129 :: 		LED_A = 0;
	BCF         PORTC+0, 5 
;setup.c,130 :: 		LED_R = 1;
	BSF         PORTA+0, 5 
;setup.c,132 :: 		Delay_ms(500);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_init_led5:
	DECFSZ      R13, 1, 1
	BRA         L_init_led5
	DECFSZ      R12, 1, 1
	BRA         L_init_led5
	DECFSZ      R11, 1, 1
	BRA         L_init_led5
	NOP
;setup.c,134 :: 		LED_V = 1;
	BSF         PORTE+0, 0 
;setup.c,135 :: 		LED_A = 1;
	BSF         PORTC+0, 5 
;setup.c,136 :: 		LED_R = 1;
	BSF         PORTA+0, 5 
;setup.c,138 :: 		}
L_end_init_led:
	RETURN      0
; end of _init_led

_leerIdSlave:

;setup.c,141 :: 		char leerIdSlave(void)
;setup.c,143 :: 		if(selectSL1 == 0 && selectSL0 == 0)
	BTFSC       PORTC+0, 1 
	GOTO        L_leerIdSlave8
	BTFSC       PORTC+0, 0 
	GOTO        L_leerIdSlave8
L__leerIdSlave24:
;setup.c,145 :: 		idEsclavo = 10;
	MOVLW       10
	MOVWF       _idEsclavo+0 
;setup.c,146 :: 		}
	GOTO        L_leerIdSlave9
L_leerIdSlave8:
;setup.c,147 :: 		else if(selectSL1 == 0 && selectSL0 == 1)
	BTFSC       PORTC+0, 1 
	GOTO        L_leerIdSlave12
	BTFSS       PORTC+0, 0 
	GOTO        L_leerIdSlave12
L__leerIdSlave23:
;setup.c,149 :: 		idEsclavo = 20;
	MOVLW       20
	MOVWF       _idEsclavo+0 
;setup.c,150 :: 		}
	GOTO        L_leerIdSlave13
L_leerIdSlave12:
;setup.c,151 :: 		else if(selectSL1 == 1 && selectSL0 == 0)
	BTFSS       PORTC+0, 1 
	GOTO        L_leerIdSlave16
	BTFSC       PORTC+0, 0 
	GOTO        L_leerIdSlave16
L__leerIdSlave22:
;setup.c,153 :: 		idEsclavo = 30;
	MOVLW       30
	MOVWF       _idEsclavo+0 
;setup.c,154 :: 		}
	GOTO        L_leerIdSlave17
L_leerIdSlave16:
;setup.c,155 :: 		else if(selectSL1 == 1 && selectSL0 == 1)
	BTFSS       PORTC+0, 1 
	GOTO        L_leerIdSlave20
	BTFSS       PORTC+0, 0 
	GOTO        L_leerIdSlave20
L__leerIdSlave21:
;setup.c,157 :: 		idEsclavo = 40;
	MOVLW       40
	MOVWF       _idEsclavo+0 
;setup.c,158 :: 		}
L_leerIdSlave20:
L_leerIdSlave17:
L_leerIdSlave13:
L_leerIdSlave9:
;setup.c,159 :: 		return idEsclavo;
	MOVF        _idEsclavo+0, 0 
	MOVWF       R0 
;setup.c,160 :: 		}
L_end_leerIdSlave:
	RETURN      0
; end of _leerIdSlave
