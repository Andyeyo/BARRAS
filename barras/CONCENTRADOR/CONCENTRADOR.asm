
_interrupt:

;CONCENTRADOR.c,62 :: 		void interrupt()
;CONCENTRADOR.c,64 :: 		RS485Master_Receive(master_rx_dat);
	MOVLW       _master_rx_dat+0
	MOVWF       FARG_RS485Master_Receive_data_buffer+0 
	MOVLW       hi_addr(_master_rx_dat+0)
	MOVWF       FARG_RS485Master_Receive_data_buffer+1 
	CALL        _RS485Master_Receive+0, 0
;CONCENTRADOR.c,65 :: 		}
L_end_interrupt:
L__interrupt98:
	RETFIE      1
; end of _interrupt

_main:

;CONCENTRADOR.c,67 :: 		void main()
;CONCENTRADOR.c,69 :: 		ADCON1= 0b00001111;                     // Configure AN pins as digital I/O
	MOVLW       15
	MOVWF       ADCON1+0 
;CONCENTRADOR.c,70 :: 		CMCON = 0b00000111;                     // Disable comparators
	MOVLW       7
	MOVWF       CMCON+0 
;CONCENTRADOR.c,71 :: 		TRISA.RA3=0; TRISA.RA4=0;
	BCF         TRISA+0, 3 
	BCF         TRISA+0, 4 
;CONCENTRADOR.c,72 :: 		PORTA.RA3=0; PORTA.RA4=0;
	BCF         PORTA+0, 3 
	BCF         PORTA+0, 4 
;CONCENTRADOR.c,75 :: 		SUart0_Init_T();
	CALL        _SUart0_Init_T+0, 0
;CONCENTRADOR.c,76 :: 		SUart2_Init_T();
	CALL        _SUart2_Init_T+0, 0
;CONCENTRADOR.c,78 :: 		TRISC.RC0 = 1;                          //add PC para lectura del SW_ON
	BSF         TRISC+0, 0 
;CONCENTRADOR.c,79 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;CONCENTRADOR.c,80 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;CONCENTRADOR.c,81 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;CONCENTRADOR.c,84 :: 		UART1_Init(9600); Delay_ms(100);      // initialize UART1 module
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
;CONCENTRADOR.c,85 :: 		RS485Master_Init(); Delay_ms(100);    // initialize MCU as Master
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
;CONCENTRADOR.c,86 :: 		RCIE_bit = 1;                         // enable interrupt on UART1 receive
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;CONCENTRADOR.c,87 :: 		TXIE_bit = 0;                         // disable interrupt on UART1 transmit
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;CONCENTRADOR.c,88 :: 		PEIE_bit = 1;                         // enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;CONCENTRADOR.c,89 :: 		GIE_bit = 1;                          // enable all interrupts
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;CONCENTRADOR.c,92 :: 		peticion(esclavo);
	MOVF        _esclavo+0, 0 
	MOVWF       FARG_peticion_dirEsclavo+0 
	CALL        _peticion+0, 0
;CONCENTRADOR.c,94 :: 		while(1)
L_main2:
;CONCENTRADOR.c,97 :: 		if (master_rx_dat[5])
	MOVF        _master_rx_dat+5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
;CONCENTRADOR.c,99 :: 		LED_TTR=1;
	BSF         PORTA+0, 4 
;CONCENTRADOR.c,100 :: 		Delay_ms(10);
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
;CONCENTRADOR.c,101 :: 		LED_TTR=0;
	BCF         PORTA+0, 4 
;CONCENTRADOR.c,102 :: 		master_rx_dat[5]=0;
	CLRF        _master_rx_dat+5 
;CONCENTRADOR.c,103 :: 		master_rx_dat[4]=0;
	CLRF        _master_rx_dat+4 
;CONCENTRADOR.c,104 :: 		}
L_main4:
;CONCENTRADOR.c,107 :: 		if(fbt>0)
	MOVF        _fbt+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;CONCENTRADOR.c,109 :: 		cnt++;
	MOVLW       1
	ADDWF       _cnt+0, 1 
	MOVLW       0
	ADDWFC      _cnt+1, 1 
	ADDWFC      _cnt+2, 1 
	ADDWFC      _cnt+3, 1 
;CONCENTRADOR.c,110 :: 		}
L_main6:
;CONCENTRADOR.c,111 :: 		if(cnt>14000*1) //modificado, valor original 14000 * 100
	MOVF        _cnt+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main100
	MOVF        _cnt+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main100
	MOVF        _cnt+1, 0 
	SUBLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L__main100
	MOVF        _cnt+0, 0 
	SUBLW       176
L__main100:
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;CONCENTRADOR.c,113 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,114 :: 		fbt=0;
	CLRF        _fbt+0 
;CONCENTRADOR.c,115 :: 		LED_485=0;
	BCF         PORTA+0, 3 
;CONCENTRADOR.c,116 :: 		pbuffer=0;
	CLRF        _pbuffer+0 
;CONCENTRADOR.c,117 :: 		entran=0; salen=0; bloqueos=0;
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
;CONCENTRADOR.c,119 :: 		imprimirAlerta('R'); //addPC
	MOVLW       82
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,120 :: 		}
L_main7:
;CONCENTRADOR.c,123 :: 		if (master_rx_dat[4] && !master_rx_dat[5])
	MOVF        _master_rx_dat+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVF        _master_rx_dat+5, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
L__main96:
;CONCENTRADOR.c,125 :: 		if(fbt==0)
	MOVF        _fbt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
;CONCENTRADOR.c,127 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,128 :: 		entran=0;
	CLRF        _entran+0 
	CLRF        _entran+1 
	CLRF        _entran+2 
	CLRF        _entran+3 
;CONCENTRADOR.c,129 :: 		LED_485=1;
	BSF         PORTA+0, 3 
;CONCENTRADOR.c,130 :: 		buffer[pbuffer++]='i';
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
;CONCENTRADOR.c,131 :: 		id_slave=master_rx_dat[6];
	MOVF        _master_rx_dat+6, 0 
	MOVWF       _id_slave+0 
;CONCENTRADOR.c,132 :: 		buffer[pbuffer++]=master_rx_dat[6]+48; //unsigned short a caracter ascii
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
;CONCENTRADOR.c,133 :: 		entran+=(unsigned long int)master_rx_dat[0];
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
;CONCENTRADOR.c,134 :: 		entran+=(((unsigned long int)master_rx_dat[1])<<8);
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
;CONCENTRADOR.c,135 :: 		entran+=(((unsigned long int)master_rx_dat[2])<<16);
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
;CONCENTRADOR.c,136 :: 		fbt=1;
	MOVLW       1
	MOVWF       _fbt+0 
;CONCENTRADOR.c,137 :: 		}
	GOTO        L_main12
L_main11:
;CONCENTRADOR.c,138 :: 		else if(fbt==1)
	MOVF        _fbt+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main13
;CONCENTRADOR.c,140 :: 		entran+=(((unsigned long int)master_rx_dat[0])<<24);
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
;CONCENTRADOR.c,141 :: 		salen+=(unsigned long int)master_rx_dat[1];
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
;CONCENTRADOR.c,142 :: 		salen+=(((unsigned long int)master_rx_dat[2])<<8);
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
;CONCENTRADOR.c,143 :: 		fbt=2;
	MOVLW       2
	MOVWF       _fbt+0 
;CONCENTRADOR.c,144 :: 		}
	GOTO        L_main14
L_main13:
;CONCENTRADOR.c,145 :: 		else if(fbt==2)
	MOVF        _fbt+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
;CONCENTRADOR.c,147 :: 		salen+=(((unsigned long int)master_rx_dat[0])<<16);
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
;CONCENTRADOR.c,148 :: 		salen+=(((unsigned long int)master_rx_dat[1])<<24);
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
;CONCENTRADOR.c,149 :: 		bloqueos+=(unsigned long int)master_rx_dat[2];
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
;CONCENTRADOR.c,150 :: 		fbt=3;
	MOVLW       3
	MOVWF       _fbt+0 
;CONCENTRADOR.c,151 :: 		}
	GOTO        L_main16
L_main15:
;CONCENTRADOR.c,152 :: 		else if(fbt==3)
	MOVF        _fbt+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
;CONCENTRADOR.c,154 :: 		bloqueos+=(((unsigned long int)master_rx_dat[1])<<8);
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
;CONCENTRADOR.c,155 :: 		bloqueos+=(((unsigned long int)master_rx_dat[2])<<16);
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
;CONCENTRADOR.c,156 :: 		bloqueos+=(((unsigned long int)master_rx_dat[1])<<24);
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
;CONCENTRADOR.c,157 :: 		fbt=4;
	MOVLW       4
	MOVWF       _fbt+0 
;CONCENTRADOR.c,158 :: 		}
L_main17:
L_main16:
L_main14:
L_main12:
;CONCENTRADOR.c,159 :: 		master_rx_dat[4] = 0; master_rx_dat[6]=0;
	CLRF        _master_rx_dat+4 
	CLRF        _master_rx_dat+6 
;CONCENTRADOR.c,160 :: 		}
L_main10:
;CONCENTRADOR.c,162 :: 		if(fbt==4)
	MOVF        _fbt+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;CONCENTRADOR.c,164 :: 		LED_485=0;
	BCF         PORTA+0, 3 
;CONCENTRADOR.c,165 :: 		LongWordToStrWithZeros(entran,s_entran);
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
;CONCENTRADOR.c,166 :: 		LongWordToStrWithZeros(salen,s_salen);
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
;CONCENTRADOR.c,167 :: 		LongWordToStrWithZeros(bloqueos,s_bloqueos);
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
;CONCENTRADOR.c,168 :: 		buffer[pbuffer++]='E';
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
;CONCENTRADOR.c,169 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_entran[u]; }
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
;CONCENTRADOR.c,170 :: 		buffer[pbuffer++]='S';
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
;CONCENTRADOR.c,171 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_salen[u]; }
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
;CONCENTRADOR.c,172 :: 		buffer[pbuffer++]='B';
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
;CONCENTRADOR.c,173 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_bloqueos[u]; }
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
;CONCENTRADOR.c,174 :: 		buffer[pbuffer++]='V';          //add para vandalismo
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
;CONCENTRADOR.c,175 :: 		buffer[pbuffer++]=vandalismo;   //add para vandalismo
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
;CONCENTRADOR.c,176 :: 		buffer[pbuffer++]='#';
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
;CONCENTRADOR.c,178 :: 		SUart0_RstrNout(buffer,38);             //Transmitir por bluetooth
	MOVLW       _buffer+0
	MOVWF       FARG_SUart0_RstrNout_ptr+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_SUart0_RstrNout_ptr+1 
	MOVLW       38
	MOVWF       FARG_SUart0_RstrNout_n+0 
	CALL        _SUart0_RstrNout+0, 0
;CONCENTRADOR.c,179 :: 		SUart0_write('\r'); SUart0_write('\n'); //add PC salto de linea
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,184 :: 		transmitirGPS(300);                 //ENVIAR POR GV300
	MOVLW       44
	MOVWF       FARG_transmitirGPS_GPS+0 
	MOVLW       1
	MOVWF       FARG_transmitirGPS_GPS+1 
	CALL        _transmitirGPS+0, 0
;CONCENTRADOR.c,186 :: 		fbt=0; pbuffer=0;
	CLRF        _fbt+0 
	CLRF        _pbuffer+0 
;CONCENTRADOR.c,188 :: 		entran=0; salen=0; bloqueos=0;
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
;CONCENTRADOR.c,189 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,192 :: 		cnt1 = cnt2 = 0;
	CLRF        _cnt2+0 
	CLRF        _cnt2+1 
	CLRF        _cnt2+2 
	CLRF        _cnt2+3 
	CLRF        _cnt1+0 
	CLRF        _cnt1+1 
	CLRF        _cnt1+2 
	CLRF        _cnt1+3 
;CONCENTRADOR.c,193 :: 		suma = 0;
	CLRF        _suma+0 
	CLRF        _suma+1 
;CONCENTRADOR.c,194 :: 		reset = 1;
	MOVLW       1
	MOVWF       _reset+0 
	MOVLW       0
	MOVWF       _reset+1 
;CONCENTRADOR.c,196 :: 		}
	GOTO        L_main28
L_main18:
;CONCENTRADOR.c,199 :: 		cnt1++;
	MOVLW       1
	ADDWF       _cnt1+0, 1 
	MOVLW       0
	ADDWFC      _cnt1+1, 1 
	ADDWFC      _cnt1+2, 1 
	ADDWFC      _cnt1+3, 1 
;CONCENTRADOR.c,200 :: 		if(cnt1 > 140000)
	MOVF        _cnt1+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main101
	MOVF        _cnt1+2, 0 
	SUBLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__main101
	MOVF        _cnt1+1, 0 
	SUBLW       34
	BTFSS       STATUS+0, 2 
	GOTO        L__main101
	MOVF        _cnt1+0, 0 
	SUBLW       224
L__main101:
	BTFSC       STATUS+0, 0 
	GOTO        L_main29
;CONCENTRADOR.c,202 :: 		if(esclavo == 10)
	MOVF        _esclavo+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main30
;CONCENTRADOR.c,203 :: 		esclavo_ant = 30;
	MOVLW       30
	MOVWF       _esclavo_ant+0 
	GOTO        L_main31
L_main30:
;CONCENTRADOR.c,204 :: 		else if(esclavo == 20)
	MOVF        _esclavo+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_main32
;CONCENTRADOR.c,205 :: 		esclavo_ant = 10;
	MOVLW       10
	MOVWF       _esclavo_ant+0 
	GOTO        L_main33
L_main32:
;CONCENTRADOR.c,206 :: 		else if(esclavo == 30)
	MOVF        _esclavo+0, 0 
	XORLW       30
	BTFSS       STATUS+0, 2 
	GOTO        L_main34
;CONCENTRADOR.c,207 :: 		esclavo_ant = 20;
	MOVLW       20
	MOVWF       _esclavo_ant+0 
L_main34:
L_main33:
L_main31:
;CONCENTRADOR.c,214 :: 		response[0] = '1';response[1] = sinE1+48;
	MOVLW       49
	MOVWF       _response+0 
	MOVLW       48
	ADDWF       _sinE1+0, 0 
	MOVWF       _response+1 
;CONCENTRADOR.c,215 :: 		response[2] = '2';response[3] = sinE2+48;
	MOVLW       50
	MOVWF       _response+2 
	MOVLW       48
	ADDWF       _sinE2+0, 0 
	MOVWF       _response+3 
;CONCENTRADOR.c,216 :: 		response[4] = '3';response[5] = sinE3+48;
	MOVLW       51
	MOVWF       _response+4 
	MOVLW       48
	ADDWF       _sinE3+0, 0 
	MOVWF       _response+5 
;CONCENTRADOR.c,217 :: 		response[6] = ' ';response[7] = 'S';
	MOVLW       32
	MOVWF       _response+6 
	MOVLW       83
	MOVWF       _response+7 
;CONCENTRADOR.c,218 :: 		response[8] = (esclavo_ant/10)+48;response[9] = ' ';
	MOVLW       10
	MOVWF       R4 
	MOVF        _esclavo_ant+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _response+8 
	MOVLW       32
	MOVWF       _response+9 
;CONCENTRADOR.c,219 :: 		response[10] = cnt2+48;
	MOVLW       48
	ADDWF       _cnt2+0, 0 
	MOVWF       _response+10 
;CONCENTRADOR.c,220 :: 		imprimirMensaje(&response);
	MOVLW       _response+0
	MOVWF       FARG_imprimirMensaje_mensaje+0 
	MOVLW       hi_addr(_response+0)
	MOVWF       FARG_imprimirMensaje_mensaje+1 
	CALL        _imprimirMensaje+0, 0
;CONCENTRADOR.c,222 :: 		cnt1 = 0;
	CLRF        _cnt1+0 
	CLRF        _cnt1+1 
	CLRF        _cnt1+2 
	CLRF        _cnt1+3 
;CONCENTRADOR.c,223 :: 		cnt2++;
	MOVLW       1
	ADDWF       _cnt2+0, 1 
	MOVLW       0
	ADDWFC      _cnt2+1, 1 
	ADDWFC      _cnt2+2, 1 
	ADDWFC      _cnt2+3, 1 
;CONCENTRADOR.c,225 :: 		if(cnt2 > 9)
	MOVF        _cnt2+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main102
	MOVF        _cnt2+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main102
	MOVF        _cnt2+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main102
	MOVF        _cnt2+0, 0 
	SUBLW       9
L__main102:
	BTFSC       STATUS+0, 0 
	GOTO        L_main35
;CONCENTRADOR.c,227 :: 		if(esclavo_ant == 10) //esclavo 10
	MOVF        _esclavo_ant+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
;CONCENTRADOR.c,229 :: 		sinE1++;
	MOVLW       1
	ADDWF       _sinE1+0, 1 
	MOVLW       0
	ADDWFC      _sinE1+1, 1 
	ADDWFC      _sinE1+2, 1 
	ADDWFC      _sinE1+3, 1 
;CONCENTRADOR.c,230 :: 		if(sinE1 > 4)
	MOVF        _sinE1+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main103
	MOVF        _sinE1+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main103
	MOVF        _sinE1+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main103
	MOVF        _sinE1+0, 0 
	SUBLW       4
L__main103:
	BTFSC       STATUS+0, 0 
	GOTO        L_main37
;CONCENTRADOR.c,232 :: 		vandalismo.B1 = 1;
	BSF         _vandalismo+0, 1 
;CONCENTRADOR.c,233 :: 		response[0]='F';response[1]='A';response[2]='L';
	MOVLW       70
	MOVWF       _response+0 
	MOVLW       65
	MOVWF       _response+1 
	MOVLW       76
	MOVWF       _response+2 
;CONCENTRADOR.c,234 :: 		response[3]='L';response[4]='A';response[5]=' ';
	MOVLW       76
	MOVWF       _response+3 
	MOVLW       65
	MOVWF       _response+4 
	MOVLW       32
	MOVWF       _response+5 
;CONCENTRADOR.c,235 :: 		response[6]='E';response[7]='N';response[8]=' ';
	MOVLW       69
	MOVWF       _response+6 
	MOVLW       78
	MOVWF       _response+7 
	MOVLW       32
	MOVWF       _response+8 
;CONCENTRADOR.c,236 :: 		response[9]='S';response[10]=((esclavo_ant/10)+48);
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
;CONCENTRADOR.c,237 :: 		imprimirMensaje(&response);
	MOVLW       _response+0
	MOVWF       FARG_imprimirMensaje_mensaje+0 
	MOVLW       hi_addr(_response+0)
	MOVWF       FARG_imprimirMensaje_mensaje+1 
	CALL        _imprimirMensaje+0, 0
;CONCENTRADOR.c,238 :: 		}
L_main37:
;CONCENTRADOR.c,239 :: 		}
	GOTO        L_main38
L_main36:
;CONCENTRADOR.c,240 :: 		else if(esclavo_ant == 20) //esclavo 20
	MOVF        _esclavo_ant+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_main39
;CONCENTRADOR.c,242 :: 		sinE2++;
	MOVLW       1
	ADDWF       _sinE2+0, 1 
	MOVLW       0
	ADDWFC      _sinE2+1, 1 
	ADDWFC      _sinE2+2, 1 
	ADDWFC      _sinE2+3, 1 
;CONCENTRADOR.c,243 :: 		if(sinE2 > 4)
	MOVF        _sinE2+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main104
	MOVF        _sinE2+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main104
	MOVF        _sinE2+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main104
	MOVF        _sinE2+0, 0 
	SUBLW       4
L__main104:
	BTFSC       STATUS+0, 0 
	GOTO        L_main40
;CONCENTRADOR.c,245 :: 		vandalismo.B2 = 1;
	BSF         _vandalismo+0, 2 
;CONCENTRADOR.c,246 :: 		response[0]='F';response[1]='A';response[2]='L';
	MOVLW       70
	MOVWF       _response+0 
	MOVLW       65
	MOVWF       _response+1 
	MOVLW       76
	MOVWF       _response+2 
;CONCENTRADOR.c,247 :: 		response[3]='L';response[4]='A';response[5]=' ';
	MOVLW       76
	MOVWF       _response+3 
	MOVLW       65
	MOVWF       _response+4 
	MOVLW       32
	MOVWF       _response+5 
;CONCENTRADOR.c,248 :: 		response[6]='E';response[7]='N';response[8]=' ';
	MOVLW       69
	MOVWF       _response+6 
	MOVLW       78
	MOVWF       _response+7 
	MOVLW       32
	MOVWF       _response+8 
;CONCENTRADOR.c,249 :: 		response[9]='S';response[10]=((esclavo_ant/10)+48);
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
;CONCENTRADOR.c,250 :: 		imprimirMensaje(&response);
	MOVLW       _response+0
	MOVWF       FARG_imprimirMensaje_mensaje+0 
	MOVLW       hi_addr(_response+0)
	MOVWF       FARG_imprimirMensaje_mensaje+1 
	CALL        _imprimirMensaje+0, 0
;CONCENTRADOR.c,251 :: 		}
L_main40:
;CONCENTRADOR.c,252 :: 		}
	GOTO        L_main41
L_main39:
;CONCENTRADOR.c,253 :: 		else if(esclavo_ant == 30) //esclavo 30
	MOVF        _esclavo_ant+0, 0 
	XORLW       30
	BTFSS       STATUS+0, 2 
	GOTO        L_main42
;CONCENTRADOR.c,255 :: 		sinE3++;
	MOVLW       1
	ADDWF       _sinE3+0, 1 
	MOVLW       0
	ADDWFC      _sinE3+1, 1 
	ADDWFC      _sinE3+2, 1 
	ADDWFC      _sinE3+3, 1 
;CONCENTRADOR.c,256 :: 		if(sinE3 > 4)
	MOVF        _sinE3+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main105
	MOVF        _sinE3+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main105
	MOVF        _sinE3+1, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main105
	MOVF        _sinE3+0, 0 
	SUBLW       4
L__main105:
	BTFSC       STATUS+0, 0 
	GOTO        L_main43
;CONCENTRADOR.c,258 :: 		vandalismo.B3 = 1;
	BSF         _vandalismo+0, 3 
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
;CONCENTRADOR.c,264 :: 		}
L_main43:
;CONCENTRADOR.c,265 :: 		}
L_main42:
L_main41:
L_main38:
;CONCENTRADOR.c,266 :: 		cnt2=0;
	CLRF        _cnt2+0 
	CLRF        _cnt2+1 
	CLRF        _cnt2+2 
	CLRF        _cnt2+3 
;CONCENTRADOR.c,267 :: 		}
	GOTO        L_main44
L_main35:
;CONCENTRADOR.c,268 :: 		else if(reset)
	MOVF        _reset+0, 0 
	IORWF       _reset+1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_main45
;CONCENTRADOR.c,270 :: 		if(esclavo_ant == 10)
	MOVF        _esclavo_ant+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main46
;CONCENTRADOR.c,272 :: 		sinE1 = 0;
	CLRF        _sinE1+0 
	CLRF        _sinE1+1 
	CLRF        _sinE1+2 
	CLRF        _sinE1+3 
;CONCENTRADOR.c,273 :: 		vandalismo.B1 = 0;
	BCF         _vandalismo+0, 1 
;CONCENTRADOR.c,274 :: 		response[0]='R';response[1]='E';response[2]='S';
	MOVLW       82
	MOVWF       _response+0 
	MOVLW       69
	MOVWF       _response+1 
	MOVLW       83
	MOVWF       _response+2 
;CONCENTRADOR.c,275 :: 		response[3]='E';response[4]='T';response[5]=' ';
	MOVLW       69
	MOVWF       _response+3 
	MOVLW       84
	MOVWF       _response+4 
	MOVLW       32
	MOVWF       _response+5 
;CONCENTRADOR.c,276 :: 		response[6]='S';response[7]=' ';response[8]=' ';
	MOVLW       83
	MOVWF       _response+6 
	MOVLW       32
	MOVWF       _response+7 
	MOVLW       32
	MOVWF       _response+8 
;CONCENTRADOR.c,277 :: 		response[9]=' ';response[10]=((esclavo_ant/10)+48);
	MOVLW       32
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
;CONCENTRADOR.c,279 :: 		}
	GOTO        L_main47
L_main46:
;CONCENTRADOR.c,280 :: 		else if(esclavo_ant == 20)
	MOVF        _esclavo_ant+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_main48
;CONCENTRADOR.c,282 :: 		sinE2 = 0;
	CLRF        _sinE2+0 
	CLRF        _sinE2+1 
	CLRF        _sinE2+2 
	CLRF        _sinE2+3 
;CONCENTRADOR.c,283 :: 		vandalismo.B2 = 0;
	BCF         _vandalismo+0, 2 
;CONCENTRADOR.c,284 :: 		response[0]='R';response[1]='E';response[2]='S';
	MOVLW       82
	MOVWF       _response+0 
	MOVLW       69
	MOVWF       _response+1 
	MOVLW       83
	MOVWF       _response+2 
;CONCENTRADOR.c,285 :: 		response[3]='E';response[4]='T';response[5]=' ';
	MOVLW       69
	MOVWF       _response+3 
	MOVLW       84
	MOVWF       _response+4 
	MOVLW       32
	MOVWF       _response+5 
;CONCENTRADOR.c,286 :: 		response[6]='S';response[7]=' ';response[8]=' ';
	MOVLW       83
	MOVWF       _response+6 
	MOVLW       32
	MOVWF       _response+7 
	MOVLW       32
	MOVWF       _response+8 
;CONCENTRADOR.c,287 :: 		response[9]=' ';response[10]=((esclavo_ant/10)+48);
	MOVLW       32
	MOVWF       _response+9 
	MOVLW       10
	MOVWF       R4 
	MOVF        _esclavo_ant+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _response+10 
;CONCENTRADOR.c,288 :: 		imprimirMensaje(&response);
	MOVLW       _response+0
	MOVWF       FARG_imprimirMensaje_mensaje+0 
	MOVLW       hi_addr(_response+0)
	MOVWF       FARG_imprimirMensaje_mensaje+1 
	CALL        _imprimirMensaje+0, 0
;CONCENTRADOR.c,289 :: 		}
	GOTO        L_main49
L_main48:
;CONCENTRADOR.c,290 :: 		else if(esclavo_ant == 30)
	MOVF        _esclavo_ant+0, 0 
	XORLW       30
	BTFSS       STATUS+0, 2 
	GOTO        L_main50
;CONCENTRADOR.c,292 :: 		sinE3 = 0;
	CLRF        _sinE3+0 
	CLRF        _sinE3+1 
	CLRF        _sinE3+2 
	CLRF        _sinE3+3 
;CONCENTRADOR.c,293 :: 		vandalismo.B3 = 0;
	BCF         _vandalismo+0, 3 
;CONCENTRADOR.c,294 :: 		response[0]='R';response[1]='E';response[2]='S';
	MOVLW       82
	MOVWF       _response+0 
	MOVLW       69
	MOVWF       _response+1 
	MOVLW       83
	MOVWF       _response+2 
;CONCENTRADOR.c,295 :: 		response[3]='E';response[4]='T';response[5]=' ';
	MOVLW       69
	MOVWF       _response+3 
	MOVLW       84
	MOVWF       _response+4 
	MOVLW       32
	MOVWF       _response+5 
;CONCENTRADOR.c,296 :: 		response[6]='S';response[7]=' ';response[8]=' ';
	MOVLW       83
	MOVWF       _response+6 
	MOVLW       32
	MOVWF       _response+7 
	MOVLW       32
	MOVWF       _response+8 
;CONCENTRADOR.c,297 :: 		response[9]=' ';response[10]=((esclavo_ant/10)+48);
	MOVLW       32
	MOVWF       _response+9 
	MOVLW       10
	MOVWF       R4 
	MOVF        _esclavo_ant+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       _response+10 
;CONCENTRADOR.c,298 :: 		imprimirMensaje(&response);
	MOVLW       _response+0
	MOVWF       FARG_imprimirMensaje_mensaje+0 
	MOVLW       hi_addr(_response+0)
	MOVWF       FARG_imprimirMensaje_mensaje+1 
	CALL        _imprimirMensaje+0, 0
;CONCENTRADOR.c,299 :: 		}
L_main50:
L_main49:
L_main47:
;CONCENTRADOR.c,300 :: 		reset = 0;
	CLRF        _reset+0 
	CLRF        _reset+1 
;CONCENTRADOR.c,301 :: 		}
L_main45:
L_main44:
;CONCENTRADOR.c,302 :: 		}
L_main29:
;CONCENTRADOR.c,303 :: 		}
L_main28:
;CONCENTRADOR.c,314 :: 		counter2++;
	MOVLW       1
	ADDWF       _counter2+0, 1 
	MOVLW       0
	ADDWFC      _counter2+1, 1 
	ADDWFC      _counter2+2, 1 
	ADDWFC      _counter2+3, 1 
;CONCENTRADOR.c,315 :: 		if(counter2>(140000*10))
	MOVF        _counter2+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main106
	MOVF        _counter2+2, 0 
	SUBLW       21
	BTFSS       STATUS+0, 2 
	GOTO        L__main106
	MOVF        _counter2+1, 0 
	SUBLW       92
	BTFSS       STATUS+0, 2 
	GOTO        L__main106
	MOVF        _counter2+0, 0 
	SUBLW       192
L__main106:
	BTFSC       STATUS+0, 0 
	GOTO        L_main51
;CONCENTRADOR.c,317 :: 		counter2=0;
	CLRF        _counter2+0 
	CLRF        _counter2+1 
	CLRF        _counter2+2 
	CLRF        _counter2+3 
;CONCENTRADOR.c,322 :: 		response[0] = 'E';response[1] = 'S';response[2] = 'C';response[3] = 'L';
	MOVLW       69
	MOVWF       _response+0 
	MOVLW       83
	MOVWF       _response+1 
	MOVLW       67
	MOVWF       _response+2 
	MOVLW       76
	MOVWF       _response+3 
;CONCENTRADOR.c,323 :: 		response[4] = 'A';response[5] = 'V';response[6] = 'O';response[7] = ' ';
	MOVLW       65
	MOVWF       _response+4 
	MOVLW       86
	MOVWF       _response+5 
	MOVLW       79
	MOVWF       _response+6 
	MOVLW       32
	MOVWF       _response+7 
;CONCENTRADOR.c,324 :: 		response[8] = '>';response[9] = ' ';response[10] = ((esclavo/10)+48);
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
;CONCENTRADOR.c,325 :: 		imprimirMensaje(&response);
	MOVLW       _response+0
	MOVWF       FARG_imprimirMensaje_mensaje+0 
	MOVLW       hi_addr(_response+0)
	MOVWF       FARG_imprimirMensaje_mensaje+1 
	CALL        _imprimirMensaje+0, 0
;CONCENTRADOR.c,326 :: 		peticion(esclavo);              //pedido de información al esclavo
	MOVF        _esclavo+0, 0 
	MOVWF       FARG_peticion_dirEsclavo+0 
	CALL        _peticion+0, 0
;CONCENTRADOR.c,327 :: 		esclavo += 10;                  //incrementar direccion de esclavo
	MOVLW       10
	ADDWF       _esclavo+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _esclavo+0 
;CONCENTRADOR.c,328 :: 		if(esclavo > 30){esclavo = 10;} //control desborde de esclavos
	MOVF        R1, 0 
	SUBLW       30
	BTFSC       STATUS+0, 0 
	GOTO        L_main52
	MOVLW       10
	MOVWF       _esclavo+0 
L_main52:
;CONCENTRADOR.c,329 :: 		}
L_main51:
;CONCENTRADOR.c,337 :: 		counter1++;
	MOVLW       1
	ADDWF       _counter1+0, 1 
	MOVLW       0
	ADDWFC      _counter1+1, 1 
	ADDWFC      _counter1+2, 1 
	ADDWFC      _counter1+3, 1 
;CONCENTRADOR.c,338 :: 		if(counter1>(140000*10))
	MOVF        _counter1+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main107
	MOVF        _counter1+2, 0 
	SUBLW       21
	BTFSS       STATUS+0, 2 
	GOTO        L__main107
	MOVF        _counter1+1, 0 
	SUBLW       92
	BTFSS       STATUS+0, 2 
	GOTO        L__main107
	MOVF        _counter1+0, 0 
	SUBLW       192
L__main107:
	BTFSC       STATUS+0, 0 
	GOTO        L_main53
;CONCENTRADOR.c,340 :: 		counter1=0;
	CLRF        _counter1+0 
	CLRF        _counter1+1 
	CLRF        _counter1+2 
	CLRF        _counter1+3 
;CONCENTRADOR.c,342 :: 		}
L_main53:
;CONCENTRADOR.c,349 :: 		if(SWITCH_ON)
	BTFSS       PORTC+0, 0 
	GOTO        L_main54
;CONCENTRADOR.c,351 :: 		seg_off++;
	MOVLW       1
	ADDWF       _seg_off+0, 1 
	MOVLW       0
	ADDWFC      _seg_off+1, 1 
	ADDWFC      _seg_off+2, 1 
	ADDWFC      _seg_off+3, 1 
;CONCENTRADOR.c,356 :: 		if((seg_off > (54026 * 10)) && DS_FUENTE == 0)
	MOVF        _seg_off+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main108
	MOVF        _seg_off+2, 0 
	SUBLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L__main108
	MOVF        _seg_off+1, 0 
	SUBLW       62
	BTFSS       STATUS+0, 2 
	GOTO        L__main108
	MOVF        _seg_off+0, 0 
	SUBLW       100
L__main108:
	BTFSC       STATUS+0, 0 
	GOTO        L_main57
	BTFSC       PORTB+0, 5 
	GOTO        L_main57
L__main95:
;CONCENTRADOR.c,358 :: 		seg_off = 0;
	CLRF        _seg_off+0 
	CLRF        _seg_off+1 
	CLRF        _seg_off+2 
	CLRF        _seg_off+3 
;CONCENTRADOR.c,359 :: 		DS_FUENTE = 1;
	BSF         PORTB+0, 5 
;CONCENTRADOR.c,360 :: 		SUart0_write('O');  SUart0_write('F'); SUart0_write('F'); //off
	MOVLW       79
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       70
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       70
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,361 :: 		SUart0_write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,362 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,363 :: 		}
L_main57:
;CONCENTRADOR.c,365 :: 		}
	GOTO        L_main58
L_main54:
;CONCENTRADOR.c,368 :: 		seg_off = 0;
	CLRF        _seg_off+0 
	CLRF        _seg_off+1 
	CLRF        _seg_off+2 
	CLRF        _seg_off+3 
;CONCENTRADOR.c,369 :: 		DS_FUENTE = 0;
	BCF         PORTB+0, 5 
;CONCENTRADOR.c,370 :: 		}
L_main58:
;CONCENTRADOR.c,371 :: 		}
	GOTO        L_main2
;CONCENTRADOR.c,372 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_imprimirAlerta:

;CONCENTRADOR.c,380 :: 		void imprimirAlerta(char lugar)
;CONCENTRADOR.c,382 :: 		SUart0_write(lugar);
	MOVF        FARG_imprimirAlerta_lugar+0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,383 :: 		SUart0_write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,384 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,385 :: 		}
L_end_imprimirAlerta:
	RETURN      0
; end of _imprimirAlerta

_imprimirMensaje:

;CONCENTRADOR.c,386 :: 		void imprimirMensaje(char mensaje[11])
;CONCENTRADOR.c,388 :: 		int u = 0;
	CLRF        imprimirMensaje_u_L0+0 
	CLRF        imprimirMensaje_u_L0+1 
;CONCENTRADOR.c,389 :: 		for(u = 0; u < 11; u++)
	CLRF        imprimirMensaje_u_L0+0 
	CLRF        imprimirMensaje_u_L0+1 
L_imprimirMensaje59:
	MOVLW       128
	XORWF       imprimirMensaje_u_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__imprimirMensaje111
	MOVLW       11
	SUBWF       imprimirMensaje_u_L0+0, 0 
L__imprimirMensaje111:
	BTFSC       STATUS+0, 0 
	GOTO        L_imprimirMensaje60
;CONCENTRADOR.c,391 :: 		SUart0_write(mensaje[u]);
	MOVF        imprimirMensaje_u_L0+0, 0 
	ADDWF       FARG_imprimirMensaje_mensaje+0, 0 
	MOVWF       FSR0 
	MOVF        imprimirMensaje_u_L0+1, 0 
	ADDWFC      FARG_imprimirMensaje_mensaje+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,389 :: 		for(u = 0; u < 11; u++)
	INFSNZ      imprimirMensaje_u_L0+0, 1 
	INCF        imprimirMensaje_u_L0+1, 1 
;CONCENTRADOR.c,392 :: 		}
	GOTO        L_imprimirMensaje59
L_imprimirMensaje60:
;CONCENTRADOR.c,393 :: 		SUart0_write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,394 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,395 :: 		}
L_end_imprimirMensaje:
	RETURN      0
; end of _imprimirMensaje

_peticion:

;CONCENTRADOR.c,407 :: 		void peticion(char dirEsclavo)
;CONCENTRADOR.c,409 :: 		dat[0] = 0xFF;
	MOVLW       255
	MOVWF       _dat+0 
;CONCENTRADOR.c,410 :: 		dat[1] = 0xFF;
	MOVLW       255
	MOVWF       _dat+1 
;CONCENTRADOR.c,411 :: 		dat[2] = 0xFF;
	MOVLW       255
	MOVWF       _dat+2 
;CONCENTRADOR.c,412 :: 		dat[4] = 0;
	CLRF        _dat+4 
;CONCENTRADOR.c,413 :: 		dat[5] = 0;
	CLRF        _dat+5 
;CONCENTRADOR.c,414 :: 		dat[6] = 0;
	CLRF        _dat+6 
;CONCENTRADOR.c,415 :: 		RS485Master_Send(dat,1,dirEsclavo);
	MOVLW       _dat+0
	MOVWF       FARG_RS485Master_Send_data_buffer+0 
	MOVLW       hi_addr(_dat+0)
	MOVWF       FARG_RS485Master_Send_data_buffer+1 
	MOVLW       1
	MOVWF       FARG_RS485Master_Send_datalen+0 
	MOVF        FARG_peticion_dirEsclavo+0, 0 
	MOVWF       FARG_RS485Master_Send_slave_address+0 
	CALL        _RS485Master_Send+0, 0
;CONCENTRADOR.c,416 :: 		delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_peticion62:
	DECFSZ      R13, 1, 1
	BRA         L_peticion62
	DECFSZ      R12, 1, 1
	BRA         L_peticion62
;CONCENTRADOR.c,417 :: 		}
L_end_peticion:
	RETURN      0
; end of _peticion

_buildBuf600:

;CONCENTRADOR.c,427 :: 		void buildBuf600()
;CONCENTRADOR.c,429 :: 		if(id_slave == 10)
	MOVF        _id_slave+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_buildBuf60063
;CONCENTRADOR.c,431 :: 		for(u=3;u<10;u++){ ee1[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_buildBuf60064:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_buildBuf60065
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
	GOTO        L_buildBuf60064
L_buildBuf60065:
;CONCENTRADOR.c,432 :: 		}
L_buildBuf60063:
;CONCENTRADOR.c,433 :: 		if(id_slave == 20)
	MOVF        _id_slave+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_buildBuf60067
;CONCENTRADOR.c,435 :: 		for(u=3;u<10;u++){ ee2[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_buildBuf60068:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_buildBuf60069
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
	GOTO        L_buildBuf60068
L_buildBuf60069:
;CONCENTRADOR.c,436 :: 		}
L_buildBuf60067:
;CONCENTRADOR.c,437 :: 		if(id_slave == 30)
	MOVF        _id_slave+0, 0 
	XORLW       30
	BTFSS       STATUS+0, 2 
	GOTO        L_buildBuf60071
;CONCENTRADOR.c,439 :: 		for(u=3;u<10;u++){ ee3[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_buildBuf60072:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_buildBuf60073
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
	GOTO        L_buildBuf60072
L_buildBuf60073:
;CONCENTRADOR.c,440 :: 		}
L_buildBuf60071:
;CONCENTRADOR.c,441 :: 		}
L_end_buildBuf600:
	RETURN      0
; end of _buildBuf600

_transmitirGPS:

;CONCENTRADOR.c,454 :: 		void transmitirGPS(int GPS)
;CONCENTRADOR.c,456 :: 		if(GPS == 300)      // PARA GV300
	MOVF        FARG_transmitirGPS_GPS+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__transmitirGPS115
	MOVLW       44
	XORWF       FARG_transmitirGPS_GPS+0, 0 
L__transmitirGPS115:
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS75
;CONCENTRADOR.c,458 :: 		for(u=0;u<38;u++) //modificado de 36 a 38
	CLRF        _u+0 
L_transmitirGPS76:
	MOVLW       38
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS77
;CONCENTRADOR.c,460 :: 		Suart2_write((char)buffer[u]); //TX por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,458 :: 		for(u=0;u<38;u++) //modificado de 36 a 38
	INCF        _u+0, 1 
;CONCENTRADOR.c,461 :: 		}
	GOTO        L_transmitirGPS76
L_transmitirGPS77:
;CONCENTRADOR.c,462 :: 		}
	GOTO        L_transmitirGPS79
L_transmitirGPS75:
;CONCENTRADOR.c,464 :: 		else if(GPS == 600) // PARA MVT600
	MOVF        FARG_transmitirGPS_GPS+1, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__transmitirGPS116
	MOVLW       88
	XORWF       FARG_transmitirGPS_GPS+0, 0 
L__transmitirGPS116:
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS80
;CONCENTRADOR.c,466 :: 		if(ax==0)
	MOVF        _ax+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS81
;CONCENTRADOR.c,468 :: 		ax = 1;
	MOVLW       1
	MOVWF       _ax+0 
;CONCENTRADOR.c,469 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_transmitirGPS82:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS83
;CONCENTRADOR.c,471 :: 		Suart2_write((char)ee1[u]); //TX por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,469 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,472 :: 		}
	GOTO        L_transmitirGPS82
L_transmitirGPS83:
;CONCENTRADOR.c,473 :: 		}
	GOTO        L_transmitirGPS85
L_transmitirGPS81:
;CONCENTRADOR.c,474 :: 		else if (ax == 1)
	MOVF        _ax+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS86
;CONCENTRADOR.c,476 :: 		ax = 2;
	MOVLW       2
	MOVWF       _ax+0 
;CONCENTRADOR.c,477 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_transmitirGPS87:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS88
;CONCENTRADOR.c,479 :: 		Suart2_write((char)ee2[u]); //TX por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,477 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,480 :: 		}
	GOTO        L_transmitirGPS87
L_transmitirGPS88:
;CONCENTRADOR.c,481 :: 		}
	GOTO        L_transmitirGPS90
L_transmitirGPS86:
;CONCENTRADOR.c,482 :: 		else if (ax == 2)
	MOVF        _ax+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_transmitirGPS91
;CONCENTRADOR.c,484 :: 		ax = 0;
	CLRF        _ax+0 
;CONCENTRADOR.c,485 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_transmitirGPS92:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_transmitirGPS93
;CONCENTRADOR.c,487 :: 		Suart2_write((char)ee3[u]); //TX por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,485 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,488 :: 		}
	GOTO        L_transmitirGPS92
L_transmitirGPS93:
;CONCENTRADOR.c,489 :: 		}
L_transmitirGPS91:
L_transmitirGPS90:
L_transmitirGPS85:
;CONCENTRADOR.c,490 :: 		}
L_transmitirGPS80:
L_transmitirGPS79:
;CONCENTRADOR.c,491 :: 		}
L_end_transmitirGPS:
	RETURN      0
; end of _transmitirGPS
