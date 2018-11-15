
_imprimirAlerta:

;CONCENTRADOR.c,44 :: 		void imprimirAlerta(char lugar)
;CONCENTRADOR.c,46 :: 		for(u=0;u<5;u++){Suart2_write(msn[u]);}
	CLRF        _u+0 
L_imprimirAlerta0:
	MOVLW       5
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_imprimirAlerta1
	MOVLW       _msn+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_msn+0)
	MOVWF       FSR0H 
	MOVF        _u+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SUart2_Write_tch+0 
	CALL        _SUart2_Write+0, 0
	INCF        _u+0, 1 
	GOTO        L_imprimirAlerta0
L_imprimirAlerta1:
;CONCENTRADOR.c,47 :: 		SUart0_write(lugar);
	MOVF        FARG_imprimirAlerta_lugar+0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,48 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,50 :: 		}
L_end_imprimirAlerta:
	RETURN      0
; end of _imprimirAlerta

_interrupt:

;CONCENTRADOR.c,54 :: 		void interrupt(){
;CONCENTRADOR.c,55 :: 		RS485Master_Receive(master_rx_dat);
	MOVLW       _master_rx_dat+0
	MOVWF       FARG_RS485Master_Receive_data_buffer+0 
	MOVLW       hi_addr(_master_rx_dat+0)
	MOVWF       FARG_RS485Master_Receive_data_buffer+1 
	CALL        _RS485Master_Receive+0, 0
;CONCENTRADOR.c,56 :: 		}
L_end_interrupt:
L__interrupt54:
	RETFIE      1
; end of _interrupt

_main:

;CONCENTRADOR.c,59 :: 		void main() {
;CONCENTRADOR.c,61 :: 		ADCON1= 0b00001111; // Configure AN pins as digital I/O
	MOVLW       15
	MOVWF       ADCON1+0 
;CONCENTRADOR.c,62 :: 		CMCON = 0b00000111; // Disable comparators
	MOVLW       7
	MOVWF       CMCON+0 
;CONCENTRADOR.c,63 :: 		TRISA.RA3=0; TRISA.RA4=0;
	BCF         TRISA+0, 3 
	BCF         TRISA+0, 4 
;CONCENTRADOR.c,64 :: 		PORTA.RA3=0; PORTA.RA4=0;
	BCF         PORTA+0, 3 
	BCF         PORTA+0, 4 
;CONCENTRADOR.c,65 :: 		SUart0_Init_T();
	CALL        _SUart0_Init_T+0, 0
;CONCENTRADOR.c,66 :: 		SUart2_Init_T();
	CALL        _SUart2_Init_T+0, 0
;CONCENTRADOR.c,69 :: 		UART1_Init(9600); Delay_ms(100);                    // initialize UART1 module
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;CONCENTRADOR.c,70 :: 		RS485Master_Init(); Delay_ms(100);                  // initialize MCU as Master
	CALL        _RS485Master_Init+0, 0
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
	NOP
;CONCENTRADOR.c,71 :: 		RCIE_bit = 1;                        // enable interrupt on UART1 receive
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;CONCENTRADOR.c,72 :: 		TXIE_bit = 0;                        // disable interrupt on UART1 transmit
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;CONCENTRADOR.c,73 :: 		PEIE_bit = 1;                        // enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;CONCENTRADOR.c,74 :: 		GIE_bit = 1;                         // enable all interrupts
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;CONCENTRADOR.c,76 :: 		while(1){
L_main5:
;CONCENTRADOR.c,79 :: 		if (master_rx_dat[5]) {
	MOVF        _master_rx_dat+5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
;CONCENTRADOR.c,81 :: 		LED_TTR=1;
	BSF         PORTA+0, 4 
;CONCENTRADOR.c,82 :: 		Delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	NOP
;CONCENTRADOR.c,83 :: 		LED_TTR=0;
	BCF         PORTA+0, 4 
;CONCENTRADOR.c,84 :: 		master_rx_dat[5]=0;
	CLRF        _master_rx_dat+5 
;CONCENTRADOR.c,85 :: 		master_rx_dat[4]=0;
	CLRF        _master_rx_dat+4 
;CONCENTRADOR.c,87 :: 		imprimirAlerta('E'); //addPC
	MOVLW       69
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,88 :: 		}
L_main7:
;CONCENTRADOR.c,91 :: 		if(fbt>0){
	MOVF        _fbt+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;CONCENTRADOR.c,92 :: 		cnt++;
	MOVLW       1
	ADDWF       _cnt+0, 1 
	MOVLW       0
	ADDWFC      _cnt+1, 1 
	ADDWFC      _cnt+2, 1 
	ADDWFC      _cnt+3, 1 
;CONCENTRADOR.c,93 :: 		}
L_main9:
;CONCENTRADOR.c,95 :: 		if(cnt>14000*1){ //modificado, valor original 14000 * 100
	MOVF        _cnt+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main56
	MOVF        _cnt+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main56
	MOVF        _cnt+1, 0 
	SUBLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L__main56
	MOVF        _cnt+0, 0 
	SUBLW       176
L__main56:
	BTFSC       STATUS+0, 0 
	GOTO        L_main10
;CONCENTRADOR.c,96 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,97 :: 		fbt=0;
	CLRF        _fbt+0 
;CONCENTRADOR.c,98 :: 		LED_485=0;
	BCF         PORTA+0, 3 
;CONCENTRADOR.c,99 :: 		pbuffer=0;
	CLRF        _pbuffer+0 
;CONCENTRADOR.c,100 :: 		entran=0; salen=0; bloqueos=0;
	CLRF        _entran+0 
	CLRF        _entran+1 
	CLRF        _entran+2 
	CLRF        _entran+3 
	CLRF        _salen+0 
	CLRF        _salen+1 
	CLRF        _salen+2 
	CLRF        _salen+3 
	CLRF        _bloqueos+0 
	CLRF        _bloqueos+1 
	CLRF        _bloqueos+2 
	CLRF        _bloqueos+3 
;CONCENTRADOR.c,102 :: 		imprimirAlerta('R'); //addPC
	MOVLW       82
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,103 :: 		}
L_main10:
;CONCENTRADOR.c,106 :: 		if (master_rx_dat[4] && !master_rx_dat[5]){
	MOVF        _master_rx_dat+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVF        _master_rx_dat+5, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
L__main51:
;CONCENTRADOR.c,108 :: 		if(fbt==0){
	MOVF        _fbt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
;CONCENTRADOR.c,109 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,110 :: 		entran=0;
	CLRF        _entran+0 
	CLRF        _entran+1 
	CLRF        _entran+2 
	CLRF        _entran+3 
;CONCENTRADOR.c,111 :: 		LED_485=1;
	BSF         PORTA+0, 3 
;CONCENTRADOR.c,112 :: 		buffer[pbuffer++]='i';
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       105
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
;CONCENTRADOR.c,113 :: 		id_slave=master_rx_dat[6];
	MOVF        _master_rx_dat+6, 0 
	MOVWF       _id_slave+0 
;CONCENTRADOR.c,114 :: 		buffer[pbuffer++]=master_rx_dat[6]+48; //convert unsigned short to ascii char
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       48
	ADDWF       _master_rx_dat+6, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
;CONCENTRADOR.c,115 :: 		entran+=(unsigned long int)master_rx_dat[0];
	MOVF        _master_rx_dat+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        R0, 0 
	ADDWF       _entran+0, 1 
	MOVF        R1, 0 
	ADDWFC      _entran+1, 1 
	MOVF        R2, 0 
	ADDWFC      _entran+2, 1 
	MOVF        R3, 0 
	ADDWFC      _entran+3, 1 
;CONCENTRADOR.c,116 :: 		entran+=(((unsigned long int)master_rx_dat[1])<<8);
	MOVF        _master_rx_dat+1, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R7, 0 
	MOVWF       R3 
	MOVF        R6, 0 
	MOVWF       R2 
	MOVF        R5, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	ADDWF       _entran+0, 1 
	MOVF        R1, 0 
	ADDWFC      _entran+1, 1 
	MOVF        R2, 0 
	ADDWFC      _entran+2, 1 
	MOVF        R3, 0 
	ADDWFC      _entran+3, 1 
;CONCENTRADOR.c,117 :: 		entran+=(((unsigned long int)master_rx_dat[2])<<16);
	MOVF        _master_rx_dat+2, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R6, 0 
	MOVWF       R3 
	MOVF        R5, 0 
	MOVWF       R2 
	CLRF        R0 
	CLRF        R1 
	MOVF        R0, 0 
	ADDWF       _entran+0, 1 
	MOVF        R1, 0 
	ADDWFC      _entran+1, 1 
	MOVF        R2, 0 
	ADDWFC      _entran+2, 1 
	MOVF        R3, 0 
	ADDWFC      _entran+3, 1 
;CONCENTRADOR.c,118 :: 		fbt=1;
	MOVLW       1
	MOVWF       _fbt+0 
;CONCENTRADOR.c,119 :: 		imprimirAlerta('0'); //addPC
	MOVLW       48
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,120 :: 		}
	GOTO        L_main15
L_main14:
;CONCENTRADOR.c,121 :: 		else if(fbt==1){
	MOVF        _fbt+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
;CONCENTRADOR.c,122 :: 		entran+=(((unsigned long int)master_rx_dat[0])<<24);
	MOVF        _master_rx_dat+0, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R3 
	CLRF        R0 
	CLRF        R1 
	CLRF        R2 
	MOVF        R0, 0 
	ADDWF       _entran+0, 1 
	MOVF        R1, 0 
	ADDWFC      _entran+1, 1 
	MOVF        R2, 0 
	ADDWFC      _entran+2, 1 
	MOVF        R3, 0 
	ADDWFC      _entran+3, 1 
;CONCENTRADOR.c,123 :: 		salen+=(unsigned long int)master_rx_dat[1];
	MOVF        _master_rx_dat+1, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        R0, 0 
	ADDWF       _salen+0, 1 
	MOVF        R1, 0 
	ADDWFC      _salen+1, 1 
	MOVF        R2, 0 
	ADDWFC      _salen+2, 1 
	MOVF        R3, 0 
	ADDWFC      _salen+3, 1 
;CONCENTRADOR.c,124 :: 		salen+=(((unsigned long int)master_rx_dat[2])<<8);
	MOVF        _master_rx_dat+2, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R7, 0 
	MOVWF       R3 
	MOVF        R6, 0 
	MOVWF       R2 
	MOVF        R5, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	ADDWF       _salen+0, 1 
	MOVF        R1, 0 
	ADDWFC      _salen+1, 1 
	MOVF        R2, 0 
	ADDWFC      _salen+2, 1 
	MOVF        R3, 0 
	ADDWFC      _salen+3, 1 
;CONCENTRADOR.c,125 :: 		fbt=2;
	MOVLW       2
	MOVWF       _fbt+0 
;CONCENTRADOR.c,126 :: 		imprimirAlerta('1'); //addPC
	MOVLW       49
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,127 :: 		}
	GOTO        L_main17
L_main16:
;CONCENTRADOR.c,128 :: 		else if(fbt==2){
	MOVF        _fbt+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;CONCENTRADOR.c,129 :: 		salen+=(((unsigned long int)master_rx_dat[0])<<16);
	MOVF        _master_rx_dat+0, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R6, 0 
	MOVWF       R3 
	MOVF        R5, 0 
	MOVWF       R2 
	CLRF        R0 
	CLRF        R1 
	MOVF        R0, 0 
	ADDWF       _salen+0, 1 
	MOVF        R1, 0 
	ADDWFC      _salen+1, 1 
	MOVF        R2, 0 
	ADDWFC      _salen+2, 1 
	MOVF        R3, 0 
	ADDWFC      _salen+3, 1 
;CONCENTRADOR.c,130 :: 		salen+=(((unsigned long int)master_rx_dat[1])<<24);
	MOVF        _master_rx_dat+1, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R3 
	CLRF        R0 
	CLRF        R1 
	CLRF        R2 
	MOVF        R0, 0 
	ADDWF       _salen+0, 1 
	MOVF        R1, 0 
	ADDWFC      _salen+1, 1 
	MOVF        R2, 0 
	ADDWFC      _salen+2, 1 
	MOVF        R3, 0 
	ADDWFC      _salen+3, 1 
;CONCENTRADOR.c,131 :: 		bloqueos+=(unsigned long int)master_rx_dat[2];
	MOVF        _master_rx_dat+2, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        R0, 0 
	ADDWF       _bloqueos+0, 1 
	MOVF        R1, 0 
	ADDWFC      _bloqueos+1, 1 
	MOVF        R2, 0 
	ADDWFC      _bloqueos+2, 1 
	MOVF        R3, 0 
	ADDWFC      _bloqueos+3, 1 
;CONCENTRADOR.c,132 :: 		fbt=3;
	MOVLW       3
	MOVWF       _fbt+0 
;CONCENTRADOR.c,133 :: 		imprimirAlerta('2'); //addPC
	MOVLW       50
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,134 :: 		}
	GOTO        L_main19
L_main18:
;CONCENTRADOR.c,135 :: 		else if(fbt==3){
	MOVF        _fbt+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main20
;CONCENTRADOR.c,136 :: 		bloqueos+=(((unsigned long int)master_rx_dat[1])<<8);
	MOVF        _master_rx_dat+1, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R7, 0 
	MOVWF       R3 
	MOVF        R6, 0 
	MOVWF       R2 
	MOVF        R5, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        R0, 0 
	ADDWF       _bloqueos+0, 1 
	MOVF        R1, 0 
	ADDWFC      _bloqueos+1, 1 
	MOVF        R2, 0 
	ADDWFC      _bloqueos+2, 1 
	MOVF        R3, 0 
	ADDWFC      _bloqueos+3, 1 
;CONCENTRADOR.c,137 :: 		bloqueos+=(((unsigned long int)master_rx_dat[2])<<16);
	MOVF        _master_rx_dat+2, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R6, 0 
	MOVWF       R3 
	MOVF        R5, 0 
	MOVWF       R2 
	CLRF        R0 
	CLRF        R1 
	MOVF        R0, 0 
	ADDWF       _bloqueos+0, 1 
	MOVF        R1, 0 
	ADDWFC      _bloqueos+1, 1 
	MOVF        R2, 0 
	ADDWFC      _bloqueos+2, 1 
	MOVF        R3, 0 
	ADDWFC      _bloqueos+3, 1 
;CONCENTRADOR.c,138 :: 		bloqueos+=(((unsigned long int)master_rx_dat[1])<<24);
	MOVF        _master_rx_dat+1, 0 
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVWF       R7 
	MOVWF       R8 
	MOVF        R5, 0 
	MOVWF       R3 
	CLRF        R0 
	CLRF        R1 
	CLRF        R2 
	MOVF        R0, 0 
	ADDWF       _bloqueos+0, 1 
	MOVF        R1, 0 
	ADDWFC      _bloqueos+1, 1 
	MOVF        R2, 0 
	ADDWFC      _bloqueos+2, 1 
	MOVF        R3, 0 
	ADDWFC      _bloqueos+3, 1 
;CONCENTRADOR.c,139 :: 		fbt=4;
	MOVLW       4
	MOVWF       _fbt+0 
;CONCENTRADOR.c,140 :: 		imprimirAlerta('3'); //addPC
	MOVLW       51
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,141 :: 		}
L_main20:
L_main19:
L_main17:
L_main15:
;CONCENTRADOR.c,142 :: 		master_rx_dat[4] = 0; master_rx_dat[6]=0;
	CLRF        _master_rx_dat+4 
	CLRF        _master_rx_dat+6 
;CONCENTRADOR.c,144 :: 		}
L_main13:
;CONCENTRADOR.c,146 :: 		if(fbt==4){
	MOVF        _fbt+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
;CONCENTRADOR.c,147 :: 		LED_485=0;
	BCF         PORTA+0, 3 
;CONCENTRADOR.c,148 :: 		LongWordToStrWithZeros(entran,s_entran);
	MOVF        _entran+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _entran+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _entran+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _entran+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _s_entran+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_s_entran+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
;CONCENTRADOR.c,149 :: 		LongWordToStrWithZeros(salen,s_salen);
	MOVF        _salen+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _salen+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _salen+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _salen+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _s_salen+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_s_salen+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
;CONCENTRADOR.c,150 :: 		LongWordToStrWithZeros(bloqueos,s_bloqueos);
	MOVF        _bloqueos+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _bloqueos+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _bloqueos+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _bloqueos+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _s_bloqueos+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_s_bloqueos+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
;CONCENTRADOR.c,151 :: 		buffer[pbuffer++]='E';
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       69
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
;CONCENTRADOR.c,152 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_entran[u]; }
	CLRF        _u+0 
L_main22:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main23
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _s_entran+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_s_entran+0)
	MOVWF       FSR0H 
	MOVF        _u+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
	INCF        _u+0, 1 
	GOTO        L_main22
L_main23:
;CONCENTRADOR.c,153 :: 		buffer[pbuffer++]='S';
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       83
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
;CONCENTRADOR.c,154 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_salen[u]; }
	CLRF        _u+0 
L_main25:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main26
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _s_salen+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_s_salen+0)
	MOVWF       FSR0H 
	MOVF        _u+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
	INCF        _u+0, 1 
	GOTO        L_main25
L_main26:
;CONCENTRADOR.c,155 :: 		buffer[pbuffer++]='B';
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       66
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
;CONCENTRADOR.c,156 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_bloqueos[u]; }
	CLRF        _u+0 
L_main28:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main29
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       _s_bloqueos+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_s_bloqueos+0)
	MOVWF       FSR0H 
	MOVF        _u+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
	INCF        _u+0, 1 
	GOTO        L_main28
L_main29:
;CONCENTRADOR.c,157 :: 		buffer[pbuffer++]='#';
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       35
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
;CONCENTRADOR.c,158 :: 		SUart0_RstrNout(buffer,36);       //------------envio por bluetooth
	MOVLW       _buffer+0
	MOVWF       FARG_SUart0_RstrNout_ptr+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_SUart0_RstrNout_ptr+1 
	MOVLW       36
	MOVWF       FARG_SUart0_RstrNout_n+0 
	CALL        _SUart0_RstrNout+0, 0
;CONCENTRADOR.c,161 :: 		if(id_slave == 10){
	MOVF        _id_slave+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main31
;CONCENTRADOR.c,162 :: 		for(u=3;u<10;u++){ ee1[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_main32:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main33
	MOVF        _u+0, 0 
	ADDLW       11
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _ee1+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_ee1+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _s_entran+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_s_entran+0)
	MOVWF       FSR0H 
	MOVF        _u+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INCF        _u+0, 1 
	GOTO        L_main32
L_main33:
;CONCENTRADOR.c,163 :: 		}
L_main31:
;CONCENTRADOR.c,164 :: 		if(id_slave == 20){
	MOVF        _id_slave+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_main35
;CONCENTRADOR.c,165 :: 		for(u=3;u<10;u++){ ee2[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_main36:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main37
	MOVF        _u+0, 0 
	ADDLW       11
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _ee2+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_ee2+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _s_entran+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_s_entran+0)
	MOVWF       FSR0H 
	MOVF        _u+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	INCF        _u+0, 1 
	GOTO        L_main36
L_main37:
;CONCENTRADOR.c,166 :: 		}
L_main35:
;CONCENTRADOR.c,168 :: 		fbt=0; pbuffer=0;
	CLRF        _fbt+0 
	CLRF        _pbuffer+0 
;CONCENTRADOR.c,170 :: 		entran=0; salen=0; bloqueos=0;
	CLRF        _entran+0 
	CLRF        _entran+1 
	CLRF        _entran+2 
	CLRF        _entran+3 
	CLRF        _salen+0 
	CLRF        _salen+1 
	CLRF        _salen+2 
	CLRF        _salen+3 
	CLRF        _bloqueos+0 
	CLRF        _bloqueos+1 
	CLRF        _bloqueos+2 
	CLRF        _bloqueos+3 
;CONCENTRADOR.c,171 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,172 :: 		imprimirAlerta('4'); //addPC
	MOVLW       52
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,173 :: 		}
L_main21:
;CONCENTRADOR.c,176 :: 		counter2++;
	MOVLW       1
	ADDWF       _counter2+0, 1 
	MOVLW       0
	ADDWFC      _counter2+1, 1 
	ADDWFC      _counter2+2, 1 
	ADDWFC      _counter2+3, 1 
;CONCENTRADOR.c,177 :: 		if(counter2>(14000*20)){
	MOVF        _counter2+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVF        _counter2+2, 0 
	SUBLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVF        _counter2+1, 0 
	SUBLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVF        _counter2+0, 0 
	SUBLW       192
L__main57:
	BTFSC       STATUS+0, 0 
	GOTO        L_main39
;CONCENTRADOR.c,178 :: 		counter2=0;
	CLRF        _counter2+0 
	CLRF        _counter2+1 
	CLRF        _counter2+2 
	CLRF        _counter2+3 
;CONCENTRADOR.c,179 :: 		if(ax==0){
	MOVF        _ax+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main40
;CONCENTRADOR.c,180 :: 		ax=1;
	MOVLW       1
	MOVWF       _ax+0 
;CONCENTRADOR.c,181 :: 		}
	GOTO        L_main41
L_main40:
;CONCENTRADOR.c,183 :: 		ax=0;
	CLRF        _ax+0 
;CONCENTRADOR.c,184 :: 		}
L_main41:
;CONCENTRADOR.c,185 :: 		}
L_main39:
;CONCENTRADOR.c,187 :: 		counter1++;
	MOVLW       1
	ADDWF       _counter1+0, 1 
	MOVLW       0
	ADDWFC      _counter1+1, 1 
	ADDWFC      _counter1+2, 1 
	ADDWFC      _counter1+3, 1 
;CONCENTRADOR.c,188 :: 		if(counter1>(14000*1)){
	MOVF        _counter1+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main58
	MOVF        _counter1+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main58
	MOVF        _counter1+1, 0 
	SUBLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L__main58
	MOVF        _counter1+0, 0 
	SUBLW       176
L__main58:
	BTFSC       STATUS+0, 0 
	GOTO        L_main42
;CONCENTRADOR.c,189 :: 		counter1=0;
	CLRF        _counter1+0 
	CLRF        _counter1+1 
	CLRF        _counter1+2 
	CLRF        _counter1+3 
;CONCENTRADOR.c,190 :: 		if(ax==0){
	MOVF        _ax+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main43
;CONCENTRADOR.c,191 :: 		for(u=0;u<24;u++){
	CLRF        _u+0 
L_main44:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main45
;CONCENTRADOR.c,192 :: 		Suart2_write((char)ee1[u]); //transmitir por RS232 puerto J2(RJ45) pc
	MOVLW       _ee1+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ee1+0)
	MOVWF       FSR0H 
	MOVF        _u+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SUart2_Write_tch+0 
	CALL        _SUart2_Write+0, 0
;CONCENTRADOR.c,191 :: 		for(u=0;u<24;u++){
	INCF        _u+0, 1 
;CONCENTRADOR.c,193 :: 		}
	GOTO        L_main44
L_main45:
;CONCENTRADOR.c,194 :: 		}
	GOTO        L_main47
L_main43:
;CONCENTRADOR.c,196 :: 		for(u=0;u<24;u++){
	CLRF        _u+0 
L_main48:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main49
;CONCENTRADOR.c,197 :: 		Suart2_write((char)ee2[u]); //transmitir por RS232 puerto J2(RJ45) pc
	MOVLW       _ee2+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ee2+0)
	MOVWF       FSR0H 
	MOVF        _u+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SUart2_Write_tch+0 
	CALL        _SUart2_Write+0, 0
;CONCENTRADOR.c,196 :: 		for(u=0;u<24;u++){
	INCF        _u+0, 1 
;CONCENTRADOR.c,198 :: 		}
	GOTO        L_main48
L_main49:
;CONCENTRADOR.c,199 :: 		}
L_main47:
;CONCENTRADOR.c,200 :: 		}
L_main42:
;CONCENTRADOR.c,202 :: 		}
	GOTO        L_main5
;CONCENTRADOR.c,203 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
