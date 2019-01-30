
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
L__interrupt27:
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
;barras4.c,55 :: 		read_data();
	CALL        _read_data+0, 0
;barras4.c,57 :: 		while(1)
L_main1:
;barras4.c,71 :: 		detect();
	CALL        _detect+0, 0
;barras4.c,72 :: 		if(RJ45)
	BTFSS       PORTD+0, 6 
	GOTO        L_main3
;barras4.c,74 :: 		bloqueo();
	CALL        _bloqueo+0, 0
;barras4.c,75 :: 		counter();
	CALL        _counter+0, 0
;barras4.c,76 :: 		}
L_main3:
;barras4.c,87 :: 		while(OPTO == 1)
L_main4:
	BTFSS       PORTE+0, 2 
	GOTO        L_main5
;barras4.c,90 :: 		LED_A = ~LED_A;
	BTG         PORTC+0, 5 
;barras4.c,92 :: 		SUart0_Write('S');
	MOVLW       83
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,93 :: 		SUart0_Write('I');
	MOVLW       73
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,94 :: 		SUart0_Write('N');
	MOVLW       78
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,95 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,96 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,107 :: 		almacenarDatos();  //redundancia para asegurar el almacenamiento de
	CALL        _almacenarDatos+0, 0
;barras4.c,109 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
;barras4.c,110 :: 		if(almacenarDatos() == 1 && guardado_flag == 0)
	CALL        _almacenarDatos+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVLW       1
	XORWF       R0, 0 
L__main29:
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
	MOVLW       0
	XORWF       _guardado_flag+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main30
	MOVLW       0
	XORWF       _guardado_flag+0, 0 
L__main30:
	BTFSS       STATUS+0, 2 
	GOTO        L_main9
L__main24:
;barras4.c,112 :: 		SUart0_Write('G');
	MOVLW       71
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,113 :: 		SUart0_Write('O');
	MOVLW       79
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,114 :: 		SUart0_Write('K');
	MOVLW       75
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,115 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,116 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,117 :: 		guardado_flag = 1;
	MOVLW       1
	MOVWF       _guardado_flag+0 
	MOVLW       0
	MOVWF       _guardado_flag+1 
;barras4.c,118 :: 		LED_V = ~LED_V;
	BTG         PORTE+0, 0 
;barras4.c,119 :: 		}
L_main9:
;barras4.c,120 :: 		}
	GOTO        L_main4
L_main5:
;barras4.c,127 :: 		if(OPTO == 0)
	BTFSC       PORTE+0, 2 
	GOTO        L_main10
;barras4.c,129 :: 		read_data();
	CALL        _read_data+0, 0
;barras4.c,130 :: 		guardado_flag = 0;
	CLRF        _guardado_flag+0 
	CLRF        _guardado_flag+1 
;barras4.c,131 :: 		PORTB.B1 = 0;
	BCF         PORTB+0, 1 
;barras4.c,132 :: 		}
L_main10:
;barras4.c,138 :: 		if(!DET1 && !DET2 && !DET3 && !DET4 && !DET5)
	BTFSC       PORTA+0, 4 
	GOTO        L_main13
	BTFSC       PORTA+0, 3 
	GOTO        L_main13
	BTFSC       PORTE+0, 1 
	GOTO        L_main13
	BTFSC       PORTB+0, 7 
	GOTO        L_main13
	BTFSC       PORTB+0, 6 
	GOTO        L_main13
L__main23:
;barras4.c,139 :: 		verificarPeticion(datoRecibido);          //leer bus 485 en busca de dato entrante
	MOVLW       _datoRecibido+0
	MOVWF       FARG_verificarPeticion_dat+0 
	MOVLW       hi_addr(_datoRecibido+0)
	MOVWF       FARG_verificarPeticion_dat+1 
	CALL        _verificarPeticion+0, 0
	GOTO        L_main14
L_main13:
;barras4.c,141 :: 		indicadorOcupado();                       //indicar que esta ocupado
	CALL        _indicadorOcupado+0, 0
L_main14:
;barras4.c,143 :: 		}
	GOTO        L_main1
;barras4.c,144 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_verificarPeticion:

;barras4.c,153 :: 		void verificarPeticion(char dat[9])
;barras4.c,155 :: 		if (datoRecibido[5])  //msm error
	MOVF        _datoRecibido+5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_verificarPeticion15
;barras4.c,157 :: 		datoRecibido[5] = 0;         //limpiar bandera
	CLRF        _datoRecibido+5 
;barras4.c,158 :: 		}
L_verificarPeticion15:
;barras4.c,159 :: 		if (datoRecibido[4])  //msm OK
	MOVF        _datoRecibido+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_verificarPeticion16
;barras4.c,161 :: 		PORTB.B1 = 1; PORTB.B2 = 1; //indicador visual de peticion
	BSF         PORTB+0, 1 
	BSF         PORTB+0, 2 
;barras4.c,162 :: 		datoRecibido[4] = 0;        //limpiar bandera
	CLRF        _datoRecibido+4 
;barras4.c,163 :: 		j = datoRecibido[0];        //obtengo dato entrante
	MOVF        _datoRecibido+0, 0 
	MOVWF       _j+0 
;barras4.c,164 :: 		if(j = 0xFF)                //comprueba que la peticion del maestro es correcta
	MOVLW       255
	MOVWF       _j+0 
;barras4.c,166 :: 		rs485_slave_send();     //responde al maestro con in, out y blk
	CALL        _rs485_slave_send+0, 0
;barras4.c,167 :: 		PORTB.B1 = 0; PORTB.B2 = 0; //apaga indicadores visuales
	BCF         PORTB+0, 1 
	BCF         PORTB+0, 2 
;barras4.c,176 :: 		}
L_verificarPeticion18:
;barras4.c,177 :: 		}
L_verificarPeticion16:
;barras4.c,178 :: 		}
L_end_verificarPeticion:
	RETURN      0
; end of _verificarPeticion

_almacenarDatos:

;barras4.c,187 :: 		int almacenarDatos(void)
;barras4.c,191 :: 		V_in   = ENTRAN;
	MOVF        _ENTRAN+0, 0 
	MOVWF       almacenarDatos_V_in_L0+0 
	MOVF        _ENTRAN+1, 0 
	MOVWF       almacenarDatos_V_in_L0+1 
	MOVF        _ENTRAN+2, 0 
	MOVWF       almacenarDatos_V_in_L0+2 
	MOVF        _ENTRAN+3, 0 
	MOVWF       almacenarDatos_V_in_L0+3 
;barras4.c,192 :: 		V_sal  = SALEN;
	MOVF        _SALEN+0, 0 
	MOVWF       almacenarDatos_V_sal_L0+0 
	MOVF        _SALEN+1, 0 
	MOVWF       almacenarDatos_V_sal_L0+1 
	MOVF        _SALEN+2, 0 
	MOVWF       almacenarDatos_V_sal_L0+2 
	MOVF        _SALEN+3, 0 
	MOVWF       almacenarDatos_V_sal_L0+3 
;barras4.c,193 :: 		V_bloc = BLOQUEOS;
	MOVF        _BLOQUEOS+0, 0 
	MOVWF       almacenarDatos_V_bloc_L0+0 
	MOVF        _BLOQUEOS+1, 0 
	MOVWF       almacenarDatos_V_bloc_L0+1 
	MOVF        _BLOQUEOS+2, 0 
	MOVWF       almacenarDatos_V_bloc_L0+2 
	MOVF        _BLOQUEOS+3, 0 
	MOVWF       almacenarDatos_V_bloc_L0+3 
;barras4.c,195 :: 		save_data();
	CALL        _save_data+0, 0
;barras4.c,198 :: 		read_data();
	CALL        _read_data+0, 0
;barras4.c,200 :: 		if(ENTRAN == V_in && SALEN == V_sal && BLOQUEOS == V_bloc)
	MOVF        _ENTRAN+3, 0 
	XORWF       almacenarDatos_V_in_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos33
	MOVF        _ENTRAN+2, 0 
	XORWF       almacenarDatos_V_in_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos33
	MOVF        _ENTRAN+1, 0 
	XORWF       almacenarDatos_V_in_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos33
	MOVF        _ENTRAN+0, 0 
	XORWF       almacenarDatos_V_in_L0+0, 0 
L__almacenarDatos33:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos21
	MOVF        _SALEN+3, 0 
	XORWF       almacenarDatos_V_sal_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos34
	MOVF        _SALEN+2, 0 
	XORWF       almacenarDatos_V_sal_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos34
	MOVF        _SALEN+1, 0 
	XORWF       almacenarDatos_V_sal_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos34
	MOVF        _SALEN+0, 0 
	XORWF       almacenarDatos_V_sal_L0+0, 0 
L__almacenarDatos34:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos21
	MOVF        _BLOQUEOS+3, 0 
	XORWF       almacenarDatos_V_bloc_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos35
	MOVF        _BLOQUEOS+2, 0 
	XORWF       almacenarDatos_V_bloc_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos35
	MOVF        _BLOQUEOS+1, 0 
	XORWF       almacenarDatos_V_bloc_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos35
	MOVF        _BLOQUEOS+0, 0 
	XORWF       almacenarDatos_V_bloc_L0+0, 0 
L__almacenarDatos35:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos21
L__almacenarDatos25:
;barras4.c,202 :: 		return 1; /*si es verdadero, retorna 1 correspondiente a existoso*/
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_almacenarDatos
;barras4.c,203 :: 		}
L_almacenarDatos21:
;barras4.c,206 :: 		ENTRAN   = V_in;
	MOVF        almacenarDatos_V_in_L0+0, 0 
	MOVWF       _ENTRAN+0 
	MOVF        almacenarDatos_V_in_L0+1, 0 
	MOVWF       _ENTRAN+1 
	MOVF        almacenarDatos_V_in_L0+2, 0 
	MOVWF       _ENTRAN+2 
	MOVF        almacenarDatos_V_in_L0+3, 0 
	MOVWF       _ENTRAN+3 
;barras4.c,207 :: 		SALEN    = V_sal;
	MOVF        almacenarDatos_V_sal_L0+0, 0 
	MOVWF       _SALEN+0 
	MOVF        almacenarDatos_V_sal_L0+1, 0 
	MOVWF       _SALEN+1 
	MOVF        almacenarDatos_V_sal_L0+2, 0 
	MOVWF       _SALEN+2 
	MOVF        almacenarDatos_V_sal_L0+3, 0 
	MOVWF       _SALEN+3 
;barras4.c,208 :: 		BLOQUEOS = V_bloc;
	MOVF        almacenarDatos_V_bloc_L0+0, 0 
	MOVWF       _BLOQUEOS+0 
	MOVF        almacenarDatos_V_bloc_L0+1, 0 
	MOVWF       _BLOQUEOS+1 
	MOVF        almacenarDatos_V_bloc_L0+2, 0 
	MOVWF       _BLOQUEOS+2 
	MOVF        almacenarDatos_V_bloc_L0+3, 0 
	MOVWF       _BLOQUEOS+3 
;barras4.c,210 :: 		sobreescritos y retorna un 0 correspondiente a error*/
	CLRF        R0 
	CLRF        R1 
;barras4.c,212 :: 		}
L_end_almacenarDatos:
	RETURN      0
; end of _almacenarDatos

_indicadorOcupado:

;barras4.c,218 :: 		void indicadorOcupado()
;barras4.c,220 :: 		PORTB.B1 = ~PORTB.B1;
	BTG         PORTB+0, 1 
;barras4.c,221 :: 		}
L_end_indicadorOcupado:
	RETURN      0
; end of _indicadorOcupado
