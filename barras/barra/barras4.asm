
_interrupt:

;barras4.c,16 :: 		void interrupt()
;barras4.c,18 :: 		RS485Slave_Receive(datoRecibido);
	MOVLW       _datoRecibido+0
	MOVWF       FARG_RS485Slave_Receive_data_buffer+0 
	MOVLW       hi_addr(_datoRecibido+0)
	MOVWF       FARG_RS485Slave_Receive_data_buffer+1 
	CALL        _RS485Slave_Receive+0, 0
;barras4.c,19 :: 		}
L_end_interrupt:
L__interrupt14:
	RETFIE      1
; end of _interrupt

_main:

;barras4.c,21 :: 		void main()
;barras4.c,23 :: 		init_setup();
	CALL        _init_setup+0, 0
;barras4.c,26 :: 		UART1_Init(9600);                  // initialize UART1 module
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       17
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;barras4.c,27 :: 		Delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
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
;barras4.c,29 :: 		RS485Slave_Init(slave_id);
	MOVLW       10
	MOVWF       FARG_RS485Slave_Init_slave_address+0 
	CALL        _RS485Slave_Init+0, 0
;barras4.c,31 :: 		slave_rx_dat[4] = 0;                        // ensure that message received flag is 0
	CLRF        _slave_rx_dat+4 
;barras4.c,32 :: 		slave_rx_dat[5] = 0;                        // ensure that message received flag is 0
	CLRF        _slave_rx_dat+5 
;barras4.c,33 :: 		slave_rx_dat[6] = 0;                        // ensure that error flag is 0
	CLRF        _slave_rx_dat+6 
;barras4.c,35 :: 		RCIE_bit = 1;                      // enable interrupt on UART1 receive
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;barras4.c,36 :: 		TXIE_bit = 0;                      // disable interrupt on UART1 transmit
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;barras4.c,37 :: 		PEIE_bit = 1;                      // enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;barras4.c,38 :: 		GIE_bit = 1;                       // enable all interrupts
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;barras4.c,41 :: 		SUart0_Write('E');
	MOVLW       69
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,42 :: 		SUart0_Write('S');
	MOVLW       83
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,43 :: 		SUart0_Write((leerIdSlave()/10)+48);
	CALL        _leerIdSlave+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,44 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,45 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,47 :: 		while(1)
L_main1:
;barras4.c,49 :: 		detect();
	CALL        _detect+0, 0
;barras4.c,50 :: 		if(RJ45)
	BTFSS       PORTD+0, 6 
	GOTO        L_main3
;barras4.c,52 :: 		bloqueo();
	CALL        _bloqueo+0, 0
;barras4.c,53 :: 		counter();
	CALL        _counter+0, 0
;barras4.c,54 :: 		}
L_main3:
;barras4.c,58 :: 		if(!DET1 && !DET2 && !DET3 && !DET4 && !DET5)
	BTFSC       PORTA+0, 4 
	GOTO        L_main6
	BTFSC       PORTA+0, 3 
	GOTO        L_main6
	BTFSC       PORTE+0, 1 
	GOTO        L_main6
	BTFSC       PORTB+0, 7 
	GOTO        L_main6
	BTFSC       PORTB+0, 6 
	GOTO        L_main6
L__main12:
;barras4.c,59 :: 		verificarPeticion(datoRecibido);          //leer bus 485
	MOVLW       _datoRecibido+0
	MOVWF       FARG_verificarPeticion_dat+0 
	MOVLW       hi_addr(_datoRecibido+0)
	MOVWF       FARG_verificarPeticion_dat+1 
	CALL        _verificarPeticion+0, 0
	GOTO        L_main7
L_main6:
;barras4.c,61 :: 		indicadorOcupado();
	CALL        _indicadorOcupado+0, 0
L_main7:
;barras4.c,63 :: 		}
	GOTO        L_main1
;barras4.c,64 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_verificarPeticion:

;barras4.c,66 :: 		void verificarPeticion(char dat[9])
;barras4.c,68 :: 		if (datoRecibido[5])  //msm error
	MOVF        _datoRecibido+5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_verificarPeticion8
;barras4.c,70 :: 		datoRecibido[5] = 0;         //limpiar bandera
	CLRF        _datoRecibido+5 
;barras4.c,71 :: 		}
L_verificarPeticion8:
;barras4.c,72 :: 		if (datoRecibido[4])  //msm OK
	MOVF        _datoRecibido+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_verificarPeticion9
;barras4.c,74 :: 		PORTB.B1 = 1; PORTB.B2 = 1; //indicador visual de peticion
	BSF         PORTB+0, 1 
	BSF         PORTB+0, 2 
;barras4.c,75 :: 		datoRecibido[4] = 0;        //limpiar bandera
	CLRF        _datoRecibido+4 
;barras4.c,76 :: 		j = datoRecibido[0];        //obtengo dato entrante
	MOVF        _datoRecibido+0, 0 
	MOVWF       _j+0 
;barras4.c,77 :: 		if(j = 0xFF) //comprueba que la peticion del maestro es correcta
	MOVLW       255
	MOVWF       _j+0 
;barras4.c,79 :: 		rs485_slave_send();     //responde al maestro con in, out y blk
	CALL        _rs485_slave_send+0, 0
;barras4.c,80 :: 		PORTB.B1 = 0; PORTB.B2 = 0; //apaga indicadores visuales
	BCF         PORTB+0, 1 
	BCF         PORTB+0, 2 
;barras4.c,89 :: 		}
L_verificarPeticion11:
;barras4.c,90 :: 		}
L_verificarPeticion9:
;barras4.c,91 :: 		}
L_end_verificarPeticion:
	RETURN      0
; end of _verificarPeticion

_indicadorOcupado:

;barras4.c,93 :: 		void indicadorOcupado()
;barras4.c,102 :: 		PORTB.B1 = ~PORTB.B1;
	BTG         PORTB+0, 1 
;barras4.c,103 :: 		}
L_end_indicadorOcupado:
	RETURN      0
; end of _indicadorOcupado
