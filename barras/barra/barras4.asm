
_interrupt:

;barras4.c,19 :: 		void interrupt()
;barras4.c,21 :: 		RS485Slave_Receive(datoRecibido);
	MOVLW       _datoRecibido+0
	MOVWF       FARG_RS485Slave_Receive_data_buffer+0 
	MOVLW       hi_addr(_datoRecibido+0)
	MOVWF       FARG_RS485Slave_Receive_data_buffer+1 
	CALL        _RS485Slave_Receive+0, 0
;barras4.c,22 :: 		}
L_end_interrupt:
L__interrupt34:
	RETFIE      1
; end of _interrupt

_main:

;barras4.c,24 :: 		void main()
;barras4.c,26 :: 		inicio:
___main_inicio:
;barras4.c,28 :: 		init_setup();
	CALL        _init_setup+0, 0
;barras4.c,31 :: 		UART1_Init(9600);                  // Iniciar modulo UART
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       17
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;barras4.c,32 :: 		Delay_ms(100);
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
;barras4.c,33 :: 		RS485Slave_Init(leerIdSlave());    // Inicia RS485 con la direccion seteada por Dipswitch
	CALL        _leerIdSlave+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_RS485Slave_Init_slave_address+0 
	CALL        _RS485Slave_Init+0, 0
;barras4.c,36 :: 		slave_rx_dat[4] = 0;               // Limpiar banderas de comunicacion 485
	CLRF        _slave_rx_dat+4 
;barras4.c,37 :: 		slave_rx_dat[5] = 0;
	CLRF        _slave_rx_dat+5 
;barras4.c,38 :: 		slave_rx_dat[6] = 0;
	CLRF        _slave_rx_dat+6 
;barras4.c,40 :: 		RCIE_bit = 1;                      // Habilitar interrupcion serial en RX
	BSF         RCIE_bit+0, BitPos(RCIE_bit+0) 
;barras4.c,41 :: 		TXIE_bit = 0;                      // Deshabilar interrupcion serial en TX
	BCF         TXIE_bit+0, BitPos(TXIE_bit+0) 
;barras4.c,42 :: 		PEIE_bit = 1;                      // Habilitar interrupciones en perifericos
	BSF         PEIE_bit+0, BitPos(PEIE_bit+0) 
;barras4.c,43 :: 		GIE_bit = 1;                       // Habilitar control de interrupcion global
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;barras4.c,47 :: 		SUart0_Write('E');
	MOVLW       69
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,48 :: 		SUart0_Write('S');
	MOVLW       83
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,49 :: 		SUart0_Write((leerIdSlave()/10)+48);
	CALL        _leerIdSlave+0, 0
	MOVLW       10
	MOVWF       R4 
	CALL        _Div_8X8_U+0, 0
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,50 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,51 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,61 :: 		while(1)
L_main1:
;barras4.c,63 :: 		detect();
	CALL        _detect+0, 0
;barras4.c,64 :: 		if(RJ45)
	BTFSS       PORTD+0, 6 
	GOTO        L_main3
;barras4.c,66 :: 		bloqueo();
	CALL        _bloqueo+0, 0
;barras4.c,67 :: 		counter();
	CALL        _counter+0, 0
;barras4.c,68 :: 		}
L_main3:
;barras4.c,142 :: 		if(!DET1 && !DET2 && !DET3 && !DET4 && !DET5)
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
L__main31:
;barras4.c,143 :: 		verificarPeticion(datoRecibido);          //leer bus 485 en busca de dato entrante
	MOVLW       _datoRecibido+0
	MOVWF       FARG_verificarPeticion_dat+0 
	MOVLW       hi_addr(_datoRecibido+0)
	MOVWF       FARG_verificarPeticion_dat+1 
	CALL        _verificarPeticion+0, 0
	GOTO        L_main7
L_main6:
;barras4.c,145 :: 		indicadorOcupado();                       //indicar que esta ocupado
	CALL        _indicadorOcupado+0, 0
L_main7:
;barras4.c,147 :: 		if(salto == 1)
	MOVLW       0
	XORWF       _salto+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main36
	MOVLW       1
	XORWF       _salto+0, 0 
L__main36:
	BTFSS       STATUS+0, 2 
	GOTO        L_main8
;barras4.c,149 :: 		salto = 0;
	CLRF        _salto+0 
	CLRF        _salto+1 
;barras4.c,150 :: 		SUart0_Write('*');SUart0_Write('*');
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,151 :: 		SUart0_Write('*');SUart0_Write('*');
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,152 :: 		SUart0_Write('*');SUart0_Write('*');
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,153 :: 		SUart0_Write('*');SUart0_Write('*');
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,154 :: 		SUart0_Write('R');
	MOVLW       82
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,155 :: 		SUart0_Write('I');
	MOVLW       73
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,156 :: 		SUart0_Write('N');
	MOVLW       78
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,157 :: 		SUart0_Write('I');
	MOVLW       73
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,158 :: 		SUart0_Write('*');SUart0_Write('*');
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,159 :: 		SUart0_Write('*');SUart0_Write('*');
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,160 :: 		SUart0_Write('*');SUart0_Write('*');
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,161 :: 		SUart0_Write('*');SUart0_Write('*');
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
	MOVLW       42
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,162 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,163 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,164 :: 		guardado_flag = 1;
	MOVLW       1
	MOVWF       _guardado_flag+0 
	MOVLW       0
	MOVWF       _guardado_flag+1 
;barras4.c,165 :: 		goto inicio;
	GOTO        ___main_inicio
;barras4.c,166 :: 		}
L_main8:
;barras4.c,167 :: 		}
	GOTO        L_main1
;barras4.c,168 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_verificarPeticion:

;barras4.c,177 :: 		void verificarPeticion(char dat[9])
;barras4.c,179 :: 		if (datoRecibido[5])  //msm error
	MOVF        _datoRecibido+5, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_verificarPeticion9
;barras4.c,181 :: 		datoRecibido[5] = 0;         //limpiar bandera
	CLRF        _datoRecibido+5 
;barras4.c,182 :: 		}
L_verificarPeticion9:
;barras4.c,183 :: 		if (datoRecibido[4])  //msm OK
	MOVF        _datoRecibido+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_verificarPeticion10
;barras4.c,185 :: 		PORTB.B1 = 1; PORTB.B2 = 1; //indicador visual de peticion
	BSF         PORTB+0, 1 
	BSF         PORTB+0, 2 
;barras4.c,186 :: 		datoRecibido[4] = 0;        //limpiar bandera
	CLRF        _datoRecibido+4 
;barras4.c,187 :: 		j = datoRecibido[0];        //obtengo dato entrante
	MOVF        _datoRecibido+0, 0 
	MOVWF       _j+0 
;barras4.c,190 :: 		if(j == 0xFF)
	MOVF        _datoRecibido+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_verificarPeticion11
;barras4.c,192 :: 		rs485_slave_send();     //responde al maestro con in, out y blk
	CALL        _rs485_slave_send+0, 0
;barras4.c,193 :: 		PORTB.B1 = 0; PORTB.B2 = 0; //apaga indicadores visuales
	BCF         PORTB+0, 1 
	BCF         PORTB+0, 2 
;barras4.c,194 :: 		}
	GOTO        L_verificarPeticion12
L_verificarPeticion11:
;barras4.c,196 :: 		else if(j == 0xFA)
	MOVF        _j+0, 0 
	XORLW       250
	BTFSS       STATUS+0, 2 
	GOTO        L_verificarPeticion13
;barras4.c,198 :: 		SUart0_Write('R');
	MOVLW       82
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,199 :: 		SUart0_Write('S');
	MOVLW       83
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,200 :: 		SUart0_Write('T');
	MOVLW       84
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,201 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,202 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,203 :: 		for(i=0;i<5;i++)
	CLRF        _i+0 
L_verificarPeticion14:
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_verificarPeticion15
;barras4.c,205 :: 		LED_R = 1;
	BSF         PORTA+0, 5 
;barras4.c,206 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_verificarPeticion17:
	DECFSZ      R13, 1, 1
	BRA         L_verificarPeticion17
	DECFSZ      R12, 1, 1
	BRA         L_verificarPeticion17
	DECFSZ      R11, 1, 1
	BRA         L_verificarPeticion17
	NOP
	NOP
;barras4.c,207 :: 		LED_R = 0;
	BCF         PORTA+0, 5 
;barras4.c,208 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_verificarPeticion18:
	DECFSZ      R13, 1, 1
	BRA         L_verificarPeticion18
	DECFSZ      R12, 1, 1
	BRA         L_verificarPeticion18
	DECFSZ      R11, 1, 1
	BRA         L_verificarPeticion18
	NOP
	NOP
;barras4.c,203 :: 		for(i=0;i<5;i++)
	INCF        _i+0, 1 
;barras4.c,209 :: 		}
	GOTO        L_verificarPeticion14
L_verificarPeticion15:
;barras4.c,210 :: 		salto = 1;
	MOVLW       1
	MOVWF       _salto+0 
	MOVLW       0
	MOVWF       _salto+1 
;barras4.c,211 :: 		}
	GOTO        L_verificarPeticion19
L_verificarPeticion13:
;barras4.c,213 :: 		else if(j == 0xFB)
	MOVF        _j+0, 0 
	XORLW       251
	BTFSS       STATUS+0, 2 
	GOTO        L_verificarPeticion20
;barras4.c,215 :: 		SUart0_Write('R');
	MOVLW       82
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,216 :: 		SUart0_Write('T');
	MOVLW       84
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,217 :: 		SUart0_Write('U');
	MOVLW       85
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,218 :: 		SUart0_Write('\r');
	MOVLW       13
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,219 :: 		SUart0_Write('\n');
	MOVLW       10
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;barras4.c,220 :: 		for(i=0;i<5;i++)
	CLRF        _i+0 
L_verificarPeticion21:
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_verificarPeticion22
;barras4.c,222 :: 		LED_V = 1;
	BSF         PORTE+0, 0 
;barras4.c,223 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_verificarPeticion24:
	DECFSZ      R13, 1, 1
	BRA         L_verificarPeticion24
	DECFSZ      R12, 1, 1
	BRA         L_verificarPeticion24
	DECFSZ      R11, 1, 1
	BRA         L_verificarPeticion24
	NOP
	NOP
;barras4.c,224 :: 		LED_V = 0;
	BCF         PORTE+0, 0 
;barras4.c,225 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_verificarPeticion25:
	DECFSZ      R13, 1, 1
	BRA         L_verificarPeticion25
	DECFSZ      R12, 1, 1
	BRA         L_verificarPeticion25
	DECFSZ      R11, 1, 1
	BRA         L_verificarPeticion25
	NOP
	NOP
;barras4.c,220 :: 		for(i=0;i<5;i++)
	INCF        _i+0, 1 
;barras4.c,226 :: 		}
	GOTO        L_verificarPeticion21
L_verificarPeticion22:
;barras4.c,227 :: 		ENTRAN = 0;    //pongo en cero las variables
	CLRF        _ENTRAN+0 
	CLRF        _ENTRAN+1 
	CLRF        _ENTRAN+2 
	CLRF        _ENTRAN+3 
;barras4.c,228 :: 		SALEN = 0;
	CLRF        _SALEN+0 
	CLRF        _SALEN+1 
	CLRF        _SALEN+2 
	CLRF        _SALEN+3 
;barras4.c,229 :: 		BLOQUEOS = 0;
	CLRF        _BLOQUEOS+0 
	CLRF        _BLOQUEOS+1 
	CLRF        _BLOQUEOS+2 
	CLRF        _BLOQUEOS+3 
;barras4.c,230 :: 		save_data();      //escribir en la eeprom
	CALL        _save_data+0, 0
;barras4.c,231 :: 		salto = 1;
	MOVLW       1
	MOVWF       _salto+0 
	MOVLW       0
	MOVWF       _salto+1 
;barras4.c,232 :: 		}
L_verificarPeticion20:
L_verificarPeticion19:
L_verificarPeticion12:
;barras4.c,233 :: 		}
L_verificarPeticion10:
;barras4.c,234 :: 		}
L_end_verificarPeticion:
	RETURN      0
; end of _verificarPeticion

_almacenarDatos:

;barras4.c,243 :: 		int almacenarDatos(void)
;barras4.c,248 :: 		V_in   = ENTRAN;
	MOVF        _ENTRAN+0, 0 
	MOVWF       almacenarDatos_V_in_L0+0 
	MOVF        _ENTRAN+1, 0 
	MOVWF       almacenarDatos_V_in_L0+1 
	MOVF        _ENTRAN+2, 0 
	MOVWF       almacenarDatos_V_in_L0+2 
	MOVF        _ENTRAN+3, 0 
	MOVWF       almacenarDatos_V_in_L0+3 
;barras4.c,249 :: 		V_sal  = SALEN;
	MOVF        _SALEN+0, 0 
	MOVWF       almacenarDatos_V_sal_L0+0 
	MOVF        _SALEN+1, 0 
	MOVWF       almacenarDatos_V_sal_L0+1 
	MOVF        _SALEN+2, 0 
	MOVWF       almacenarDatos_V_sal_L0+2 
	MOVF        _SALEN+3, 0 
	MOVWF       almacenarDatos_V_sal_L0+3 
;barras4.c,250 :: 		V_bloc = BLOQUEOS;
	MOVF        _BLOQUEOS+0, 0 
	MOVWF       almacenarDatos_V_bloc_L0+0 
	MOVF        _BLOQUEOS+1, 0 
	MOVWF       almacenarDatos_V_bloc_L0+1 
	MOVF        _BLOQUEOS+2, 0 
	MOVWF       almacenarDatos_V_bloc_L0+2 
	MOVF        _BLOQUEOS+3, 0 
	MOVWF       almacenarDatos_V_bloc_L0+3 
;barras4.c,253 :: 		save_data();
	CALL        _save_data+0, 0
;barras4.c,256 :: 		delay_ms(10);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_almacenarDatos26:
	DECFSZ      R13, 1, 1
	BRA         L_almacenarDatos26
	DECFSZ      R12, 1, 1
	BRA         L_almacenarDatos26
	NOP
	NOP
;barras4.c,258 :: 		read_data(); //ENTRAN, SALEN, BLOQUEOS
	CALL        _read_data+0, 0
;barras4.c,260 :: 		if(V_in == ENTRAN && V_sal == SALEN && V_bloc == BLOQUEOS)
	MOVF        almacenarDatos_V_in_L0+3, 0 
	XORWF       _ENTRAN+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos39
	MOVF        almacenarDatos_V_in_L0+2, 0 
	XORWF       _ENTRAN+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos39
	MOVF        almacenarDatos_V_in_L0+1, 0 
	XORWF       _ENTRAN+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos39
	MOVF        almacenarDatos_V_in_L0+0, 0 
	XORWF       _ENTRAN+0, 0 
L__almacenarDatos39:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos29
	MOVF        almacenarDatos_V_sal_L0+3, 0 
	XORWF       _SALEN+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos40
	MOVF        almacenarDatos_V_sal_L0+2, 0 
	XORWF       _SALEN+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos40
	MOVF        almacenarDatos_V_sal_L0+1, 0 
	XORWF       _SALEN+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos40
	MOVF        almacenarDatos_V_sal_L0+0, 0 
	XORWF       _SALEN+0, 0 
L__almacenarDatos40:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos29
	MOVF        almacenarDatos_V_bloc_L0+3, 0 
	XORWF       _BLOQUEOS+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos41
	MOVF        almacenarDatos_V_bloc_L0+2, 0 
	XORWF       _BLOQUEOS+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos41
	MOVF        almacenarDatos_V_bloc_L0+1, 0 
	XORWF       _BLOQUEOS+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__almacenarDatos41
	MOVF        almacenarDatos_V_bloc_L0+0, 0 
	XORWF       _BLOQUEOS+0, 0 
L__almacenarDatos41:
	BTFSS       STATUS+0, 2 
	GOTO        L_almacenarDatos29
L__almacenarDatos32:
;barras4.c,262 :: 		return 1; /*si es verdadero, retorna 1 correspondiente a existoso*/
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	GOTO        L_end_almacenarDatos
;barras4.c,263 :: 		}
L_almacenarDatos29:
;barras4.c,266 :: 		ENTRAN   =  V_in;
	MOVF        almacenarDatos_V_in_L0+0, 0 
	MOVWF       _ENTRAN+0 
	MOVF        almacenarDatos_V_in_L0+1, 0 
	MOVWF       _ENTRAN+1 
	MOVF        almacenarDatos_V_in_L0+2, 0 
	MOVWF       _ENTRAN+2 
	MOVF        almacenarDatos_V_in_L0+3, 0 
	MOVWF       _ENTRAN+3 
;barras4.c,267 :: 		SALEN    =  V_sal;
	MOVF        almacenarDatos_V_sal_L0+0, 0 
	MOVWF       _SALEN+0 
	MOVF        almacenarDatos_V_sal_L0+1, 0 
	MOVWF       _SALEN+1 
	MOVF        almacenarDatos_V_sal_L0+2, 0 
	MOVWF       _SALEN+2 
	MOVF        almacenarDatos_V_sal_L0+3, 0 
	MOVWF       _SALEN+3 
;barras4.c,268 :: 		BLOQUEOS =  V_bloc;
	MOVF        almacenarDatos_V_bloc_L0+0, 0 
	MOVWF       _BLOQUEOS+0 
	MOVF        almacenarDatos_V_bloc_L0+1, 0 
	MOVWF       _BLOQUEOS+1 
	MOVF        almacenarDatos_V_bloc_L0+2, 0 
	MOVWF       _BLOQUEOS+2 
	MOVF        almacenarDatos_V_bloc_L0+3, 0 
	MOVWF       _BLOQUEOS+3 
;barras4.c,270 :: 		sobreescritos y retorna un 0 correspondiente a error*/
	CLRF        R0 
	CLRF        R1 
;barras4.c,272 :: 		}
L_end_almacenarDatos:
	RETURN      0
; end of _almacenarDatos

_indicadorOcupado:

;barras4.c,278 :: 		void indicadorOcupado()
;barras4.c,280 :: 		PORTB.B1 = ~PORTB.B1;
	BTG         PORTB+0, 1 
;barras4.c,281 :: 		}
L_end_indicadorOcupado:
	RETURN      0
; end of _indicadorOcupado
