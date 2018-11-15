
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
	GOTO        L__init_setup8
	MOVF        R4, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__init_setup8
	MOVLW       2
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__init_setup8
	MOVF        R0, 0 
	XORLW       43
L__init_setup8:
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
;setup.c,21 :: 		TRISA = 0b11011011; // salidas =0  entradas=1
	MOVLW       219
	MOVWF       TRISA+0 
;setup.c,22 :: 		TRISB = 0b11111001;
	MOVLW       249
	MOVWF       TRISB+0 
;setup.c,23 :: 		TRISC = 0b11011011;
	MOVLW       219
	MOVWF       TRISC+0 
;setup.c,24 :: 		TRISD = 0b11011011;
	MOVLW       219
	MOVWF       TRISD+0 
;setup.c,25 :: 		TRISE = 0b00000110;
	MOVLW       6
	MOVWF       TRISE+0 
;setup.c,27 :: 		ADCON1= 0b00001111; // Configure AN pins as digital I/O
	MOVLW       15
	MOVWF       ADCON1+0 
;setup.c,28 :: 		CMCON = 0b00000111; // Disable comparators
	MOVLW       7
	MOVWF       CMCON+0 
;setup.c,31 :: 		init_led();
	CALL        _init_led+0, 0
;setup.c,32 :: 		init_485();
	CALL        _init_485+0, 0
;setup.c,33 :: 		init_var();
	CALL        _init_var+0, 0
;setup.c,35 :: 		logA_reset();
	CALL        _logA_reset+0, 0
;setup.c,36 :: 		logB_reset();
	CALL        _logB_reset+0, 0
;setup.c,39 :: 		PWM1_Init(36000);
	BCF         T2CON+0, 0, 0
	BCF         T2CON+0, 1, 0
	MOVLW       5
	MOVWF       PR2+0, 0
	CALL        _PWM1_Init+0, 0
;setup.c,40 :: 		PWM1_Set_Duty(25);
	MOVLW       25
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;setup.c,41 :: 		PWM1_Start();
	CALL        _PWM1_Start+0, 0
;setup.c,43 :: 		Delay_ms(100);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_init_setup2:
	DECFSZ      R13, 1, 1
	BRA         L_init_setup2
	DECFSZ      R12, 1, 1
	BRA         L_init_setup2
	NOP
;setup.c,44 :: 		}
L_end_init_setup:
	RETURN      0
; end of _init_setup

_init_485:

;setup.c,46 :: 		void init_485(void){
;setup.c,47 :: 		UART1_Init(9600);                  // initialize UART1 module
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;setup.c,48 :: 		Delay_ms(100);
	MOVLW       33
	MOVWF       R12, 0
	MOVLW       118
	MOVWF       R13, 0
L_init_4853:
	DECFSZ      R13, 1, 1
	BRA         L_init_4853
	DECFSZ      R12, 1, 1
	BRA         L_init_4853
	NOP
;setup.c,49 :: 		RS485Slave_Init(slave_id);              // Intialize MCU as slave, address 160
	MOVLW       10
	MOVWF       FARG_RS485Slave_Init_slave_address+0 
	CALL        _RS485Slave_Init+0, 0
;setup.c,52 :: 		RCIE_bit = 0;                      // enable interrupt on UART1 receive
	BCF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;setup.c,53 :: 		TXIE_bit = 0;                      // disable interrupt on UART1 transmit
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;setup.c,56 :: 		PEIE_bit = 0;                      // disable peripheral interrupts
	BCF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;setup.c,57 :: 		GIE_bit = 0;                       // disable all interrupts
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;setup.c,58 :: 		}
L_end_init_485:
	RETURN      0
; end of _init_485

_init_var:

;setup.c,60 :: 		void init_var(void){
;setup.c,63 :: 		contador = 0;
	CLRF        _contador+0 
	CLRF        _contador+1 
;setup.c,64 :: 		contador_seg = 0;
	CLRF        _contador_seg+0 
;setup.c,65 :: 		bk = 0; //flag
	BCF         _bk+0, BitPos(_bk+0) 
;setup.c,68 :: 		iyn = 0;
	CLRF        _iyn+0 
;setup.c,69 :: 		ixm = 0;
	CLRF        _ixm+0 
	CLRF        _ixm+1 
	CLRF        _ixm+2 
	CLRF        _ixm+3 
;setup.c,70 :: 		sumi = 1;
	MOVLW       1
	MOVWF       _sumi+0 
;setup.c,71 :: 		jyn = 0;
	CLRF        _jyn+0 
;setup.c,72 :: 		jxm = 0;
	CLRF        _jxm+0 
	CLRF        _jxm+1 
	CLRF        _jxm+2 
	CLRF        _jxm+3 
;setup.c,73 :: 		sumj = 1;
	MOVLW       1
	MOVWF       _sumj+0 
;setup.c,76 :: 		aa=2;
	MOVLW       2
	MOVWF       _aa+0 
;setup.c,77 :: 		bb=2;
	MOVLW       2
	MOVWF       _bb+0 
;setup.c,78 :: 		cc=2;
	MOVLW       2
	MOVWF       _cc+0 
;setup.c,79 :: 		dd=2;
	MOVLW       2
	MOVWF       _dd+0 
;setup.c,80 :: 		ee=2;
	MOVLW       2
	MOVWF       _ee+0 
;setup.c,84 :: 		logAindex=100;
	MOVLW       100
	MOVWF       _logAindex+0 
;setup.c,86 :: 		logBindex=100;
	MOVLW       100
	MOVWF       _logBindex+0 
;setup.c,87 :: 		logC=0;
	CLRF        _logC+0 
;setup.c,88 :: 		pp=0; //variable para presencia
	BCF         _pp+0, BitPos(_pp+0) 
;setup.c,89 :: 		pos=0;
	CLRF        _pos+0 
;setup.c,90 :: 		Apm=-1; Apn=-1; Apx=-1; Apy=-1;
	MOVLW       255
	MOVWF       _Apm+0 
	MOVLW       255
	MOVWF       _Apn+0 
	MOVLW       255
	MOVWF       _Apx+0 
	MOVLW       255
	MOVWF       _Apy+0 
;setup.c,91 :: 		Bpm=-1; Bpn=-1; Bpx=-1; Bpy=-1;
	MOVLW       255
	MOVWF       _Bpm+0 
	MOVLW       255
	MOVWF       _Bpn+0 
	MOVLW       255
	MOVWF       _Bpx+0 
	MOVLW       255
	MOVWF       _Bpy+0 
;setup.c,94 :: 		resultadoA='X';
	MOVLW       88
	MOVWF       _resultadoA+0 
;setup.c,95 :: 		resultadoB='X';
	MOVLW       88
	MOVWF       _resultadoB+0 
;setup.c,96 :: 		resultadoT='X';
	MOVLW       88
	MOVWF       _resultadoT+0 
;setup.c,98 :: 		}
L_end_init_var:
	RETURN      0
; end of _init_var

_init_led:

;setup.c,100 :: 		void init_led(void){
;setup.c,101 :: 		BUZZER = 1; //ADD PC
	BSF         PORTD+0, 5 
;setup.c,102 :: 		LED_V = 1;
	BSF         PORTE+0, 0 
;setup.c,103 :: 		LED_A = 0;
	BCF         PORTC+0, 5 
;setup.c,104 :: 		LED_R = 0;
	BCF         PORTA+0, 5 
;setup.c,106 :: 		Delay_ms(500);
	MOVLW       163
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_init_led4:
	DECFSZ      R13, 1, 1
	BRA         L_init_led4
	DECFSZ      R12, 1, 1
	BRA         L_init_led4
;setup.c,108 :: 		LED_V = 0;
	BCF         PORTE+0, 0 
;setup.c,109 :: 		LED_A = 1;
	BSF         PORTC+0, 5 
;setup.c,110 :: 		LED_R = 0;
	BCF         PORTA+0, 5 
;setup.c,112 :: 		Delay_ms(500);
	MOVLW       163
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_init_led5:
	DECFSZ      R13, 1, 1
	BRA         L_init_led5
	DECFSZ      R12, 1, 1
	BRA         L_init_led5
;setup.c,114 :: 		LED_V = 0;
	BCF         PORTE+0, 0 
;setup.c,115 :: 		LED_A = 0;
	BCF         PORTC+0, 5 
;setup.c,116 :: 		LED_R = 1;
	BSF         PORTA+0, 5 
;setup.c,118 :: 		Delay_ms(500);
	MOVLW       163
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_init_led6:
	DECFSZ      R13, 1, 1
	BRA         L_init_led6
	DECFSZ      R12, 1, 1
	BRA         L_init_led6
;setup.c,120 :: 		LED_V = 1;
	BSF         PORTE+0, 0 
;setup.c,121 :: 		LED_A = 1;
	BSF         PORTC+0, 5 
;setup.c,122 :: 		LED_R = 1;
	BSF         PORTA+0, 5 
;setup.c,124 :: 		}
L_end_init_led:
	RETURN      0
; end of _init_led
