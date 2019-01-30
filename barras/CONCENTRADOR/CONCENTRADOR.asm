
_interrupt:

;CONCENTRADOR.c,54 :: 		void interrupt()
;CONCENTRADOR.c,56 :: 		RS485Master_Receive(master_rx_dat);
	MOVLW       _master_rx_dat+0
	MOVWF       FARG_RS485Master_Receive_data_buffer+0 
	MOVLW       hi_addr(_master_rx_dat+0)
	MOVWF       FARG_RS485Master_Receive_data_buffer+1 
	CALL        _RS485Master_Receive+0, 0
;CONCENTRADOR.c,57 :: 		}
L_end_interrupt:
L__interrupt75:
	RETFIE      1
; end of _interrupt

_main:

;CONCENTRADOR.c,59 :: 		void main()
;CONCENTRADOR.c,61 :: 		ADCON1= 0b00001111;                     // Configure AN pins as digital I/O
	MOVLW       15
	MOVWF       ADCON1+0 
;CONCENTRADOR.c,62 :: 		CMCON = 0b00000111;                     // Disable comparators
	MOVLW       7
	MOVWF       CMCON+0 
;CONCENTRADOR.c,63 :: 		TRISA.RA3=0; TRISA.RA4=0;
	BCF         TRISA+0, 3 
	BCF         TRISA+0, 4 
;CONCENTRADOR.c,64 :: 		PORTA.RA3=0; PORTA.RA4=0;
	BCF         PORTA+0, 3 
	BCF         PORTA+0, 4 
;CONCENTRADOR.c,67 :: 		SUart0_Init_T();
	CALL        _SUart0_Init_T+0, 0
;CONCENTRADOR.c,68 :: 		SUart2_Init_T();
	CALL        _SUart2_Init_T+0, 0
;CONCENTRADOR.c,70 :: 		TRISC.RC0 = 1;                          //add PC para lectura del SW_ON
	BSF         TRISC+0, 0 
;CONCENTRADOR.c,71 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;CONCENTRADOR.c,72 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;CONCENTRADOR.c,73 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;CONCENTRADOR.c,76 :: 		UART1_Init(9600); Delay_ms(100);      // initialize UART1 module
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
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
	NOP
;CONCENTRADOR.c,77 :: 		RS485Master_Init(); Delay_ms(100);    // initialize MCU as Master
	CALL        _RS485Master_Init+0, 0
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
	NOP
;CONCENTRADOR.c,78 :: 		RCIE_bit = 1;                         // enable interrupt on UART1 receive
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;CONCENTRADOR.c,79 :: 		TXIE_bit = 0;                         // disable interrupt on UART1 transmit
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;CONCENTRADOR.c,80 :: 		PEIE_bit = 1;                         // enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;CONCENTRADOR.c,81 :: 		GIE_bit = 1;                          // enable all interrupts
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;CONCENTRADOR.c,84 :: 		peticion(esclavo);
	MOVF        _esclavo+0, 0 
	MOVWF       FARG_peticion_dirEsclavo+0 
	CALL        _peticion+0, 0
;CONCENTRADOR.c,86 :: 		while(1)
L_main2:
;CONCENTRADOR.c,89 :: 		if (master_rx_dat[5])
	MOVF        _master_rx_dat+5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
;CONCENTRADOR.c,91 :: 		LED_TTR=1;
	BSF         PORTA+0, 4 
;CONCENTRADOR.c,92 :: 		Delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main5:
	DECFSZ      R13, 1, 1
	BRA         L_main5
	DECFSZ      R12, 1, 1
	BRA         L_main5
	NOP
;CONCENTRADOR.c,93 :: 		LED_TTR=0;
	BCF         PORTA+0, 4 
;CONCENTRADOR.c,94 :: 		master_rx_dat[5]=0;
	CLRF        _master_rx_dat+5 
;CONCENTRADOR.c,95 :: 		master_rx_dat[4]=0;
	CLRF        _master_rx_dat+4 
;CONCENTRADOR.c,96 :: 		}
L_main4:
;CONCENTRADOR.c,99 :: 		if(fbt>0)
	MOVF        _fbt+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;CONCENTRADOR.c,101 :: 		cnt++;
	MOVLW       1
	ADDWF       _cnt+0, 1 
	MOVLW       0
	ADDWFC      _cnt+1, 1 
	ADDWFC      _cnt+2, 1 
	ADDWFC      _cnt+3, 1 
;CONCENTRADOR.c,102 :: 		}
L_main6:
;CONCENTRADOR.c,103 :: 		if(cnt>14000*1) //modificado, valor original 14000 * 100
	MOVF        _cnt+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main77
	MOVF        _cnt+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main77
	MOVF        _cnt+1, 0 
	SUBLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L__main77
	MOVF        _cnt+0, 0 
	SUBLW       176
L__main77:
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;CONCENTRADOR.c,105 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,106 :: 		fbt=0;
	CLRF        _fbt+0 
;CONCENTRADOR.c,107 :: 		LED_485=0;
	BCF         PORTA+0, 3 
;CONCENTRADOR.c,108 :: 		pbuffer=0;
	CLRF        _pbuffer+0 
;CONCENTRADOR.c,109 :: 		entran=0; salen=0; bloqueos=0;
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
;CONCENTRADOR.c,111 :: 		imprimirAlerta('R'); //addPC
	MOVLW       82
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,112 :: 		}
L_main7:
;CONCENTRADOR.c,115 :: 		if (master_rx_dat[4] && !master_rx_dat[5])
	MOVF        _master_rx_dat+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVF        _master_rx_dat+5, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
L__main73:
;CONCENTRADOR.c,117 :: 		if(fbt==0)
	MOVF        _fbt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;CONCENTRADOR.c,119 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,120 :: 		entran=0;
	CLRF        _entran+0 
	CLRF        _entran+1 
	CLRF        _entran+2 
	CLRF        _entran+3 
;CONCENTRADOR.c,121 :: 		LED_485=1;
	BSF         PORTA+0, 3 
;CONCENTRADOR.c,122 :: 		buffer[pbuffer++]='i';
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
;CONCENTRADOR.c,123 :: 		id_slave=master_rx_dat[6];
	MOVF        _master_rx_dat+6, 0 
	MOVWF       _id_slave+0 
;CONCENTRADOR.c,124 :: 		buffer[pbuffer++]=master_rx_dat[6]+48; //unsigned short a caracter ascii
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
;CONCENTRADOR.c,125 :: 		entran+=(unsigned long int)master_rx_dat[0];
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
;CONCENTRADOR.c,126 :: 		entran+=(((unsigned long int)master_rx_dat[1])<<8);
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
;CONCENTRADOR.c,127 :: 		entran+=(((unsigned long int)master_rx_dat[2])<<16);
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
;CONCENTRADOR.c,128 :: 		fbt=1;
	MOVLW       1
	MOVWF       _fbt+0 
;CONCENTRADOR.c,129 :: 		}
	GOTO        L_main12
L_main11:
;CONCENTRADOR.c,130 :: 		else if(fbt==1)
	MOVF        _fbt+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
;CONCENTRADOR.c,132 :: 		entran+=(((unsigned long int)master_rx_dat[0])<<24);
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
;CONCENTRADOR.c,133 :: 		salen+=(unsigned long int)master_rx_dat[1];
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
;CONCENTRADOR.c,134 :: 		salen+=(((unsigned long int)master_rx_dat[2])<<8);
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
;CONCENTRADOR.c,135 :: 		fbt=2;
	MOVLW       2
	MOVWF       _fbt+0 
;CONCENTRADOR.c,136 :: 		}
	GOTO        L_main14
L_main13:
;CONCENTRADOR.c,137 :: 		else if(fbt==2)
	MOVF        _fbt+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
;CONCENTRADOR.c,139 :: 		salen+=(((unsigned long int)master_rx_dat[0])<<16);
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
;CONCENTRADOR.c,140 :: 		salen+=(((unsigned long int)master_rx_dat[1])<<24);
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
;CONCENTRADOR.c,141 :: 		bloqueos+=(unsigned long int)master_rx_dat[2];
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
;CONCENTRADOR.c,142 :: 		fbt=3;
	MOVLW       3
	MOVWF       _fbt+0 
;CONCENTRADOR.c,143 :: 		}
	GOTO        L_main16
L_main15:
;CONCENTRADOR.c,144 :: 		else if(fbt==3)
	MOVF        _fbt+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
;CONCENTRADOR.c,146 :: 		bloqueos+=(((unsigned long int)master_rx_dat[1])<<8);
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
;CONCENTRADOR.c,147 :: 		bloqueos+=(((unsigned long int)master_rx_dat[2])<<16);
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
;CONCENTRADOR.c,148 :: 		bloqueos+=(((unsigned long int)master_rx_dat[1])<<24);
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
;CONCENTRADOR.c,149 :: 		fbt=4;
	MOVLW       4
	MOVWF       _fbt+0 
;CONCENTRADOR.c,150 :: 		}
L_main17:
L_main16:
L_main14:
L_main12:
;CONCENTRADOR.c,151 :: 		master_rx_dat[4] = 0; master_rx_dat[6]=0;
	CLRF        _master_rx_dat+4 
	CLRF        _master_rx_dat+6 
;CONCENTRADOR.c,152 :: 		}
L_main10:
;CONCENTRADOR.c,154 :: 		if(fbt==4)
	MOVF        _fbt+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;CONCENTRADOR.c,156 :: 		LED_485=0;
	BCF         PORTA+0, 3 
;CONCENTRADOR.c,157 :: 		LongWordToStrWithZeros(entran,s_entran);
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
;CONCENTRADOR.c,158 :: 		LongWordToStrWithZeros(salen,s_salen);
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
;CONCENTRADOR.c,159 :: 		LongWordToStrWithZeros(bloqueos,s_bloqueos);
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
;CONCENTRADOR.c,160 :: 		buffer[pbuffer++]='E';
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
;CONCENTRADOR.c,161 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_entran[u]; }
	CLRF        _u+0 
L_main19:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main20
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
	GOTO        L_main19
L_main20:
;CONCENTRADOR.c,162 :: 		buffer[pbuffer++]='S';
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
;CONCENTRADOR.c,163 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_salen[u]; }
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
	GOTO        L_main22
L_main23:
;CONCENTRADOR.c,164 :: 		buffer[pbuffer++]='B';
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
;CONCENTRADOR.c,165 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_bloqueos[u]; }
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
	GOTO        L_main25
L_main26:
;CONCENTRADOR.c,166 :: 		buffer[pbuffer++]='#';
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
;CONCENTRADOR.c,168 :: 		SUart0_RstrNout(buffer,36);             //Transmitir por bluetooth
	MOVLW       _buffer+0
	MOVWF       FARG_SUart0_RstrNout_ptr+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_SUart0_RstrNout_ptr+1 
	MOVLW       36
	MOVWF       FARG_SUart0_RstrNout_n+0 
	CALL        _SUart0_RstrNout+0, 0
;CONCENTRADOR.c,169 :: 		SUart0_write('\r'); SUart0_write('\n'); //add PC salto de linea
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,172 :: 		buildBuf600();                      //Construir BUffer para MVT600
	CALL        _buildBuf600+0, 0
;CONCENTRADOR.c,173 :: 		transmitirGPS(600);                 //ENVIAR POR MVT600
	MOVLW       88
	MOVWF       FARG_transmitirGPS_GPS+0 
	MOVLW       2
	MOVWF       FARG_transmitirGPS_GPS+1 
	CALL        _transmitirGPS+0, 0
;CONCENTRADOR.c,176 :: 		fbt=0; pbuffer=0;
	CLRF        _fbt+0 
	CLRF        _pbuffer+0 
;CONCENTRADOR.c,178 :: 		entran=0; salen=0; bloqueos=0;
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
;CONCENTRADOR.c,179 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,180 :: 		}
L_main18:
;CONCENTRADOR.c,189 :: 		counter2++;
	MOVLW       1
	ADDWF       _counter2+0, 1 
	MOVLW       0
	ADDWFC      _counter2+1, 1 
	ADDWFC      _counter2+2, 1 
	ADDWFC      _counter2+3, 1 
;CONCENTRADOR.c,190 :: 		if(counter2>(140000*3))
	MOVF        _counter2+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main78
	MOVF        _counter2+2, 0 
	SUBLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L__main78
	MOVF        _counter2+1, 0 
	SUBLW       104
	BTFSS       STATUS+0, 2 
	GOTO        L__main78
	MOVF        _counter2+0, 0 
	SUBLW       160
L__main78:
	BTFSC       STATUS+0, 0 
	GOTO        L_main28
;CONCENTRADOR.c,192 :: 		counter2=0;
	CLRF        _counter2+0 
	CLRF        _counter2+1 
	CLRF        _counter2+2 
	CLRF        _counter2+3 
;CONCENTRADOR.c,195 :: 		imprimirAlerta((esclavo/10)+48);
	MOVLW       10
	MOVWF       R4 
	MOVF        _esclavo+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,196 :: 		peticion(esclavo);              //pedido de información al esclavo
	MOVF        _esclavo+0, 0 
	MOVWF       FARG_peticion_dirEsclavo+0 
	CALL        _peticion+0, 0
;CONCENTRADOR.c,197 :: 		esclavo += 10;                  //incrementar direccion de esclavo
	MOVLW       10
	ADDWF       _esclavo+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _esclavo+0 
;CONCENTRADOR.c,198 :: 		if(esclavo > 30){esclavo = 10;} //control desborde de esclavos
	MOVF        R1, 0 
	SUBLW       30
	BTFSC       STATUS+0, 0 
	GOTO        L_main29
	MOVLW       10
	MOVWF       _esclavo+0 
L_main29:
;CONCENTRADOR.c,199 :: 		}
L_main28:
;CONCENTRADOR.c,207 :: 		counter1++;
	MOVLW       1
	ADDWF       _counter1+0, 1 
	MOVLW       0
	ADDWFC      _counter1+1, 1 
	ADDWFC      _counter1+2, 1 
	ADDWFC      _counter1+3, 1 
;CONCENTRADOR.c,208 :: 		if(counter1>(140000*20))
	MOVF        _counter1+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main79
	MOVF        _counter1+2, 0 
	SUBLW       42
	BTFSS       STATUS+0, 2 
	GOTO        L__main79
	MOVF        _counter1+1, 0 
	SUBLW       185
	BTFSS       STATUS+0, 2 
	GOTO        L__main79
	MOVF        _counter1+0, 0 
	SUBLW       128
L__main79:
	BTFSC       STATUS+0, 0 
	GOTO        L_main30
;CONCENTRADOR.c,210 :: 		counter1=0;
	CLRF        _counter1+0 
	CLRF        _counter1+1 
	CLRF        _counter1+2 
	CLRF        _counter1+3 
;CONCENTRADOR.c,212 :: 		}
L_main30:
;CONCENTRADOR.c,219 :: 		if(SWITCH_ON)
	BTFSS       PORTC+0, 0 
	GOTO        L_main31
;CONCENTRADOR.c,221 :: 		seg_off++;
	MOVLW       1
	ADDWF       _seg_off+0, 1 
	MOVLW       0
	ADDWFC      _seg_off+1, 1 
	ADDWFC      _seg_off+2, 1 
	ADDWFC      _seg_off+3, 1 
;CONCENTRADOR.c,226 :: 		if((seg_off > (54026 * 10)) && DS_FUENTE == 0)
	MOVF        _seg_off+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main80
	MOVF        _seg_off+2, 0 
	SUBLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L__main80
	MOVF        _seg_off+1, 0 
	SUBLW       62
	BTFSS       STATUS+0, 2 
	GOTO        L__main80
	MOVF        _seg_off+0, 0 
	SUBLW       100
L__main80:
	BTFSC       STATUS+0, 0 
	GOTO        L_main34
	BTFSC       PORTB+0, 5 
	GOTO        L_main34
L__main72:
;CONCENTRADOR.c,228 :: 		seg_off = 0;
	CLRF        _seg_off+0 
	CLRF        _seg_off+1 
	CLRF        _seg_off+2 
	CLRF        _seg_off+3 
;CONCENTRADOR.c,229 :: 		DS_FUENTE = 1;
	BSF         PORTB+0, 5 
;CONCENTRADOR.c,230 :: 		SUart0_write('O');  SUart0_write('F'); SUart0_write('F'); //off
	MOVLW       79
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       70
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       70
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,231 :: 		SUart0_write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,232 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,233 :: 		}
L_main34:
;CONCENTRADOR.c,235 :: 		}
	GOTO        L_main35
L_main31:
;CONCENTRADOR.c,238 :: 		seg_off = 0;
	CLRF        _seg_off+0 
	CLRF        _seg_off+1 
	CLRF        _seg_off+2 
	CLRF        _seg_off+3 
;CONCENTRADOR.c,239 :: 		DS_FUENTE = 0;
	BCF         PORTB+0, 5 
;CONCENTRADOR.c,240 :: 		}
L_main35:
;CONCENTRADOR.c,241 :: 		}
	GOTO        L_main2
;CONCENTRADOR.c,242 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_imprimirAlerta:

;CONCENTRADOR.c,250 :: 		void imprimirAlerta(char lugar)
;CONCENTRADOR.c,252 :: 		SUart0_write(lugar);
	MOVF        FARG_imprimirAlerta_lugar+0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,253 :: 		SUart0_write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,254 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,255 :: 		}
L_end_imprimirAlerta:
	RETURN      0
; end of _imprimirAlerta

_imprimirMensaje:

;CONCENTRADOR.c,256 :: 		void imprimirMensaje(char mensaje[10])
;CONCENTRADOR.c,258 :: 		int u = 0;
	CLRF        imprimirMensaje_u_L0+0 
	CLRF        imprimirMensaje_u_L0+1 
;CONCENTRADOR.c,259 :: 		for(u = 0; u < 10; u++)
	CLRF        imprimirMensaje_u_L0+0 
	CLRF        imprimirMensaje_u_L0+1 
L_imprimirMensaje36:
	MOVLW       128
	XORWF       imprimirMensaje_u_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__imprimirMensaje83
	MOVLW       10
	SUBWF       imprimirMensaje_u_L0+0, 0 
L__imprimirMensaje83:
	BTFSC       STATUS+0, 0 
	GOTO        L_imprimirMensaje37
;CONCENTRADOR.c,261 :: 		SUart0_write(mensaje[u]);
	MOVF        imprimirMensaje_u_L0+0, 0 
	ADDWF       FARG_imprimirMensaje_mensaje+0, 0 
	MOVWF       FSR0 
	MOVF        imprimirMensaje_u_L0+1, 0 
	ADDWFC      FARG_imprimirMensaje_mensaje+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,259 :: 		for(u = 0; u < 10; u++)
	INFSNZ      imprimirMensaje_u_L0+0, 1 
	INCF        imprimirMensaje_u_L0+1, 1 
;CONCENTRADOR.c,262 :: 		}
	GOTO        L_imprimirMensaje36
L_imprimirMensaje37:
;CONCENTRADOR.c,263 :: 		SUart0_write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,264 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,265 :: 		}
L_end_imprimirMensaje:
	RETURN      0
; end of _imprimirMensaje

_peticion:

;CONCENTRADOR.c,277 :: 		void peticion(char dirEsclavo)
;CONCENTRADOR.c,279 :: 		dat[0] = 0xFF;
	MOVLW       255
	MOVWF       _dat+0 
;CONCENTRADOR.c,280 :: 		dat[1] = 0xFF;
	MOVLW       255
	MOVWF       _dat+1 
;CONCENTRADOR.c,281 :: 		dat[2] = 0xFF;
	MOVLW       255
	MOVWF       _dat+2 
;CONCENTRADOR.c,282 :: 		dat[4] = 0;
	CLRF        _dat+4 
;CONCENTRADOR.c,283 :: 		dat[5] = 0;
	CLRF        _dat+5 
;CONCENTRADOR.c,284 :: 		dat[6] = 0;
	CLRF        _dat+6 
;CONCENTRADOR.c,285 :: 		RS485Master_Send(dat,1,dirEsclavo);
	MOVLW       _dat+0
	MOVWF       FARG_RS485Master_Send_data_buffer+0 
	MOVLW       hi_addr(_dat+0)
	MOVWF       FARG_RS485Master_Send_data_buffer+1 
	MOVLW       1
	MOVWF       FARG_RS485Master_Send_datalen+0 
	MOVF        FARG_peticion_dirEsclavo+0, 0 
	MOVWF       FARG_RS485Master_Send_slave_address+0 
	CALL        _RS485Master_Send+0, 0
;CONCENTRADOR.c,286 :: 		delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_peticion39:
	DECFSZ      R13, 1, 1
	BRA         L_peticion39
	DECFSZ      R12, 1, 1
	BRA         L_peticion39
;CONCENTRADOR.c,287 :: 		}
L_end_peticion:
	RETURN      0
; end of _peticion

_buildBuf600:

;CONCENTRADOR.c,297 :: 		void buildBuf600()
;CONCENTRADOR.c,299 :: 		if(id_slave == 10)
	MOVF        _id_slave+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_buildBuf60040
;CONCENTRADOR.c,301 :: 		for(u=3;u<10;u++){ ee1[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_buildBuf60041:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_buildBuf60042
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
	GOTO        L_buildBuf60041
L_buildBuf60042:
;CONCENTRADOR.c,302 :: 		}
L_buildBuf60040:
;CONCENTRADOR.c,303 :: 		if(id_slave == 20)
	MOVF        _id_slave+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_buildBuf60044
;CONCENTRADOR.c,305 :: 		for(u=3;u<10;u++){ ee2[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_buildBuf60045:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_buildBuf60046
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
	GOTO        L_buildBuf60045
L_buildBuf60046:
;CONCENTRADOR.c,306 :: 		}
L_buildBuf60044:
;CONCENTRADOR.c,307 :: 		if(id_slave == 30)
	MOVF        _id_slave+0, 0 
	XORLW       30
	BTFSS       STATUS+0, 2 
	GOTO        L_buildBuf60048
;CONCENTRADOR.c,309 :: 		for(u=3;u<10;u++){ ee3[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_buildBuf60049:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_buildBuf60050
	MOVF        _u+0, 0 
	ADDLW       11
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _ee3+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_ee3+0)
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
	GOTO        L_buildBuf60049
L_buildBuf60050:
;CONCENTRADOR.c,310 :: 		}
L_buildBuf60048:
;CONCENTRADOR.c,311 :: 		}
L_end_buildBuf600:
	RETURN      0
; end of _buildBuf600

_transmitirGPS:

;CONCENTRADOR.c,324 :: 		void transmitirGPS(int GPS)
;CONCENTRADOR.c,326 :: 		if(GPS == 300)      // PARA GV300
	MOVF        FARG_transmitirGPS_GPS+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__transmitirGPS87
	MOVLW       44
	XORWF       FARG_transmitirGPS_GPS+0, 0 
L__transmitirGPS87:
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS52
;CONCENTRADOR.c,328 :: 		for(u=0;u<36;u++)
	CLRF        _u+0 
L_transmitirGPS53:
	MOVLW       36
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS54
;CONCENTRADOR.c,330 :: 		Suart2_write((char)buffer[u]); //TX por RS232 puerto J2(RJ45) pc
	MOVLW       _buffer+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR0H 
	MOVF        _u+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SUart2_Write_tch+0 
	CALL        _SUart2_Write+0, 0
;CONCENTRADOR.c,328 :: 		for(u=0;u<36;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,331 :: 		}
	GOTO        L_transmitirGPS53
L_transmitirGPS54:
;CONCENTRADOR.c,332 :: 		}
	GOTO        L_transmitirGPS56
L_transmitirGPS52:
;CONCENTRADOR.c,334 :: 		else if(GPS == 600) // PARA MVT600
	MOVF        FARG_transmitirGPS_GPS+1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__transmitirGPS88
	MOVLW       88
	XORWF       FARG_transmitirGPS_GPS+0, 0 
L__transmitirGPS88:
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS57
;CONCENTRADOR.c,336 :: 		if(ax==0)
	MOVF        _ax+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS58
;CONCENTRADOR.c,338 :: 		ax = 1;
	MOVLW       1
	MOVWF       _ax+0 
;CONCENTRADOR.c,339 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_transmitirGPS59:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS60
;CONCENTRADOR.c,341 :: 		Suart2_write((char)ee1[u]); //TX por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,339 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,342 :: 		}
	GOTO        L_transmitirGPS59
L_transmitirGPS60:
;CONCENTRADOR.c,343 :: 		}
	GOTO        L_transmitirGPS62
L_transmitirGPS58:
;CONCENTRADOR.c,344 :: 		else if (ax == 1)
	MOVF        _ax+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS63
;CONCENTRADOR.c,346 :: 		ax = 2;
	MOVLW       2
	MOVWF       _ax+0 
;CONCENTRADOR.c,347 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_transmitirGPS64:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS65
;CONCENTRADOR.c,349 :: 		Suart2_write((char)ee2[u]); //TX por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,347 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,350 :: 		}
	GOTO        L_transmitirGPS64
L_transmitirGPS65:
;CONCENTRADOR.c,351 :: 		}
	GOTO        L_transmitirGPS67
L_transmitirGPS63:
;CONCENTRADOR.c,352 :: 		else if (ax == 2)
	MOVF        _ax+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS68
;CONCENTRADOR.c,354 :: 		ax = 0;
	CLRF        _ax+0 
;CONCENTRADOR.c,355 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_transmitirGPS69:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS70
;CONCENTRADOR.c,357 :: 		Suart2_write((char)ee3[u]); //TX por RS232 puerto J2(RJ45) pc
	MOVLW       _ee3+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_ee3+0)
	MOVWF       FSR0H 
	MOVF        _u+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SUart2_Write_tch+0 
	CALL        _SUart2_Write+0, 0
;CONCENTRADOR.c,355 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,358 :: 		}
	GOTO        L_transmitirGPS69
L_transmitirGPS70:
;CONCENTRADOR.c,359 :: 		}
L_transmitirGPS68:
L_transmitirGPS67:
L_transmitirGPS62:
;CONCENTRADOR.c,360 :: 		}
L_transmitirGPS57:
L_transmitirGPS56:
;CONCENTRADOR.c,361 :: 		}
L_end_transmitirGPS:
	RETURN      0
; end of _transmitirGPS
