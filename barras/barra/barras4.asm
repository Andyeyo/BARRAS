
_interrupt:

;barras4.c,18 :: 		void interrupt()
;barras4.c,20 :: 		RS485Slave_Receive(datoRecibido);
	MOVLW       _datoRecibido+0
	MOVWF       FARG_RS485Slave_Receive_data_buffer+0 
	MOVLW       hi_addr(_datoRecibido+0)
	MOVWF       FARG_RS485Slave_Receive_data_buffer+1 
	CALL        _RS485Slave_Receive+0, 0
;barras4.c,21 :: 		}
L_end_interrupt:
L__interrupt20:
	RETFIE      1
; end of _interrupt

_main:

;barras4.c,23 :: 		void main()
;barras4.c,25 :: 		init_setup();
	CALL        _init_setup+0, 0
;barras4.c,28 :: 		UART1_Init(9600);                  // Iniciar modulo UART
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       17
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;barras4.c,29 :: 		Delay_ms(100);
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
;barras4.c,30 :: 		RS485Slave_Init(leerIdSlave());    // Inicia RS485 con la direccion seteada por Dipswitch
	CALL        _leerIdSlave+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_RS485Slave_Init_slave_address+0 
	CALL        _RS485Slave_Init+0, 0
;barras4.c,33 :: 		slave_rx_dat[4] = 0;               // Limpiar banderas de comunicacion 485
	CLRF        _slave_rx_dat+4 
;barras4.c,34 :: 		slave_rx_dat[5] = 0;
	CLRF        _slave_rx_dat+5 
;barras4.c,35 :: 		slave_rx_dat[6] = 0;
	CLRF        _slave_rx_dat+6 
;barras4.c,37 :: 		RCIE_bit = 1;                      // Habilitar interrupcion serial en RX
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;barras4.c,38 :: 		TXIE_bit = 0;                      // Deshabilar interrupcion serial en TX
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;barras4.c,39 :: 		PEIE_bit = 1;                      // Habilitar interrupciones en perifericos
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;barras4.c,40 :: 		GIE_bit = 1;                       // Habilitar control de interrupcion global
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;barras4.c,44 :: 		SUart0_Write('E');
	MOVLW       69
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,45 :: 		SUart0_Write('S');
	MOVLW       83
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,46 :: 		SUart0_Write((leerIdSlave()/10)+48);
	CALL        _leerIdSlave+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,47 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,48 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,58 :: 		while(1)
L_main1:
;barras4.c,60 :: 		detect();
	CALL        _detect+0, 0
;barras4.c,61 :: 		if(RJ45)
	BTFSS       PORTD+0, 6 
	GOTO        L_main3
;barras4.c,63 :: 		bloqueo();
	CALL        _bloqueo+0, 0
;barras4.c,64 :: 		counter();
	CALL        _counter+0, 0
;barras4.c,65 :: 		}
L_main3:
;barras4.c,139 :: 		if(!DET1 && !DET2 && !DET3 && !DET4 && !DET5)
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
L__main17:
;barras4.c,140 :: 		verificarPeticion(datoRecibido);          //leer bus 485 en busca de dato entrante
	MOVLW       _datoRecibido+0
	MOVWF       FARG_verificarPeticion_dat+0 
	MOVLW       hi_addr(_datoRecibido+0)
	MOVWF       FARG_verificarPeticion_dat+1 
	CALL        _verificarPeticion+0, 0
	GOTO        L_main7
L_main6:
;barras4.c,142 :: 		indicadorOcupado();                       //indicar que esta ocupado
	CALL        _indicadorOcupado+0, 0
L_main7:
;barras4.c,144 :: 		}
	GOTO        L_main1
;barras4.c,145 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_verificarPeticion:

;barras4.c,154 :: 		void verificarPeticion(char dat[9])
;barras4.c,156 :: 		if (datoRecibido[5])  //msm error
	MOVF        _datoRecibido+5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_verificarPeticion8
;barras4.c,158 :: 		datoRecibido[5] = 0;         //limpiar bandera
	CLRF        _datoRecibido+5 
;barras4.c,159 :: 		}
L_verificarPeticion8:
;barras4.c,160 :: 		if (datoRecibido[4])  //msm OK
	MOVF        _datoRecibido+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_verificarPeticion9
;barras4.c,162 :: 		PORTB.B1 = 1; PORTB.B2 = 1; //indicador visual de peticion
	BSF         PORTB+0, 1 
	BSF         PORTB+0, 2 
;barras4.c,163 :: 		datoRecibido[4] = 0;        //limpiar bandera
	CLRF        _datoRecibido+4 
;barras4.c,164 :: 		j = datoRecibido[0];        //obtengo dato entrante
	MOVF        _datoRecibido+0, 0 
	MOVWF       _j+0 
;barras4.c,165 :: 		if(j = 0xFF)                //comprueba que la peticion del maestro es correcta
	MOVLW       255
	MOVWF       _j+0 
;barras4.c,167 :: 		rs485_slave_send();     //responde al maestro con in, out y blk
	CALL        _rs485_slave_send+0, 0
;barras4.c,168 :: 		PORTB.B1 = 0; PORTB.B2 = 0; //apaga indicadores visuales
	BCF         PORTB+0, 1 
	BCF         PORTB+0, 2 
;barras4.c,177 :: 		}
L_verificarPeticion11:
;barras4.c,178 :: 		}
L_verificarPeticion9:
;barras4.c,179 :: 		}
L_end_verificarPeticion:
	RETURN      0
; end of _verificarPeticion

_almacenarDatos:

;barras4.c,188 :: 		int almacenarDatos(void)
;barras4.c,193 :: 		V_in   = ENTRAN;
	MOVF        _ENTRAN+0, 0 
	MOVWF       almacenarDatos_V_in_L0+0 
	MOVF        _ENTRAN+1, 0 
	MOVWF       almacenarDatos_V_in_L0+1 
	MOVF        _ENTRAN+2, 0 
	MOVWF       almacenarDatos_V_in_L0+2 
	MOVF        _ENTRAN+3, 0 
	MOVWF       almacenarDatos_V_in_L0+3 
;barras4.c,194 :: 		V_sal  = SALEN;
	MOVF        _SALEN+0, 0 
	MOVWF       almacenarDatos_V_sal_L0+0 
	MOVF        _SALEN+1, 0 
	MOVWF       almacenarDatos_V_sal_L0+1 
	MOVF        _SALEN+2, 0 
	MOVWF       almacenarDatos_V_sal_L0+2 
	MOVF        _SALEN+3, 0 
	MOVWF       almacenarDatos_V_sal_L0+3 
;barras4.c,195 :: 		V_bloc = BLOQUEOS;
	MOVF        _BLOQUEOS+0, 0 
	MOVWF       almacenarDatos_V_bloc_L0+0 
	MOVF        _BLOQUEOS+1, 0 
	MOVWF       almacenarDatos_V_bloc_L0+1 
	MOVF        _BLOQUEOS+2, 0 
	MOVWF       almacenarDatos_V_bloc_L0+2 
	MOVF        _BLOQUEOS+3, 0 
	MOVWF       almacenarDatos_V_bloc_L0+3 
;barras4.c,198 :: 		save_data();
	CALL        _save_data+0, 0
;barras4.c,201 :: 		delay_ms(10);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_almacenarDatos12:
	DECFSZ      R13, 1, 1
	BRA         L_almacenarDatos12
	DECFSZ      R12, 1, 1
	BRA         L_almacenarDatos12
	NOP
	NOP
;barras4.c,203 :: 		read_data(); //ENTRAN, SALEN, BLOQUEOS
	CALL        _read_data+0, 0
;barras4.c,205 :: 		if(V_in == ENTRAN && V_sal == SALEN && V_bloc == BLOQUEOS)
	MOVF        almacenarDatos_V_in_L0+3, 0 
	XORWF       _ENTRAN+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos24
	MOVF        almacenarDatos_V_in_L0+2, 0 
	XORWF       _ENTRAN+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos24
	MOVF        almacenarDatos_V_in_L0+1, 0 
	XORWF       _ENTRAN+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos24
	MOVF        almacenarDatos_V_in_L0+0, 0 
	XORWF       _ENTRAN+0, 0 
L__almacenarDatos24:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos15
	MOVF        almacenarDatos_V_sal_L0+3, 0 
	XORWF       _SALEN+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos25
	MOVF        almacenarDatos_V_sal_L0+2, 0 
	XORWF       _SALEN+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos25
	MOVF        almacenarDatos_V_sal_L0+1, 0 
	XORWF       _SALEN+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos25
	MOVF        almacenarDatos_V_sal_L0+0, 0 
	XORWF       _SALEN+0, 0 
L__almacenarDatos25:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos15
	MOVF        almacenarDatos_V_bloc_L0+3, 0 
	XORWF       _BLOQUEOS+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos26
	MOVF        almacenarDatos_V_bloc_L0+2, 0 
	XORWF       _BLOQUEOS+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos26
	MOVF        almacenarDatos_V_bloc_L0+1, 0 
	XORWF       _BLOQUEOS+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos26
	MOVF        almacenarDatos_V_bloc_L0+0, 0 
	XORWF       _BLOQUEOS+0, 0 
L__almacenarDatos26:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos15
L__almacenarDatos18:
;barras4.c,207 :: 		return 1; /*si es verdadero, retorna 1 correspondiente a existoso*/
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_almacenarDatos
;barras4.c,208 :: 		}
L_almacenarDatos15:
;barras4.c,211 :: 		ENTRAN   =  V_in;
	MOVF        almacenarDatos_V_in_L0+0, 0 
	MOVWF       _ENTRAN+0 
	MOVF        almacenarDatos_V_in_L0+1, 0 
	MOVWF       _ENTRAN+1 
	MOVF        almacenarDatos_V_in_L0+2, 0 
	MOVWF       _ENTRAN+2 
	MOVF        almacenarDatos_V_in_L0+3, 0 
	MOVWF       _ENTRAN+3 
;barras4.c,212 :: 		SALEN    =  V_sal;
	MOVF        almacenarDatos_V_sal_L0+0, 0 
	MOVWF       _SALEN+0 
	MOVF        almacenarDatos_V_sal_L0+1, 0 
	MOVWF       _SALEN+1 
	MOVF        almacenarDatos_V_sal_L0+2, 0 
	MOVWF       _SALEN+2 
	MOVF        almacenarDatos_V_sal_L0+3, 0 
	MOVWF       _SALEN+3 
;barras4.c,213 :: 		BLOQUEOS =  V_bloc;
	MOVF        almacenarDatos_V_bloc_L0+0, 0 
	MOVWF       _BLOQUEOS+0 
	MOVF        almacenarDatos_V_bloc_L0+1, 0 
	MOVWF       _BLOQUEOS+1 
	MOVF        almacenarDatos_V_bloc_L0+2, 0 
	MOVWF       _BLOQUEOS+2 
	MOVF        almacenarDatos_V_bloc_L0+3, 0 
	MOVWF       _BLOQUEOS+3 
;barras4.c,215 :: 		sobreescritos y retorna un 0 correspondiente a error*/
	CLRF        R0 
	CLRF        R1 
;barras4.c,217 :: 		}
L_end_almacenarDatos:
	RETURN      0
; end of _almacenarDatos

_indicadorOcupado:

;barras4.c,223 :: 		void indicadorOcupado()
;barras4.c,225 :: 		PORTB.B1 = ~PORTB.B1;
	BTG         PORTB+0, 1 
;barras4.c,226 :: 		}
L_end_indicadorOcupado:
	RETURN      0
; end of _indicadorOcupado
