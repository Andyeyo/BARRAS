
_imprimirAlerta:

;CONCENTRADOR.c,51 :: 		void imprimirAlerta(char lugar)
;CONCENTRADOR.c,54 :: 		SUart0_write(lugar);
	MOVF        FARG_imprimirAlerta_lugar+0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,55 :: 		SUart0_write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,56 :: 		SUart0_write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,57 :: 		}
L_end_imprimirAlerta:
	RETURN      0
; end of _imprimirAlerta

_peticion:

;CONCENTRADOR.c,60 :: 		void peticion(char dirEsclavo)
;CONCENTRADOR.c,62 :: 		dat[0] = 0xFF;
	MOVLW       255
	MOVWF       _dat+0 
;CONCENTRADOR.c,63 :: 		dat[1] = 0xFF;
	MOVLW       255
	MOVWF       _dat+1 
;CONCENTRADOR.c,64 :: 		dat[2] = 0xFF;
	MOVLW       255
	MOVWF       _dat+2 
;CONCENTRADOR.c,65 :: 		dat[4] = 0;
	CLRF        _dat+4 
;CONCENTRADOR.c,66 :: 		dat[5] = 0;
	CLRF        _dat+5 
;CONCENTRADOR.c,67 :: 		dat[6] = 0;
	CLRF        _dat+6 
;CONCENTRADOR.c,68 :: 		RS485Master_Send(dat,1,dirEsclavo);
	MOVLW       _dat+0
	MOVWF       FARG_RS485Master_Send_data_buffer+0 
	MOVLW       hi_addr(_dat+0)
	MOVWF       FARG_RS485Master_Send_data_buffer+1 
	MOVLW       1
	MOVWF       FARG_RS485Master_Send_datalen+0 
	MOVF        FARG_peticion_dirEsclavo+0, 0 
	MOVWF       FARG_RS485Master_Send_slave_address+0 
	CALL        _RS485Master_Send+0, 0
;CONCENTRADOR.c,69 :: 		delay_ms(1);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_peticion0:
	DECFSZ      R13, 1, 1
	BRA         L_peticion0
	DECFSZ      R12, 1, 1
	BRA         L_peticion0
;CONCENTRADOR.c,70 :: 		}
L_end_peticion:
	RETURN      0
; end of _peticion

_interrupt:

;CONCENTRADOR.c,73 :: 		void interrupt()
;CONCENTRADOR.c,75 :: 		RS485Master_Receive(master_rx_dat);
	MOVLW       _master_rx_dat+0
	MOVWF       FARG_RS485Master_Receive_data_buffer+0 
	MOVLW       hi_addr(_master_rx_dat+0)
	MOVWF       FARG_RS485Master_Receive_data_buffer+1 
	CALL        _RS485Master_Receive+0, 0
;CONCENTRADOR.c,76 :: 		}
L_end_interrupt:
L__interrupt60:
	RETFIE      1
; end of _interrupt

_main:

;CONCENTRADOR.c,79 :: 		void main()
;CONCENTRADOR.c,82 :: 		ADCON1= 0b00001111; // Configure AN pins as digital I/O
	MOVLW       15
	MOVWF       ADCON1+0 
;CONCENTRADOR.c,83 :: 		CMCON = 0b00000111; // Disable comparators
	MOVLW       7
	MOVWF       CMCON+0 
;CONCENTRADOR.c,84 :: 		TRISA.RA3=0; TRISA.RA4=0;
	BCF         TRISA+0, 3 
	BCF         TRISA+0, 4 
;CONCENTRADOR.c,85 :: 		PORTA.RA3=0; PORTA.RA4=0;
	BCF         PORTA+0, 3 
	BCF         PORTA+0, 4 
;CONCENTRADOR.c,86 :: 		SUart0_Init_T();
	CALL        _SUart0_Init_T+0, 0
;CONCENTRADOR.c,87 :: 		SUart2_Init_T();
	CALL        _SUart2_Init_T+0, 0
;CONCENTRADOR.c,89 :: 		TRISC.RC0 = 1;    //add PC para lectura del SW_ON
	BSF         TRISC+0, 0 
;CONCENTRADOR.c,90 :: 		PORTC.RC0 = 0;
	BCF         PORTC+0, 0 
;CONCENTRADOR.c,91 :: 		TRISB.RB5 = 0;
	BCF         TRISB+0, 5 
;CONCENTRADOR.c,92 :: 		PORTB.RB5 = 0;
	BCF         PORTB+0, 5 
;CONCENTRADOR.c,95 :: 		UART1_Init(9600); Delay_ms(100);                    // initialize UART1 module
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
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
	NOP
;CONCENTRADOR.c,96 :: 		RS485Master_Init(); Delay_ms(100);                  // initialize MCU as Master
	CALL        _RS485Master_Init+0, 0
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;CONCENTRADOR.c,97 :: 		RCIE_bit = 1;                        // enable interrupt on UART1 receive
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;CONCENTRADOR.c,98 :: 		TXIE_bit = 0;                        // disable interrupt on UART1 transmit
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;CONCENTRADOR.c,99 :: 		PEIE_bit = 1;                        // enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;CONCENTRADOR.c,100 :: 		GIE_bit = 1;                         // enable all interrupts
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;CONCENTRADOR.c,102 :: 		peticion(esclavo);
	MOVF        _esclavo+0, 0 
	MOVWF       FARG_peticion_dirEsclavo+0 
	CALL        _peticion+0, 0
;CONCENTRADOR.c,104 :: 		while(1)
L_main3:
;CONCENTRADOR.c,107 :: 		if (master_rx_dat[5])
	MOVF        _master_rx_dat+5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;CONCENTRADOR.c,109 :: 		LED_TTR=1;
	BSF         PORTA+0, 4 
;CONCENTRADOR.c,110 :: 		Delay_ms(10);
	MOVLW       65
	MOVWF       R12, 0
	MOVLW       238
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	NOP
;CONCENTRADOR.c,111 :: 		LED_TTR=0;
	BCF         PORTA+0, 4 
;CONCENTRADOR.c,112 :: 		master_rx_dat[5]=0;
	CLRF        _master_rx_dat+5 
;CONCENTRADOR.c,113 :: 		master_rx_dat[4]=0;
	CLRF        _master_rx_dat+4 
;CONCENTRADOR.c,114 :: 		}
L_main5:
;CONCENTRADOR.c,117 :: 		if(fbt>0)
	MOVF        _fbt+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;CONCENTRADOR.c,119 :: 		cnt++;
	MOVLW       1
	ADDWF       _cnt+0, 1 
	MOVLW       0
	ADDWFC      _cnt+1, 1 
	ADDWFC      _cnt+2, 1 
	ADDWFC      _cnt+3, 1 
;CONCENTRADOR.c,120 :: 		}
L_main7:
;CONCENTRADOR.c,122 :: 		if(cnt>14000*1){ //modificado, valor original 14000 * 100
	MOVF        _cnt+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main62
	MOVF        _cnt+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main62
	MOVF        _cnt+1, 0 
	SUBLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L__main62
	MOVF        _cnt+0, 0 
	SUBLW       176
L__main62:
	BTFSC       STATUS+0, 0 
	GOTO        L_main8
;CONCENTRADOR.c,123 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,124 :: 		fbt=0;
	CLRF        _fbt+0 
;CONCENTRADOR.c,125 :: 		LED_485=0;
	BCF         PORTA+0, 3 
;CONCENTRADOR.c,126 :: 		pbuffer=0;
	CLRF        _pbuffer+0 
;CONCENTRADOR.c,127 :: 		entran=0; salen=0; bloqueos=0;
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
;CONCENTRADOR.c,129 :: 		imprimirAlerta('R'); //addPC
	MOVLW       82
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,130 :: 		}
L_main8:
;CONCENTRADOR.c,133 :: 		if (master_rx_dat[4] && !master_rx_dat[5])
	MOVF        _master_rx_dat+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        _master_rx_dat+5, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main11
L__main56:
;CONCENTRADOR.c,135 :: 		if(fbt==0){
	MOVF        _fbt+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main12
;CONCENTRADOR.c,136 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,137 :: 		entran=0;
	CLRF        _entran+0 
	CLRF        _entran+1 
	CLRF        _entran+2 
	CLRF        _entran+3 
;CONCENTRADOR.c,138 :: 		LED_485=1;
	BSF         PORTA+0, 3 
;CONCENTRADOR.c,139 :: 		buffer[pbuffer++]='i';
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
;CONCENTRADOR.c,140 :: 		id_slave=master_rx_dat[6];
	MOVF        _master_rx_dat+6, 0 
	MOVWF       _id_slave+0 
;CONCENTRADOR.c,141 :: 		buffer[pbuffer++]=master_rx_dat[6]+48; //convert unsigned short to ascii char
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
;CONCENTRADOR.c,142 :: 		entran+=(unsigned long int)master_rx_dat[0];
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
;CONCENTRADOR.c,143 :: 		entran+=(((unsigned long int)master_rx_dat[1])<<8);
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
;CONCENTRADOR.c,144 :: 		entran+=(((unsigned long int)master_rx_dat[2])<<16);
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
;CONCENTRADOR.c,145 :: 		fbt=1;
	MOVLW       1
	MOVWF       _fbt+0 
;CONCENTRADOR.c,146 :: 		}
	GOTO        L_main13
L_main12:
;CONCENTRADOR.c,147 :: 		else if(fbt==1){
	MOVF        _fbt+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
;CONCENTRADOR.c,148 :: 		entran+=(((unsigned long int)master_rx_dat[0])<<24);
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
;CONCENTRADOR.c,149 :: 		salen+=(unsigned long int)master_rx_dat[1];
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
;CONCENTRADOR.c,150 :: 		salen+=(((unsigned long int)master_rx_dat[2])<<8);
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
;CONCENTRADOR.c,151 :: 		fbt=2;
	MOVLW       2
	MOVWF       _fbt+0 
;CONCENTRADOR.c,152 :: 		}
	GOTO        L_main15
L_main14:
;CONCENTRADOR.c,153 :: 		else if(fbt==2){
	MOVF        _fbt+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
;CONCENTRADOR.c,154 :: 		salen+=(((unsigned long int)master_rx_dat[0])<<16);
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
;CONCENTRADOR.c,155 :: 		salen+=(((unsigned long int)master_rx_dat[1])<<24);
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
;CONCENTRADOR.c,156 :: 		bloqueos+=(unsigned long int)master_rx_dat[2];
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
;CONCENTRADOR.c,157 :: 		fbt=3;          //cambiado original 3
	MOVLW       3
	MOVWF       _fbt+0 
;CONCENTRADOR.c,158 :: 		}
	GOTO        L_main17
L_main16:
;CONCENTRADOR.c,159 :: 		else if(fbt==3){
	MOVF        _fbt+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_main18
;CONCENTRADOR.c,160 :: 		bloqueos+=(((unsigned long int)master_rx_dat[1])<<8);
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
;CONCENTRADOR.c,161 :: 		bloqueos+=(((unsigned long int)master_rx_dat[2])<<16);
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
;CONCENTRADOR.c,162 :: 		bloqueos+=(((unsigned long int)master_rx_dat[1])<<24);
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
;CONCENTRADOR.c,163 :: 		fbt=4;
	MOVLW       4
	MOVWF       _fbt+0 
;CONCENTRADOR.c,164 :: 		}
L_main18:
L_main17:
L_main15:
L_main13:
;CONCENTRADOR.c,165 :: 		master_rx_dat[4] = 0; master_rx_dat[6]=0;
	CLRF        _master_rx_dat+4 
	CLRF        _master_rx_dat+6 
;CONCENTRADOR.c,166 :: 		}
L_main11:
;CONCENTRADOR.c,168 :: 		if(fbt==4)
	MOVF        _fbt+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_main19
;CONCENTRADOR.c,170 :: 		LED_485=0;
	BCF         PORTA+0, 3 
;CONCENTRADOR.c,171 :: 		LongWordToStrWithZeros(entran,s_entran);
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
;CONCENTRADOR.c,172 :: 		LongWordToStrWithZeros(salen,s_salen);
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
;CONCENTRADOR.c,173 :: 		LongWordToStrWithZeros(bloqueos,s_bloqueos);
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
;CONCENTRADOR.c,174 :: 		buffer[pbuffer++]='E';
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
;CONCENTRADOR.c,175 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_entran[u]; }
	CLRF        _u+0 
L_main20:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main21
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
	GOTO        L_main20
L_main21:
;CONCENTRADOR.c,176 :: 		buffer[pbuffer++]='S';
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
;CONCENTRADOR.c,177 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_salen[u]; }
	CLRF        _u+0 
L_main23:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main24
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
	GOTO        L_main23
L_main24:
;CONCENTRADOR.c,178 :: 		buffer[pbuffer++]='B';
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
;CONCENTRADOR.c,179 :: 		for(u=0;u<10;u++){ buffer[pbuffer++]=s_bloqueos[u]; }
	CLRF        _u+0 
L_main26:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main27
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
	GOTO        L_main26
L_main27:
;CONCENTRADOR.c,180 :: 		buffer[pbuffer++]='#';
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
;CONCENTRADOR.c,181 :: 		SUart0_RstrNout(buffer,36);       //------------envio por bluetooth
	MOVLW       _buffer+0
	MOVWF       FARG_SUart0_RstrNout_ptr+0 
	MOVLW       hi_addr(_buffer+0)
	MOVWF       FARG_SUart0_RstrNout_ptr+1 
	MOVLW       36
	MOVWF       FARG_SUart0_RstrNout_n+0 
	CALL        _SUart0_RstrNout+0, 0
;CONCENTRADOR.c,183 :: 		SUart0_write('\r');  //add PC
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,184 :: 		SUart0_write('\n');  //add PC
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,187 :: 		if(id_slave == 10)
	MOVF        _id_slave+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_main29
;CONCENTRADOR.c,189 :: 		for(u=3;u<10;u++){ ee1[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_main30:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main31
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
	GOTO        L_main30
L_main31:
;CONCENTRADOR.c,190 :: 		}
L_main29:
;CONCENTRADOR.c,191 :: 		if(id_slave == 20)
	MOVF        _id_slave+0, 0 
	XORLW       20
	BTFSS       STATUS+0, 2 
	GOTO        L_main33
;CONCENTRADOR.c,193 :: 		for(u=3;u<10;u++){ ee2[11+u]=s_entran[u]; }
	MOVLW       3
	MOVWF       _u+0 
L_main34:
	MOVLW       10
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main35
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
	GOTO        L_main34
L_main35:
;CONCENTRADOR.c,194 :: 		}
L_main33:
;CONCENTRADOR.c,196 :: 		fbt=0; pbuffer=0;
	CLRF        _fbt+0 
	CLRF        _pbuffer+0 
;CONCENTRADOR.c,198 :: 		entran=0; salen=0; bloqueos=0;
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
;CONCENTRADOR.c,199 :: 		cnt=0;
	CLRF        _cnt+0 
	CLRF        _cnt+1 
	CLRF        _cnt+2 
	CLRF        _cnt+3 
;CONCENTRADOR.c,200 :: 		}
L_main19:
;CONCENTRADOR.c,203 :: 		counter2++;
	MOVLW       1
	ADDWF       _counter2+0, 1 
	MOVLW       0
	ADDWFC      _counter2+1, 1 
	ADDWFC      _counter2+2, 1 
	ADDWFC      _counter2+3, 1 
;CONCENTRADOR.c,204 :: 		if(counter2>(14000*20))
	MOVF        _counter2+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main63
	MOVF        _counter2+2, 0 
	SUBLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L__main63
	MOVF        _counter2+1, 0 
	SUBLW       69
	BTFSS       STATUS+0, 2 
	GOTO        L__main63
	MOVF        _counter2+0, 0 
	SUBLW       192
L__main63:
	BTFSC       STATUS+0, 0 
	GOTO        L_main37
;CONCENTRADOR.c,206 :: 		counter2=0;
	CLRF        _counter2+0 
	CLRF        _counter2+1 
	CLRF        _counter2+2 
	CLRF        _counter2+3 
;CONCENTRADOR.c,207 :: 		if(ax==0)
	MOVF        _ax+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main38
;CONCENTRADOR.c,209 :: 		ax=1;
	MOVLW       1
	MOVWF       _ax+0 
;CONCENTRADOR.c,210 :: 		}
	GOTO        L_main39
L_main38:
;CONCENTRADOR.c,213 :: 		ax=0;
	CLRF        _ax+0 
;CONCENTRADOR.c,214 :: 		}
L_main39:
;CONCENTRADOR.c,217 :: 		imprimirAlerta((esclavo/10)+48);
	MOVLW       10
	MOVWF       R4 
	MOVF        _esclavo+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_imprimirAlerta_lugar+0 
	CALL        _imprimirAlerta+0, 0
;CONCENTRADOR.c,218 :: 		peticion(esclavo); //pedido de envio de información
	MOVF        _esclavo+0, 0 
	MOVWF       FARG_peticion_dirEsclavo+0 
	CALL        _peticion+0, 0
;CONCENTRADOR.c,219 :: 		esclavo += 10;
	MOVLW       10
	ADDWF       _esclavo+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _esclavo+0 
;CONCENTRADOR.c,220 :: 		if(esclavo > 30)
	MOVF        R1, 0 
	SUBLW       30
	BTFSC       STATUS+0, 0 
	GOTO        L_main40
;CONCENTRADOR.c,222 :: 		esclavo = 10;
	MOVLW       10
	MOVWF       _esclavo+0 
;CONCENTRADOR.c,223 :: 		}
L_main40:
;CONCENTRADOR.c,225 :: 		}
L_main37:
;CONCENTRADOR.c,227 :: 		counter1++;
	MOVLW       1
	ADDWF       _counter1+0, 1 
	MOVLW       0
	ADDWFC      _counter1+1, 1 
	ADDWFC      _counter1+2, 1 
	ADDWFC      _counter1+3, 1 
;CONCENTRADOR.c,228 :: 		if(counter1>(14000*1))
	MOVF        _counter1+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main64
	MOVF        _counter1+2, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main64
	MOVF        _counter1+1, 0 
	SUBLW       54
	BTFSS       STATUS+0, 2 
	GOTO        L__main64
	MOVF        _counter1+0, 0 
	SUBLW       176
L__main64:
	BTFSC       STATUS+0, 0 
	GOTO        L_main41
;CONCENTRADOR.c,230 :: 		counter1=0;
	CLRF        _counter1+0 
	CLRF        _counter1+1 
	CLRF        _counter1+2 
	CLRF        _counter1+3 
;CONCENTRADOR.c,231 :: 		if(ax==0)
	MOVF        _ax+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main42
;CONCENTRADOR.c,233 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_main43:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main44
;CONCENTRADOR.c,235 :: 		Suart2_write((char)ee1[u]); //transmitir por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,233 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,236 :: 		}
	GOTO        L_main43
L_main44:
;CONCENTRADOR.c,237 :: 		}
	GOTO        L_main46
L_main42:
;CONCENTRADOR.c,240 :: 		for(u=0;u<24;u++)
	CLRF        _u+0 
L_main47:
	MOVLW       24
	SUBWF       _u+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main48
;CONCENTRADOR.c,242 :: 		Suart2_write((char)ee2[u]); //transmitir por RS232 puerto J2(RJ45) pc
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
;CONCENTRADOR.c,240 :: 		for(u=0;u<24;u++)
	INCF        _u+0, 1 
;CONCENTRADOR.c,243 :: 		}
	GOTO        L_main47
L_main48:
;CONCENTRADOR.c,244 :: 		}
L_main46:
;CONCENTRADOR.c,245 :: 		}
L_main41:
;CONCENTRADOR.c,247 :: 		if(SWITCH_ON)   //bucle de lectura de switch_on
	BTFSS       PORTC+0, 0 
	GOTO        L_main50
;CONCENTRADOR.c,249 :: 		seg_off++;
	MOVLW       1
	ADDWF       _seg_off+0, 1 
	MOVLW       0
	ADDWFC      _seg_off+1, 1 
	ADDWFC      _seg_off+2, 1 
	ADDWFC      _seg_off+3, 1 
;CONCENTRADOR.c,254 :: 		if((seg_off > (54026 * 5)) && DS_FUENTE == 0) //1 MINUTO (4000 CYCLOS = 1 SEG)
	MOVF        _seg_off+3, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main65
	MOVF        _seg_off+2, 0 
	SUBLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L__main65
	MOVF        _seg_off+1, 0 
	SUBLW       31
	BTFSS       STATUS+0, 2 
	GOTO        L__main65
	MOVF        _seg_off+0, 0 
	SUBLW       50
L__main65:
	BTFSC       STATUS+0, 0 
	GOTO        L_main53
	BTFSC       PORTB+0, 5 
	GOTO        L_main53
L__main55:
;CONCENTRADOR.c,256 :: 		seg_off = 0;
	CLRF        _seg_off+0 
	CLRF        _seg_off+1 
	CLRF        _seg_off+2 
	CLRF        _seg_off+3 
;CONCENTRADOR.c,257 :: 		DS_FUENTE = 1;
	BSF         PORTB+0, 5 
;CONCENTRADOR.c,258 :: 		SUart0_write('A');  //add PC
	MOVLW       65
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,259 :: 		SUart0_write('P');  //add PC
	MOVLW       80
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,260 :: 		SUart0_write('A');  //add PC
	MOVLW       65
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,261 :: 		SUart0_write('G');  //add PC
	MOVLW       71
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,262 :: 		SUart0_write('A');  //add PC
	MOVLW       65
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,263 :: 		SUart0_write('N');  //add PC
	MOVLW       78
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,264 :: 		SUart0_write('D');  //add PC
	MOVLW       68
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,265 :: 		SUart0_write('O');  //add PC
	MOVLW       79
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,266 :: 		SUart0_write('\r');  //add PC
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,267 :: 		SUart0_write('\n');  //add PC
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;CONCENTRADOR.c,268 :: 		}
L_main53:
;CONCENTRADOR.c,269 :: 		}
	GOTO        L_main54
L_main50:
;CONCENTRADOR.c,272 :: 		seg_off = 0;
	CLRF        _seg_off+0 
	CLRF        _seg_off+1 
	CLRF        _seg_off+2 
	CLRF        _seg_off+3 
;CONCENTRADOR.c,273 :: 		DS_FUENTE = 0;
	BCF         PORTB+0, 5 
;CONCENTRADOR.c,274 :: 		}
L_main54:
;CONCENTRADOR.c,275 :: 		}
	GOTO        L_main3
;CONCENTRADOR.c,276 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
