
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
L__interrupt26:
	RETFIE      1
; end of _interrupt

_main:

;barras4.c,23 :: 		void main()
;barras4.c,25 :: 		init_setup();
	CALL        _init_setup+0, 0
;barras4.c,28 :: 		UART1_Init(9600);                  // initialize UART1 module
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
;barras4.c,30 :: 		RS485Slave_Init(leerIdSlave());    //ORIGINAL PC obtiene la direccion seteada
	CALL        _leerIdSlave+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_RS485Slave_Init_slave_address+0 
	CALL        _RS485Slave_Init+0, 0
;barras4.c,33 :: 		slave_rx_dat[4] = 0;                        // ensure that message received flag is 0
	CLRF        _slave_rx_dat+4 
;barras4.c,34 :: 		slave_rx_dat[5] = 0;                        // ensure that message received flag is 0
	CLRF        _slave_rx_dat+5 
;barras4.c,35 :: 		slave_rx_dat[6] = 0;                        // ensure that error flag is 0
	CLRF        _slave_rx_dat+6 
;barras4.c,37 :: 		RCIE_bit = 1;                      // enable interrupt on UART1 receive
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;barras4.c,38 :: 		TXIE_bit = 0;                      // disable interrupt on UART1 transmit
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;barras4.c,39 :: 		PEIE_bit = 1;                      // enable peripheral interrupts
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;barras4.c,40 :: 		GIE_bit = 1;                       // enable all interrupts
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;barras4.c,43 :: 		SUart0_Write('E');
	MOVLW       69
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,44 :: 		SUart0_Write('S');
	MOVLW       83
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,45 :: 		SUart0_Write((leerIdSlave()/10)+48);
	CALL        _leerIdSlave+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,46 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,47 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,49 :: 		read_data(); //leer valores almacenados en la eeprom para evitar perdida de informacion
	CALL        _read_data+0, 0
;barras4.c,51 :: 		while(1)
L_main1:
;barras4.c,53 :: 		detect();
	CALL        _detect+0, 0
;barras4.c,54 :: 		if(RJ45)
	BTFSS       PORTD+0, 6 
	GOTO        L_main3
;barras4.c,56 :: 		bloqueo();
	CALL        _bloqueo+0, 0
;barras4.c,57 :: 		counter();
	CALL        _counter+0, 0
;barras4.c,58 :: 		}
L_main3:
;barras4.c,64 :: 		while(!voltaje_in)
L_main4:
	BTFSC       PORTD+0, 1 
	GOTO        L_main5
;barras4.c,66 :: 		SUart0_Write('S');
	MOVLW       83
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,67 :: 		SUart0_Write('I');
	MOVLW       73
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,68 :: 		SUart0_Write('N');
	MOVLW       78
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,69 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,70 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,76 :: 		if(almacenarDatos() == 1 && guardado_flag == 0)
	CALL        _almacenarDatos+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main28
	MOVLW       1
	XORWF       R0, 0 
L__main28:
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
	MOVLW       0
	XORWF       _guardado_flag+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main29
	MOVLW       0
	XORWF       _guardado_flag+0, 0 
L__main29:
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
L__main23:
;barras4.c,78 :: 		SUart0_Write('G');
	MOVLW       71
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,79 :: 		SUart0_Write('O');
	MOVLW       79
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,80 :: 		SUart0_Write('K');
	MOVLW       75
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,81 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,82 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,83 :: 		guardado_flag = 1;
	MOVLW       1
	MOVWF       _guardado_flag+0 
	MOVLW       0
	MOVWF       _guardado_flag+1 
;barras4.c,84 :: 		}
L_main8:
;barras4.c,85 :: 		}
	GOTO        L_main4
L_main5:
;barras4.c,89 :: 		if(voltaje_in)
	BTFSS       PORTD+0, 1 
	GOTO        L_main9
;barras4.c,91 :: 		guardado_flag = 0;
	CLRF        _guardado_flag+0 
	CLRF        _guardado_flag+1 
;barras4.c,92 :: 		PORTD.B1 = 0;
	BCF         PORTD+0, 1 
;barras4.c,93 :: 		}
L_main9:
;barras4.c,97 :: 		if(!DET1 && !DET2 && !DET3 && !DET4 && !DET5)
	BTFSC       PORTA+0, 4 
	GOTO        L_main12
	BTFSC       PORTA+0, 3 
	GOTO        L_main12
	BTFSC       PORTE+0, 1 
	GOTO        L_main12
	BTFSC       PORTB+0, 7 
	GOTO        L_main12
	BTFSC       PORTB+0, 6 
	GOTO        L_main12
L__main22:
;barras4.c,98 :: 		verificarPeticion(datoRecibido);          //leer bus 485
	MOVLW       _datoRecibido+0
	MOVWF       FARG_verificarPeticion_dat+0 
	MOVLW       hi_addr(_datoRecibido+0)
	MOVWF       FARG_verificarPeticion_dat+1 
	CALL        _verificarPeticion+0, 0
	GOTO        L_main13
L_main12:
;barras4.c,100 :: 		indicadorOcupado();
	CALL        _indicadorOcupado+0, 0
L_main13:
;barras4.c,102 :: 		}
	GOTO        L_main1
;barras4.c,103 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_verificarPeticion:

;barras4.c,105 :: 		void verificarPeticion(char dat[9])
;barras4.c,107 :: 		if (datoRecibido[5])  //msm error
	MOVF        _datoRecibido+5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_verificarPeticion14
;barras4.c,109 :: 		datoRecibido[5] = 0;         //limpiar bandera
	CLRF        _datoRecibido+5 
;barras4.c,110 :: 		}
L_verificarPeticion14:
;barras4.c,111 :: 		if (datoRecibido[4])  //msm OK
	MOVF        _datoRecibido+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_verificarPeticion15
;barras4.c,113 :: 		PORTB.B1 = 1; PORTB.B2 = 1; //indicador visual de peticion
	BSF         PORTB+0, 1 
	BSF         PORTB+0, 2 
;barras4.c,114 :: 		datoRecibido[4] = 0;        //limpiar bandera
	CLRF        _datoRecibido+4 
;barras4.c,115 :: 		j = datoRecibido[0];        //obtengo dato entrante
	MOVF        _datoRecibido+0, 0 
	MOVWF       _j+0 
;barras4.c,116 :: 		if(j = 0xFF) //comprueba que la peticion del maestro es correcta
	MOVLW       255
	MOVWF       _j+0 
;barras4.c,118 :: 		rs485_slave_send();     //responde al maestro con in, out y blk
	CALL        _rs485_slave_send+0, 0
;barras4.c,119 :: 		PORTB.B1 = 0; PORTB.B2 = 0; //apaga indicadores visuales
	BCF         PORTB+0, 1 
	BCF         PORTB+0, 2 
;barras4.c,128 :: 		}
L_verificarPeticion17:
;barras4.c,129 :: 		}
L_verificarPeticion15:
;barras4.c,130 :: 		}
L_end_verificarPeticion:
	RETURN      0
; end of _verificarPeticion

_almacenarDatos:

;barras4.c,132 :: 		int almacenarDatos(void)
;barras4.c,136 :: 		V_in   = ENTRAN;
	MOVF        _ENTRAN+0, 0 
	MOVWF       almacenarDatos_V_in_L0+0 
	MOVF        _ENTRAN+1, 0 
	MOVWF       almacenarDatos_V_in_L0+1 
	MOVF        _ENTRAN+2, 0 
	MOVWF       almacenarDatos_V_in_L0+2 
	MOVF        _ENTRAN+3, 0 
	MOVWF       almacenarDatos_V_in_L0+3 
;barras4.c,137 :: 		V_sal  = SALEN;
	MOVF        _SALEN+0, 0 
	MOVWF       almacenarDatos_V_sal_L0+0 
	MOVF        _SALEN+1, 0 
	MOVWF       almacenarDatos_V_sal_L0+1 
	MOVF        _SALEN+2, 0 
	MOVWF       almacenarDatos_V_sal_L0+2 
	MOVF        _SALEN+3, 0 
	MOVWF       almacenarDatos_V_sal_L0+3 
;barras4.c,138 :: 		V_bloc = BLOQUEOS;
	MOVF        _BLOQUEOS+0, 0 
	MOVWF       almacenarDatos_V_bloc_L0+0 
	MOVF        _BLOQUEOS+1, 0 
	MOVWF       almacenarDatos_V_bloc_L0+1 
	MOVF        _BLOQUEOS+2, 0 
	MOVWF       almacenarDatos_V_bloc_L0+2 
	MOVF        _BLOQUEOS+3, 0 
	MOVWF       almacenarDatos_V_bloc_L0+3 
;barras4.c,140 :: 		save_data();
	CALL        _save_data+0, 0
;barras4.c,143 :: 		read_data();
	CALL        _read_data+0, 0
;barras4.c,145 :: 		if(ENTRAN == V_in && SALEN == V_sal && BLOQUEOS == V_bloc)
	MOVF        _ENTRAN+3, 0 
	XORWF       almacenarDatos_V_in_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos32
	MOVF        _ENTRAN+2, 0 
	XORWF       almacenarDatos_V_in_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos32
	MOVF        _ENTRAN+1, 0 
	XORWF       almacenarDatos_V_in_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos32
	MOVF        _ENTRAN+0, 0 
	XORWF       almacenarDatos_V_in_L0+0, 0 
L__almacenarDatos32:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos20
	MOVF        _SALEN+3, 0 
	XORWF       almacenarDatos_V_sal_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos33
	MOVF        _SALEN+2, 0 
	XORWF       almacenarDatos_V_sal_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos33
	MOVF        _SALEN+1, 0 
	XORWF       almacenarDatos_V_sal_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos33
	MOVF        _SALEN+0, 0 
	XORWF       almacenarDatos_V_sal_L0+0, 0 
L__almacenarDatos33:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos20
	MOVF        _BLOQUEOS+3, 0 
	XORWF       almacenarDatos_V_bloc_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos34
	MOVF        _BLOQUEOS+2, 0 
	XORWF       almacenarDatos_V_bloc_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos34
	MOVF        _BLOQUEOS+1, 0 
	XORWF       almacenarDatos_V_bloc_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos34
	MOVF        _BLOQUEOS+0, 0 
	XORWF       almacenarDatos_V_bloc_L0+0, 0 
L__almacenarDatos34:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos20
L__almacenarDatos24:
;barras4.c,147 :: 		return 1; /*si es verdadero, retorna 1 correspondiente a existoso*/
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_almacenarDatos
;barras4.c,148 :: 		}
L_almacenarDatos20:
;barras4.c,151 :: 		ENTRAN   = V_in;
	MOVF        almacenarDatos_V_in_L0+0, 0 
	MOVWF       _ENTRAN+0 
	MOVF        almacenarDatos_V_in_L0+1, 0 
	MOVWF       _ENTRAN+1 
	MOVF        almacenarDatos_V_in_L0+2, 0 
	MOVWF       _ENTRAN+2 
	MOVF        almacenarDatos_V_in_L0+3, 0 
	MOVWF       _ENTRAN+3 
;barras4.c,152 :: 		SALEN    = V_sal;
	MOVF        almacenarDatos_V_sal_L0+0, 0 
	MOVWF       _SALEN+0 
	MOVF        almacenarDatos_V_sal_L0+1, 0 
	MOVWF       _SALEN+1 
	MOVF        almacenarDatos_V_sal_L0+2, 0 
	MOVWF       _SALEN+2 
	MOVF        almacenarDatos_V_sal_L0+3, 0 
	MOVWF       _SALEN+3 
;barras4.c,153 :: 		BLOQUEOS = V_bloc;
	MOVF        almacenarDatos_V_bloc_L0+0, 0 
	MOVWF       _BLOQUEOS+0 
	MOVF        almacenarDatos_V_bloc_L0+1, 0 
	MOVWF       _BLOQUEOS+1 
	MOVF        almacenarDatos_V_bloc_L0+2, 0 
	MOVWF       _BLOQUEOS+2 
	MOVF        almacenarDatos_V_bloc_L0+3, 0 
	MOVWF       _BLOQUEOS+3 
;barras4.c,155 :: 		sobreescritos y retorna un 0 correspondiente a error*/
	CLRF        R0 
	CLRF        R1 
;barras4.c,157 :: 		}
L_end_almacenarDatos:
	RETURN      0
; end of _almacenarDatos

_indicadorOcupado:

;barras4.c,159 :: 		void indicadorOcupado()
;barras4.c,161 :: 		PORTB.B1 = ~PORTB.B1;
	BTG         PORTB+0, 1 
;barras4.c,162 :: 		}
L_end_indicadorOcupado:
	RETURN      0
; end of _indicadorOcupado
