
_interrupt:

;CONCENTRADOR.c,68 :: 		void interrupt()
;CONCENTRADOR.c,70 :: 		RS485Master_Receive(master_rx_dat);
	MOVLW       _master_rx_dat+0
	MOVWF       FARG_RS485Master_Receive_data_buffer+0 
	MOVLW       hi_addr(_master_rx_dat+0)
	MOVWF       FARG_RS485Master_Receive_data_buffer+1 
	CALL        _RS485Master_Receive+0, 0
;CONCENTRADOR.c,71 :: 		}
L_end_interrupt:
L__interrupt103:
	RETFIE      1
; end of _interrupt

_main:

;CONCENTRADOR.c,73 :: 		void main()
;CONCENTRADOR.c,75 :: 		ADCON1= 0b00001111;                     // Configure AN pins as digital I/O
	MOVLW       15
	MOVWF       ADCON1+0 
;CONCENTRADOR.c,76 :: 		CMCON = 0b00000111;                     // Disable comparators
	MOVLW       7
	MOVWF       CMCON+0 
;CONCENTRADOR.c,77 :: 		TRISA.RA3=0; TRISA.RA4=0;
	BCF         TRISA+0, 3 
	BCF         TRISA+0, 4 
;CONCENTRADOR.c,78 :: 		PORTA.RA3=0; PORTA.RA4=0;
	BCF         PORTA+0, 3 
	BCF         PORTA+0, 4 
;CONCENTRADOR.c,81 :: 		SUart0_Init_T();
	CALL        _SUart0_Init_T+0, 0
;CONCENTRADOR.c,82 :: 		SUart2_Init_T();
	CALL        _SUart2_Init_T+0, 0
;CONCENTRADOR.c,84 :: 		TRISC.RC0 = 1;                          //add PC para lectura del SW_ON
	BSF         TRISC+0, 0 
;CONCENTRADOR.c,85 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;CONCENTRADOR.c,86 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;CONCENTRADOR.c,87 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;CONCENTRADOR.c,89 :: 		TRISC.TRISC1 = 1;
	BSF         TRISC+0, 1 
;CONCENTRADOR.c,90 :: 		PORTC.RC1 = 1;
	BSF         PORTC+0, 1 
;CONCENTRADOR.c,91 :: 		TRISC.TRISC2 = 1;
	BSF         TRISC+0, 2 
;CONCENTRADOR.c,92 :: 		PORTC.RC2 = 1;
	BSF         PORTC+0, 2 
;CONCENTRADOR.c,95 :: 		UART1_Init(9600); Delay_ms(100);      // initialize UART1 module
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
;CONCENTRADOR.c,96 :: 		RS485Master_Init(); Delay_ms(100);    // initialize MCU as Master
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
;CONCENTRADOR.c,97 :: 		RCIE_bit = 1;                         // enable interrupt on UART1 receive
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;CONCENTRADOR.c,98 :: 		TXIE_bit = 0;                         // disable interrupt on UART1 transmit
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;CONCENTRADOR.c,99 :: 		PEIE_bit = 1;                         // enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;CONCENTRADOR.c,100 :: 		GIE_bit = 1;                          // enable all interrupts
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;CONCENTRADOR.c,103 :: 		peticion(esclavo);
	MOVF        _esclavo+0, 0 
	MOVWF       FARG_peticion_dirEsclavo+0 
	CALL        _peticion+0, 0
;CONCENTRADOR.c,105 :: 		while(1)
L_main2:
;CONCENTRADOR.c,108 :: 		if (master_rx_dat[5])
	MOVF        _master_rx_dat+5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
;CONCENTRADOR.c,110 :: 		LED_TTR=1;
	BSF         PORTA+0, 4 
;CONCENTRADOR.c,111 :: 		Delay_ms(10);
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
;CONCENTRADOR.c,112 :: 		LED_TTR=0;
	BCF         PORTA+0, 4 
;CONCENTRADOR.c,113 :: 		master_rx_dat[5]=0;
	CLRF        _master_rx_dat+5 
;CONCENTRADOR.c,114 :: 		master_rx_dat[4]=0;
	CLRF        _master_rx_dat+4 
;CONCENTRADOR.c,115 :: 		}
L_main4:
;CONCENTRADOR.c,118 :: 		if(fbt>0)
	MOVF        _fbt+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;CONCENTRADOR.c,120 :: 		cnt++;
	MOVLW       1
	ADDWF       _cnt+0, 1 
	MOVLW       0
	ADDWFC      _cnt+1, 1 
	ADDWFC      _cnt+2, 1 
	ADDWFC      _cnt+3, 1 
;CONCENTRADOR.c,121 :: 		}
L_main6:
;CONCENTRADOR.c,122 :: 		if(cnt>14000*1) //modificado, valor original 14000 * 100
	MOVF        _cnt+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main105
	MOVF        _cnt+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main105
	MOVF        _cnt+1, 0 
	SUBLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L__main105
	MOVF        _cnt+0, 0 
	SUBLW       176
L__main105:
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;CONCENTRADOR.c,124 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,125 :: 		fbt=0;
	CLRF        _fbt+0 
;CONCENTRADOR.c,126 :: 		LED_485=0;
	BCF         PORTA+0, 3 
;CONCENTRADOR.c,127 :: 		pbuffer=0;
	CLRF        _pbuffer+0 
;CONCENTRADOR.c,128 :: 		entran=0; salen=0; bloqueos=0;
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
;CONCENTRADOR.c,130 :: 		imprimirAlerta('R'); //addPC
	MOVLW       82
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,131 :: 		}
L_main7:
;CONCENTRADOR.c,134 :: 		if (master_rx_dat[4] && !master_rx_dat[5])
	MOVF        _master_rx_dat+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVF        _master_rx_dat+5, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
L__main101:
;CONCENTRADOR.c,136 :: 		if(fbt==0)
	MOVF        _fbt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;CONCENTRADOR.c,138 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,139 :: 		entran=0;
	CLRF        _entran+0 
	CLRF        _entran+1 
	CLRF        _entran+2 
	CLRF        _entran+3 
;CONCENTRADOR.c,140 :: 		LED_485=1;
	BSF         PORTA+0, 3 
;CONCENTRADOR.c,141 :: 		buffer[pbuffer++]='i';
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
;CONCENTRADOR.c,142 :: 		id_slave=master_rx_dat[6];
	MOVF        _master_rx_dat+6, 0 
	MOVWF       _id_slave+0 
;CONCENTRADOR.c,143 :: 		buffer[pbuffer++]=master_rx_dat[6]+48; //unsigned short a caracter ascii
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
;CONCENTRADOR.c,144 :: 		entran+=(unsigned long int)master_rx_dat[0];
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
;CONCENTRADOR.c,145 :: 		entran+=(((unsigned long int)master_rx_dat[1])<<8);
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
;CONCENTRADOR.c,146 :: 		entran+=(((unsigned long int)master_rx_dat[2])<<16);
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
;CONCENTRADOR.c,147 :: 		fbt=1;
	MOVLW       1
	MOVWF       _fbt+0 
;CONCENTRADOR.c,148 :: 		}
	GOTO        L_main12
L_main11:
;CONCENTRADOR.c,149 :: 		else if(fbt==1)
	MOVF        _fbt+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
;CONCENTRADOR.c,151 :: 		entran+=(((unsigned long int)master_rx_dat[0])<<24);
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
;CONCENTRADOR.c,152 :: 		salen+=(unsigned long int)master_rx_dat[1];
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
;CONCENTRADOR.c,153 :: 		salen+=(((unsigned long int)master_rx_dat[2])<<8);
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
;CONCENTRADOR.c,154 :: 		fbt=2;
	MOVLW       2
	MOVWF       _fbt+0 
;CONCENTRADOR.c,155 :: 		}
	GOTO        L_main14
L_main13:
;CONCENTRADOR.c,156 :: 		else if(fbt==2)
	MOVF        _fbt+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
;CONCENTRADOR.c,158 :: 		salen+=(((unsigned long int)master_rx_dat[0])<<16);
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
;CONCENTRADOR.c,159 :: 		salen+=(((unsigned long int)master_rx_dat[1])<<24);
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
;CONCENTRADOR.c,160 :: 		bloqueos+=(unsigned long int)master_rx_dat[2];
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
;CONCENTRADOR.c,161 :: 		fbt=3;
	MOVLW       3
	MOVWF       _fbt+0 
;CONCENTRADOR.c,162 :: 		}
	GOTO        L_main16
L_main15:
;CONCENTRADOR.c,163 :: 		else if(fbt==3)
	MOVF        _fbt+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
;CONCENTRADOR.c,165 :: 		bloqueos+=(((unsigned long int)master_rx_dat[1])<<8);
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
;CONCENTRADOR.c,166 :: 		bloqueos+=(((unsigned long int)master_rx_dat[2])<<16);
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
;CONCENTRADOR.c,167 :: 		bloqueos+=(((unsigned long int)master_rx_dat[1])<<24);
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
;CONCENTRADOR.c,168 :: 		fbt=4;
	MOVLW       4
	MOVWF       _fbt+0 
;CONCENTRADOR.c,169 :: 		}
L_main17:
L_main16:
L_main14:
L_main12:
;CONCENTRADOR.c,170 :: 		master_rx_dat[4] = 0; master_rx_dat[6]=0;
	CLRF        _master_rx_dat+4 
	CLRF        _master_rx_dat+6 
;CONCENTRADOR.c,171 :: 		}
L_main10:
;CONCENTRADOR.c,173 :: 		if(fbt==4)
	MOVF        _fbt+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;CONCENTRADOR.c,175 :: 		LED_485=0;
	BCF         PORTA+0, 3 
;CONCENTRADOR.c,176 :: 		LongWordToStrWithZeros(entran,s_entran);
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
;CONCENTRADOR.c,177 :: 		LongWordToStrWithZeros(salen,s_salen);
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
;CONCENTRADOR.c,178 :: 		LongWordToStrWithZeros(bloqueos,s_bloqueos);
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
;CONCENTRADOR.c,179 :: 		buffer[pbuffer++]='E';
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
;CONCENTRADOR.c,180 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_entran[u]; }
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
;CONCENTRADOR.c,181 :: 		buffer[pbuffer++]='S';
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
;CONCENTRADOR.c,182 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_salen[u]; }
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
;CONCENTRADOR.c,183 :: 		buffer[pbuffer++]='B';
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
;CONCENTRADOR.c,184 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_bloqueos[u]; }
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
;CONCENTRADOR.c,185 :: 		buffer[pbuffer++]='V';          //add para vandalismo
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVLW       86
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
;CONCENTRADOR.c,186 :: 		buffer[pbuffer++]=vandalismo;   //add para vandalismo
	MOVLW       _buffer+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FSR1H 
	MOVF        _pbuffer+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        _vandalismo+0, 0 
	MOVWF       POSTINC1+0 
	INCF        _pbuffer+0, 1 
;CONCENTRADOR.c,187 :: 		buffer[pbuffer++]='#';
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
;CONCENTRADOR.c,189 :: 		SUart0_RstrNout(buffer,38);             //Transmitir por bluetooth
	MOVLW       _buffer+0
	MOVWF       FARG_SUart0_RstrNout_ptr+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_SUart0_RstrNout_ptr+1 
	MOVLW       38
	MOVWF       FARG_SUart0_RstrNout_n+0 
	CALL        _SUart0_RstrNout+0, 0
;CONCENTRADOR.c,190 :: 		SUart0_write('\r'); SUart0_write('\n'); //add PC salto de linea
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,195 :: 		transmitirGPS(300);                 //ENVIAR POR GV300
	MOVLW       44
	MOVWF       FARG_transmitirGPS_GPS+0 
	MOVLW       1
	MOVWF       FARG_transmitirGPS_GPS+1 
	CALL        _transmitirGPS+0, 0
;CONCENTRADOR.c,197 :: 		fbt=0; pbuffer=0;
	CLRF        _fbt+0 
	CLRF        _pbuffer+0 
;CONCENTRADOR.c,199 :: 		entran=0; salen=0; bloqueos=0;
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
;CONCENTRADOR.c,200 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,203 :: 		cnt1 = cnt2 = 0;
	CLRF        _cnt2+0 
	CLRF        _cnt2+1 
	CLRF        _cnt2+2 
	CLRF        _cnt2+3 
	CLRF        _cnt1+0 
	CLRF        _cnt1+1 
	CLRF        _cnt1+2 
	CLRF        _cnt1+3 
;CONCENTRADOR.c,204 :: 		suma = 0;
	CLRF        _suma+0 
	CLRF        _suma+1 
;CONCENTRADOR.c,205 :: 		reset = 1;
	MOVLW       1
	MOVWF       _reset+0 
	MOVLW       0
	MOVWF       _reset+1 
;CONCENTRADOR.c,207 :: 		}
	GOTO        L_main28
L_main18:
;CONCENTRADOR.c,210 :: 		cnt1++;
	MOVLW       1
	ADDWF       _cnt1+0, 1 
	MOVLW       0
	ADDWFC      _cnt1+1, 1 
	ADDWFC      _cnt1+2, 1 
	ADDWFC      _cnt1+3, 1 
;CONCENTRADOR.c,211 :: 		if(cnt1 > 140000)
	MOVF        _cnt1+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main106
	MOVF        _cnt1+2, 0 
	SUBLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__main106
	MOVF        _cnt1+1, 0 
	SUBLW       34
	BTFSS       STATUS+0, 2 
	GOTO        L__main106
	MOVF        _cnt1+0, 0 
	SUBLW       224
L__main106:
	BTFSC       STATUS+0, 0 
	GOTO        L_main29
;CONCENTRADOR.c,213 :: 		if(esclavo == 10)
	MOVF        _esclavo+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main30
;CONCENTRADOR.c,214 :: 		esclavo_ant = 30;
	MOVLW       30
	MOVWF       _esclavo_ant+0 
	GOTO        L_main31
L_main30:
;CONCENTRADOR.c,215 :: 		else if(esclavo == 20)
	MOVF        _esclavo+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_main32
;CONCENTRADOR.c,216 :: 		esclavo_ant = 10;
	MOVLW       10
	MOVWF       _esclavo_ant+0 
	GOTO        L_main33
L_main32:
;CONCENTRADOR.c,217 :: 		else if(esclavo == 30)
	MOVF        _esclavo+0, 0 
	XORLW       30
	BTFSS       STATUS+0, 2 
	GOTO        L_main34
;CONCENTRADOR.c,218 :: 		esclavo_ant = 20;
	MOVLW       20
	MOVWF       _esclavo_ant+0 
L_main34:
L_main33:
L_main31:
;CONCENTRADOR.c,233 :: 		cnt1 = 0;
	CLRF        _cnt1+0 
	CLRF        _cnt1+1 
	CLRF        _cnt1+2 
	CLRF        _cnt1+3 
;CONCENTRADOR.c,234 :: 		cnt2++;
	MOVLW       1
	ADDWF       _cnt2+0, 1 
	MOVLW       0
	ADDWFC      _cnt2+1, 1 
	ADDWFC      _cnt2+2, 1 
	ADDWFC      _cnt2+3, 1 
;CONCENTRADOR.c,236 :: 		if(cnt2 > 9)
	MOVF        _cnt2+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main107
	MOVF        _cnt2+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main107
	MOVF        _cnt2+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main107
	MOVF        _cnt2+0, 0 
	SUBLW       9
L__main107:
	BTFSC       STATUS+0, 0 
	GOTO        L_main35
;CONCENTRADOR.c,238 :: 		if(esclavo_ant == 10) //esclavo 10
	MOVF        _esclavo_ant+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
;CONCENTRADOR.c,240 :: 		sinE1++;
	MOVLW       1
	ADDWF       _sinE1+0, 1 
	MOVLW       0
	ADDWFC      _sinE1+1, 1 
	ADDWFC      _sinE1+2, 1 
	ADDWFC      _sinE1+3, 1 
;CONCENTRADOR.c,241 :: 		if(sinE1 > 4)
	MOVF        _sinE1+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main108
	MOVF        _sinE1+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main108
	MOVF        _sinE1+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main108
	MOVF        _sinE1+0, 0 
	SUBLW       4
L__main108:
	BTFSC       STATUS+0, 0 
	GOTO        L_main37
;CONCENTRADOR.c,243 :: 		vandalismo.B1 = 1;
	BSF         _vandalismo+0, 1 
;CONCENTRADOR.c,244 :: 		response[0]='F';response[1]='A';response[2]='L';
	MOVLW       70
	MOVWF       _response+0 
	MOVLW       65
	MOVWF       _response+1 
	MOVLW       76
	MOVWF       _response+2 
;CONCENTRADOR.c,245 :: 		response[3]='L';response[4]='A';response[5]=' ';
	MOVLW       76
	MOVWF       _response+3 
	MOVLW       65
	MOVWF       _response+4 
	MOVLW       32
	MOVWF       _response+5 
;CONCENTRADOR.c,246 :: 		response[6]='E';response[7]='N';response[8]=' ';
	MOVLW       69
	MOVWF       _response+6 
	MOVLW       78
	MOVWF       _response+7 
	MOVLW       32
	MOVWF       _response+8 
;CONCENTRADOR.c,247 :: 		response[9]='S';response[10]=((esclavo_ant/10)+48);
	MOVLW       83
	MOVWF       _response+9 
	MOVLW       10
	MOVWF       R4 
	MOVF        _esclavo_ant+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _response+10 
;CONCENTRADOR.c,248 :: 		imprimirMensaje(&response);
	MOVLW       _response+0
	MOVWF       FARG_imprimirMensaje_mensaje+0 
	MOVLW       hi_addr(_response+0)
	MOVWF       FARG_imprimirMensaje_mensaje+1 
	CALL        _imprimirMensaje+0, 0
;CONCENTRADOR.c,249 :: 		if(sinE1 > 9)
	MOVF        _sinE1+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main109
	MOVF        _sinE1+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main109
	MOVF        _sinE1+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main109
	MOVF        _sinE1+0, 0 
	SUBLW       9
L__main109:
	BTFSC       STATUS+0, 0 
	GOTO        L_main38
;CONCENTRADOR.c,250 :: 		sinE1 = 5;
	MOVLW       5
	MOVWF       _sinE1+0 
	MOVLW       0
	MOVWF       _sinE1+1 
	MOVWF       _sinE1+2 
	MOVWF       _sinE1+3 
L_main38:
;CONCENTRADOR.c,251 :: 		}
L_main37:
;CONCENTRADOR.c,252 :: 		}
	GOTO        L_main39
L_main36:
;CONCENTRADOR.c,253 :: 		else if(esclavo_ant == 20) //esclavo 20
	MOVF        _esclavo_ant+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_main40
;CONCENTRADOR.c,255 :: 		sinE2++;
	MOVLW       1
	ADDWF       _sinE2+0, 1 
	MOVLW       0
	ADDWFC      _sinE2+1, 1 
	ADDWFC      _sinE2+2, 1 
	ADDWFC      _sinE2+3, 1 
;CONCENTRADOR.c,256 :: 		if(sinE2 > 4)
	MOVF        _sinE2+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main110
	MOVF        _sinE2+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main110
	MOVF        _sinE2+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main110
	MOVF        _sinE2+0, 0 
	SUBLW       4
L__main110:
	BTFSC       STATUS+0, 0 
	GOTO        L_main41
;CONCENTRADOR.c,258 :: 		vandalismo.B2 = 1;
	BSF         _vandalismo+0, 2 
;CONCENTRADOR.c,259 :: 		response[0]='F';response[1]='A';response[2]='L';
	MOVLW       70
	MOVWF       _response+0 
	MOVLW       65
	MOVWF       _response+1 
	MOVLW       76
	MOVWF       _response+2 
;CONCENTRADOR.c,260 :: 		response[3]='L';response[4]='A';response[5]=' ';
	MOVLW       76
	MOVWF       _response+3 
	MOVLW       65
	MOVWF       _response+4 
	MOVLW       32
	MOVWF       _response+5 
;CONCENTRADOR.c,261 :: 		response[6]='E';response[7]='N';response[8]=' ';
	MOVLW       69
	MOVWF       _response+6 
	MOVLW       78
	MOVWF       _response+7 
	MOVLW       32
	MOVWF       _response+8 
;CONCENTRADOR.c,262 :: 		response[9]='S';response[10]=((esclavo_ant/10)+48);
	MOVLW       83
	MOVWF       _response+9 
	MOVLW       10
	MOVWF       R4 
	MOVF        _esclavo_ant+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _response+10 
;CONCENTRADOR.c,263 :: 		imprimirMensaje(&response);
	MOVLW       _response+0
	MOVWF       FARG_imprimirMensaje_mensaje+0 
	MOVLW       hi_addr(_response+0)
	MOVWF       FARG_imprimirMensaje_mensaje+1 
	CALL        _imprimirMensaje+0, 0
;CONCENTRADOR.c,264 :: 		if(sinE2 > 9)
	MOVF        _sinE2+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main111
	MOVF        _sinE2+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main111
	MOVF        _sinE2+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main111
	MOVF        _sinE2+0, 0 
	SUBLW       9
L__main111:
	BTFSC       STATUS+0, 0 
	GOTO        L_main42
;CONCENTRADOR.c,265 :: 		sinE2 = 5;
	MOVLW       5
	MOVWF       _sinE2+0 
	MOVLW       0
	MOVWF       _sinE2+1 
	MOVWF       _sinE2+2 
	MOVWF       _sinE2+3 
L_main42:
;CONCENTRADOR.c,266 :: 		}
L_main41:
;CONCENTRADOR.c,267 :: 		}
	GOTO        L_main43
L_main40:
;CONCENTRADOR.c,268 :: 		else if(esclavo_ant == 30) //esclavo 30
	MOVF        _esclavo_ant+0, 0 
	XORLW       30
	BTFSS       STATUS+0, 2 
	GOTO        L_main44
;CONCENTRADOR.c,270 :: 		sinE3++;
	MOVLW       1
	ADDWF       _sinE3+0, 1 
	MOVLW       0
	ADDWFC      _sinE3+1, 1 
	ADDWFC      _sinE3+2, 1 
	ADDWFC      _sinE3+3, 1 
;CONCENTRADOR.c,271 :: 		if(sinE3 > 4)
	MOVF        _sinE3+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main112
	MOVF        _sinE3+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main112
	MOVF        _sinE3+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main112
	MOVF        _sinE3+0, 0 
	SUBLW       4
L__main112:
	BTFSC       STATUS+0, 0 
	GOTO        L_main45
;CONCENTRADOR.c,273 :: 		vandalismo.B3 = 1;
	BSF         _vandalismo+0, 3 
;CONCENTRADOR.c,274 :: 		response[0]='F';response[1]='A';response[2]='L';
	MOVLW       70
	MOVWF       _response+0 
	MOVLW       65
	MOVWF       _response+1 
	MOVLW       76
	MOVWF       _response+2 
;CONCENTRADOR.c,275 :: 		response[3]='L';response[4]='A';response[5]=' ';
	MOVLW       76
	MOVWF       _response+3 
	MOVLW       65
	MOVWF       _response+4 
	MOVLW       32
	MOVWF       _response+5 
;CONCENTRADOR.c,276 :: 		response[6]='E';response[7]='N';response[8]=' ';
	MOVLW       69
	MOVWF       _response+6 
	MOVLW       78
	MOVWF       _response+7 
	MOVLW       32
	MOVWF       _response+8 
;CONCENTRADOR.c,277 :: 		response[9]='S';response[10]=((esclavo_ant/10)+48);
	MOVLW       83
	MOVWF       _response+9 
	MOVLW       10
	MOVWF       R4 
	MOVF        _esclavo_ant+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _response+10 
;CONCENTRADOR.c,278 :: 		imprimirMensaje(&response);
	MOVLW       _response+0
	MOVWF       FARG_imprimirMensaje_mensaje+0 
	MOVLW       hi_addr(_response+0)
	MOVWF       FARG_imprimirMensaje_mensaje+1 
	CALL        _imprimirMensaje+0, 0
;CONCENTRADOR.c,279 :: 		if(sinE3 > 9)
	MOVF        _sinE3+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main113
	MOVF        _sinE3+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main113
	MOVF        _sinE3+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main113
	MOVF        _sinE3+0, 0 
	SUBLW       9
L__main113:
	BTFSC       STATUS+0, 0 
	GOTO        L_main46
;CONCENTRADOR.c,280 :: 		sinE3 = 5;
	MOVLW       5
	MOVWF       _sinE3+0 
	MOVLW       0
	MOVWF       _sinE3+1 
	MOVWF       _sinE3+2 
	MOVWF       _sinE3+3 
L_main46:
;CONCENTRADOR.c,281 :: 		}
L_main45:
;CONCENTRADOR.c,282 :: 		}
L_main44:
L_main43:
L_main39:
;CONCENTRADOR.c,283 :: 		cnt2=0;
	CLRF        _cnt2+0 
	CLRF        _cnt2+1 
	CLRF        _cnt2+2 
	CLRF        _cnt2+3 
;CONCENTRADOR.c,284 :: 		}
	GOTO        L_main47
L_main35:
;CONCENTRADOR.c,285 :: 		else if(reset)
	MOVF        _reset+0, 0 
	IORWF       _reset+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main48
;CONCENTRADOR.c,287 :: 		if(esclavo_ant == 10)
	MOVF        _esclavo_ant+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main49
;CONCENTRADOR.c,289 :: 		sinE1 = 0;
	CLRF        _sinE1+0 
	CLRF        _sinE1+1 
	CLRF        _sinE1+2 
	CLRF        _sinE1+3 
;CONCENTRADOR.c,290 :: 		vandalismo.B1 = 0;
	BCF         _vandalismo+0, 1 
;CONCENTRADOR.c,296 :: 		}
	GOTO        L_main50
L_main49:
;CONCENTRADOR.c,297 :: 		else if(esclavo_ant == 20)
	MOVF        _esclavo_ant+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_main51
;CONCENTRADOR.c,299 :: 		sinE2 = 0;
	CLRF        _sinE2+0 
	CLRF        _sinE2+1 
	CLRF        _sinE2+2 
	CLRF        _sinE2+3 
;CONCENTRADOR.c,300 :: 		vandalismo.B2 = 0;
	BCF         _vandalismo+0, 2 
;CONCENTRADOR.c,306 :: 		}
	GOTO        L_main52
L_main51:
;CONCENTRADOR.c,307 :: 		else if(esclavo_ant == 30)
	MOVF        _esclavo_ant+0, 0 
	XORLW       30
	BTFSS       STATUS+0, 2 
	GOTO        L_main53
;CONCENTRADOR.c,309 :: 		sinE3 = 0;
	CLRF        _sinE3+0 
	CLRF        _sinE3+1 
	CLRF        _sinE3+2 
	CLRF        _sinE3+3 
;CONCENTRADOR.c,310 :: 		vandalismo.B3 = 0;
	BCF         _vandalismo+0, 3 
;CONCENTRADOR.c,316 :: 		}
L_main53:
L_main52:
L_main50:
;CONCENTRADOR.c,317 :: 		reset = 0;
	CLRF        _reset+0 
	CLRF        _reset+1 
;CONCENTRADOR.c,318 :: 		}
L_main48:
L_main47:
;CONCENTRADOR.c,319 :: 		}
L_main29:
;CONCENTRADOR.c,320 :: 		}
L_main28:
;CONCENTRADOR.c,331 :: 		counter2++;
	MOVLW       1
	ADDWF       _counter2+0, 1 
	MOVLW       0
	ADDWFC      _counter2+1, 1 
	ADDWFC      _counter2+2, 1 
	ADDWFC      _counter2+3, 1 
;CONCENTRADOR.c,332 :: 		if(counter2>(140000*10))
	MOVF        _counter2+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main114
	MOVF        _counter2+2, 0 
	SUBLW       21
	BTFSS       STATUS+0, 2 
	GOTO        L__main114
	MOVF        _counter2+1, 0 
	SUBLW       92
	BTFSS       STATUS+0, 2 
	GOTO        L__main114
	MOVF        _counter2+0, 0 
	SUBLW       192
L__main114:
	BTFSC       STATUS+0, 0 
	GOTO        L_main54
;CONCENTRADOR.c,334 :: 		counter2=0;
	CLRF        _counter2+0 
	CLRF        _counter2+1 
	CLRF        _counter2+2 
	CLRF        _counter2+3 
;CONCENTRADOR.c,339 :: 		response[0] = 'B';response[1] = 'A';
	MOVLW       66
	MOVWF       _response+0 
	MOVLW       65
	MOVWF       _response+1 
;CONCENTRADOR.c,340 :: 		response[2] = 'R';response[3] = 'R';
	MOVLW       82
	MOVWF       _response+2 
	MOVLW       82
	MOVWF       _response+3 
;CONCENTRADOR.c,341 :: 		response[4] = 'A';response[5] = ' ';
	MOVLW       65
	MOVWF       _response+4 
	MOVLW       32
	MOVWF       _response+5 
;CONCENTRADOR.c,342 :: 		response[6] = ' ';response[7] = ' ';
	MOVLW       32
	MOVWF       _response+6 
	MOVLW       32
	MOVWF       _response+7 
;CONCENTRADOR.c,343 :: 		response[8] = '>';response[9] = ' ';response[10] = ((esclavo/10)+48);
	MOVLW       62
	MOVWF       _response+8 
	MOVLW       32
	MOVWF       _response+9 
	MOVLW       10
	MOVWF       R4 
	MOVF        _esclavo+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _response+10 
;CONCENTRADOR.c,344 :: 		imprimirMensaje(&response);
	MOVLW       _response+0
	MOVWF       FARG_imprimirMensaje_mensaje+0 
	MOVLW       hi_addr(_response+0)
	MOVWF       FARG_imprimirMensaje_mensaje+1 
	CALL        _imprimirMensaje+0, 0
;CONCENTRADOR.c,345 :: 		peticion(esclavo);              //pedido de información al esclavo
	MOVF        _esclavo+0, 0 
	MOVWF       FARG_peticion_dirEsclavo+0 
	CALL        _peticion+0, 0
;CONCENTRADOR.c,346 :: 		esclavo += 10;                  //incrementar direccion de esclavo
	MOVLW       10
	ADDWF       _esclavo+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _esclavo+0 
;CONCENTRADOR.c,347 :: 		if(esclavo > 30){esclavo = 10;} //control desborde de esclavos
	MOVF        R1, 0 
	SUBLW       30
	BTFSC       STATUS+0, 0 
	GOTO        L_main55
	MOVLW       10
	MOVWF       _esclavo+0 
L_main55:
;CONCENTRADOR.c,348 :: 		}
L_main54:
;CONCENTRADOR.c,356 :: 		counter1++;
	MOVLW       1
	ADDWF       _counter1+0, 1 
	MOVLW       0
	ADDWFC      _counter1+1, 1 
	ADDWFC      _counter1+2, 1 
	ADDWFC      _counter1+3, 1 
;CONCENTRADOR.c,357 :: 		if(counter1>(140000*10))
	MOVF        _counter1+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main115
	MOVF        _counter1+2, 0 
	SUBLW       21
	BTFSS       STATUS+0, 2 
	GOTO        L__main115
	MOVF        _counter1+1, 0 
	SUBLW       92
	BTFSS       STATUS+0, 2 
	GOTO        L__main115
	MOVF        _counter1+0, 0 
	SUBLW       192
L__main115:
	BTFSC       STATUS+0, 0 
	GOTO        L_main56
;CONCENTRADOR.c,359 :: 		counter1=0;
	CLRF        _counter1+0 
	CLRF        _counter1+1 
	CLRF        _counter1+2 
	CLRF        _counter1+3 
;CONCENTRADOR.c,361 :: 		}
L_main56:
;CONCENTRADOR.c,368 :: 		if(SWITCH_ON)
	BTFSS       PORTC+0, 0 
	GOTO        L_main57
;CONCENTRADOR.c,370 :: 		seg_off++;
	MOVLW       1
	ADDWF       _seg_off+0, 1 
	MOVLW       0
	ADDWFC      _seg_off+1, 1 
	ADDWFC      _seg_off+2, 1 
	ADDWFC      _seg_off+3, 1 
;CONCENTRADOR.c,375 :: 		if((seg_off > (54026 * 10)) && DS_FUENTE == 0)
	MOVF        _seg_off+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main116
	MOVF        _seg_off+2, 0 
	SUBLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L__main116
	MOVF        _seg_off+1, 0 
	SUBLW       62
	BTFSS       STATUS+0, 2 
	GOTO        L__main116
	MOVF        _seg_off+0, 0 
	SUBLW       100
L__main116:
	BTFSC       STATUS+0, 0 
	GOTO        L_main60
	BTFSC       PORTB+0, 5 
	GOTO        L_main60
L__main100:
;CONCENTRADOR.c,377 :: 		seg_off = 0;
	CLRF        _seg_off+0 
	CLRF        _seg_off+1 
	CLRF        _seg_off+2 
	CLRF        _seg_off+3 
;CONCENTRADOR.c,378 :: 		DS_FUENTE = 1;
	BSF         PORTB+0, 5 
;CONCENTRADOR.c,379 :: 		SUart0_write('O');  SUart0_write('F'); SUart0_write('F'); //off
	MOVLW       79
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       70
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       70
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,380 :: 		SUart0_write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,381 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,382 :: 		}
L_main60:
;CONCENTRADOR.c,384 :: 		}
	GOTO        L_main61
L_main57:
;CONCENTRADOR.c,387 :: 		seg_off = 0;
	CLRF        _seg_off+0 
	CLRF        _seg_off+1 
	CLRF        _seg_off+2 
	CLRF        _seg_off+3 
;CONCENTRADOR.c,388 :: 		DS_FUENTE = 0;
	BCF         PORTB+0, 5 
;CONCENTRADOR.c,389 :: 		}
L_main61:
;CONCENTRADOR.c,425 :: 		}
	GOTO        L_main2
;CONCENTRADOR.c,426 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_imprimirAlerta:

;CONCENTRADOR.c,434 :: 		void imprimirAlerta(char lugar)
;CONCENTRADOR.c,436 :: 		SUart0_write(lugar);
	MOVF        FARG_imprimirAlerta_lugar+0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,437 :: 		SUart0_write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,438 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,439 :: 		}
L_end_imprimirAlerta:
	RETURN      0
; end of _imprimirAlerta

_imprimirMensaje:

;CONCENTRADOR.c,440 :: 		void imprimirMensaje(char mensaje[11])
;CONCENTRADOR.c,442 :: 		int u = 0;
	CLRF        imprimirMensaje_u_L0+0 
	CLRF        imprimirMensaje_u_L0+1 
;CONCENTRADOR.c,443 :: 		for(u = 0; u < 11; u++)
	CLRF        imprimirMensaje_u_L0+0 
	CLRF        imprimirMensaje_u_L0+1 
L_imprimirMensaje62:
	MOVLW       128
	XORWF       imprimirMensaje_u_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__imprimirMensaje119
	MOVLW       11
	SUBWF       imprimirMensaje_u_L0+0, 0 
L__imprimirMensaje119:
	BTFSC       STATUS+0, 0 
	GOTO        L_imprimirMensaje63
;CONCENTRADOR.c,445 :: 		SUart0_write(mensaje[u]);
	MOVF        imprimirMensaje_u_L0+0, 0 
	ADDWF       FARG_imprimirMensaje_mensaje+0, 0 
	MOVWF       FSR0 
	MOVF        imprimirMensaje_u_L0+1, 0 
	ADDWFC      FARG_imprimirMensaje_mensaje+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,443 :: 		for(u = 0; u < 11; u++)
	INFSNZ      imprimirMensaje_u_L0+0, 1 
	INCF        imprimirMensaje_u_L0+1, 1 
;CONCENTRADOR.c,446 :: 		}
	GOTO        L_imprimirMensaje62
L_imprimirMensaje63:
;CONCENTRADOR.c,447 :: 		SUart0_write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,448 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,449 :: 		}
L_end_imprimirMensaje:
	RETURN      0
; end of _imprimirMensaje

_peticion:

;CONCENTRADOR.c,461 :: 		void peticion(char dirEsclavo)
;CONCENTRADOR.c,463 :: 		dat[0] = 0xFF;
	MOVLW       255
	MOVWF       _dat+0 
;CONCENTRADOR.c,464 :: 		dat[1] = 0xFF;
	MOVLW       255
	MOVWF       _dat+1 
;CONCENTRADOR.c,465 :: 		dat[2] = 0xFF;
	MOVLW       255
	MOVWF       _dat+2 
;CONCENTRADOR.c,466 :: 		dat[4] = 0;
	CLRF        _dat+4 
;CONCENTRADOR.c,467 :: 		dat[5] = 0;
	CLRF        _dat+5 
;CONCENTRADOR.c,468 :: 		dat[6] = 0;
	CLRF        _dat+6 
;CONCENTRADOR.c,469 :: 		RS485Master_Send(dat,1,dirEsclavo);
	MOVLW       _dat+0
	MOVWF       FARG_RS485Master_Send_data_buffer+0 
	MOVLW       hi_addr(_dat+0)
	MOVWF       FARG_RS485Master_Send_data_buffer+1 
	MOVLW       1
	MOVWF       FARG_RS485Master_Send_datalen+0 
	MOVF        FARG_peticion_dirEsclavo+0, 0 
	MOVWF       FARG_RS485Master_Send_slave_address+0 
	CALL        _RS485Master_Send+0, 0
;CONCENTRADOR.c,470 :: 		delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_peticion65:
	DECFSZ      R13, 1, 1
	BRA         L_peticion65
	DECFSZ      R12, 1, 1
	BRA         L_peticion65
;CONCENTRADOR.c,471 :: 		}
L_end_peticion:
	RETURN      0
; end of _peticion

_reiniciarEsclavos:

;CONCENTRADOR.c,483 :: 		void reiniciarEsclavos()
;CONCENTRADOR.c,485 :: 		dat[0] = 0xFA;
	MOVLW       250
	MOVWF       _dat+0 
;CONCENTRADOR.c,486 :: 		dat[1] = 0xFA;
	MOVLW       250
	MOVWF       _dat+1 
;CONCENTRADOR.c,487 :: 		dat[2] = 0xFA;
	MOVLW       250
	MOVWF       _dat+2 
;CONCENTRADOR.c,488 :: 		dat[4] = 0;
	CLRF        _dat+4 
;CONCENTRADOR.c,489 :: 		dat[5] = 0;
	CLRF        _dat+5 
;CONCENTRADOR.c,490 :: 		dat[6] = 0;
	CLRF        _dat+6 
;CONCENTRADOR.c,491 :: 		RS485Master_Send(dat,1,50);  //ENVIO DE MENSAJE DE RESET A BROADCAST dir = 50
	MOVLW       _dat+0
	MOVWF       FARG_RS485Master_Send_data_buffer+0 
	MOVLW       hi_addr(_dat+0)
	MOVWF       FARG_RS485Master_Send_data_buffer+1 
	MOVLW       1
	MOVWF       FARG_RS485Master_Send_datalen+0 
	MOVLW       50
	MOVWF       FARG_RS485Master_Send_slave_address+0 
	CALL        _RS485Master_Send+0, 0
;CONCENTRADOR.c,492 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_reiniciarEsclavos66:
	DECFSZ      R13, 1, 1
	BRA         L_reiniciarEsclavos66
	DECFSZ      R12, 1, 1
	BRA         L_reiniciarEsclavos66
	NOP
;CONCENTRADOR.c,493 :: 		}
L_end_reiniciarEsclavos:
	RETURN      0
; end of _reiniciarEsclavos

_restaurarEsclavos:

;CONCENTRADOR.c,504 :: 		void restaurarEsclavos()
;CONCENTRADOR.c,506 :: 		dat[0] = 0xFB;
	MOVLW       251
	MOVWF       _dat+0 
;CONCENTRADOR.c,507 :: 		dat[1] = 0xFB;
	MOVLW       251
	MOVWF       _dat+1 
;CONCENTRADOR.c,508 :: 		dat[2] = 0xFB;
	MOVLW       251
	MOVWF       _dat+2 
;CONCENTRADOR.c,509 :: 		dat[4] = 0;
	CLRF        _dat+4 
;CONCENTRADOR.c,510 :: 		dat[5] = 0;
	CLRF        _dat+5 
;CONCENTRADOR.c,511 :: 		dat[6] = 0;
	CLRF        _dat+6 
;CONCENTRADOR.c,512 :: 		RS485Master_Send(dat,1,50);  //ENVIO DE MENSAJE DE RESET A BROADCAST dir = 50
	MOVLW       _dat+0
	MOVWF       FARG_RS485Master_Send_data_buffer+0 
	MOVLW       hi_addr(_dat+0)
	MOVWF       FARG_RS485Master_Send_data_buffer+1 
	MOVLW       1
	MOVWF       FARG_RS485Master_Send_datalen+0 
	MOVLW       50
	MOVWF       FARG_RS485Master_Send_slave_address+0 
	CALL        _RS485Master_Send+0, 0
;CONCENTRADOR.c,513 :: 		delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_restaurarEsclavos67:
	DECFSZ      R13, 1, 1
	BRA         L_restaurarEsclavos67
	DECFSZ      R12, 1, 1
	BRA         L_restaurarEsclavos67
	NOP
;CONCENTRADOR.c,514 :: 		}
L_end_restaurarEsclavos:
	RETURN      0
; end of _restaurarEsclavos

_buildBuf600:

;CONCENTRADOR.c,523 :: 		void buildBuf600()
;CONCENTRADOR.c,525 :: 		if(id_slave == 10)
	MOVF        _id_slave+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_buildBuf60068
;CONCENTRADOR.c,527 :: 		for(u=3;u<10;u++){ ee1[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_buildBuf60069:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_buildBuf60070
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
	GOTO        L_buildBuf60069
L_buildBuf60070:
;CONCENTRADOR.c,528 :: 		}
L_buildBuf60068:
;CONCENTRADOR.c,529 :: 		if(id_slave == 20)
	MOVF        _id_slave+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_buildBuf60072
;CONCENTRADOR.c,531 :: 		for(u=3;u<10;u++){ ee2[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_buildBuf60073:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_buildBuf60074
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
	GOTO        L_buildBuf60073
L_buildBuf60074:
;CONCENTRADOR.c,532 :: 		}
L_buildBuf60072:
;CONCENTRADOR.c,533 :: 		if(id_slave == 30)
	MOVF        _id_slave+0, 0 
	XORLW       30
	BTFSS       STATUS+0, 2 
	GOTO        L_buildBuf60076
;CONCENTRADOR.c,535 :: 		for(u=3;u<10;u++){ ee3[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_buildBuf60077:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_buildBuf60078
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
	GOTO        L_buildBuf60077
L_buildBuf60078:
;CONCENTRADOR.c,536 :: 		}
L_buildBuf60076:
;CONCENTRADOR.c,537 :: 		}
L_end_buildBuf600:
	RETURN      0
; end of _buildBuf600

_transmitirGPS:

;CONCENTRADOR.c,550 :: 		void transmitirGPS(int GPS)
;CONCENTRADOR.c,552 :: 		if(GPS == 300)      // PARA GV300
	MOVF        FARG_transmitirGPS_GPS+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__transmitirGPS125
	MOVLW       44
	XORWF       FARG_transmitirGPS_GPS+0, 0 
L__transmitirGPS125:
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS80
;CONCENTRADOR.c,554 :: 		for(u=0;u<38;u++) //modificado de 36 a 38
	CLRF        _u+0 
L_transmitirGPS81:
	MOVLW       38
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS82
;CONCENTRADOR.c,556 :: 		Suart2_write((char)buffer[u]); //TX por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,554 :: 		for(u=0;u<38;u++) //modificado de 36 a 38
	INCF        _u+0, 1 
;CONCENTRADOR.c,557 :: 		}
	GOTO        L_transmitirGPS81
L_transmitirGPS82:
;CONCENTRADOR.c,558 :: 		}
	GOTO        L_transmitirGPS84
L_transmitirGPS80:
;CONCENTRADOR.c,560 :: 		else if(GPS == 600) // PARA MVT600
	MOVF        FARG_transmitirGPS_GPS+1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__transmitirGPS126
	MOVLW       88
	XORWF       FARG_transmitirGPS_GPS+0, 0 
L__transmitirGPS126:
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS85
;CONCENTRADOR.c,562 :: 		if(ax==0)
	MOVF        _ax+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS86
;CONCENTRADOR.c,564 :: 		ax = 1;
	MOVLW       1
	MOVWF       _ax+0 
;CONCENTRADOR.c,565 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_transmitirGPS87:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS88
;CONCENTRADOR.c,567 :: 		Suart2_write((char)ee1[u]); //TX por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,565 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,568 :: 		}
	GOTO        L_transmitirGPS87
L_transmitirGPS88:
;CONCENTRADOR.c,569 :: 		}
	GOTO        L_transmitirGPS90
L_transmitirGPS86:
;CONCENTRADOR.c,570 :: 		else if (ax == 1)
	MOVF        _ax+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS91
;CONCENTRADOR.c,572 :: 		ax = 2;
	MOVLW       2
	MOVWF       _ax+0 
;CONCENTRADOR.c,573 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_transmitirGPS92:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS93
;CONCENTRADOR.c,575 :: 		Suart2_write((char)ee2[u]); //TX por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,573 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,576 :: 		}
	GOTO        L_transmitirGPS92
L_transmitirGPS93:
;CONCENTRADOR.c,577 :: 		}
	GOTO        L_transmitirGPS95
L_transmitirGPS91:
;CONCENTRADOR.c,578 :: 		else if (ax == 2)
	MOVF        _ax+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS96
;CONCENTRADOR.c,580 :: 		ax = 0;
	CLRF        _ax+0 
;CONCENTRADOR.c,581 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_transmitirGPS97:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS98
;CONCENTRADOR.c,583 :: 		Suart2_write((char)ee3[u]); //TX por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,581 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,584 :: 		}
	GOTO        L_transmitirGPS97
L_transmitirGPS98:
;CONCENTRADOR.c,585 :: 		}
L_transmitirGPS96:
L_transmitirGPS95:
L_transmitirGPS90:
;CONCENTRADOR.c,586 :: 		}
L_transmitirGPS85:
L_transmitirGPS84:
;CONCENTRADOR.c,587 :: 		}
L_end_transmitirGPS:
	RETURN      0
; end of _transmitirGPS
