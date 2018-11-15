
_save_data:

;eeprom.c,3 :: 		void save_data(void){
;eeprom.c,4 :: 		write_long(80,ENTRAN);
	MOVLW       80
	MOVWF       FARG_write_long_addr+0 
	MOVLW       0
	MOVWF       FARG_write_long_addr+1 
	MOVF        _ENTRAN+0, 0 
	MOVWF       FARG_write_long_four_byte+0 
	MOVF        _ENTRAN+1, 0 
	MOVWF       FARG_write_long_four_byte+1 
	MOVF        _ENTRAN+2, 0 
	MOVWF       FARG_write_long_four_byte+2 
	MOVF        _ENTRAN+3, 0 
	MOVWF       FARG_write_long_four_byte+3 
	CALL        _write_long+0, 0
;eeprom.c,5 :: 		write_long(84,SALEN);
	MOVLW       84
	MOVWF       FARG_write_long_addr+0 
	MOVLW       0
	MOVWF       FARG_write_long_addr+1 
	MOVF        _SALEN+0, 0 
	MOVWF       FARG_write_long_four_byte+0 
	MOVF        _SALEN+1, 0 
	MOVWF       FARG_write_long_four_byte+1 
	MOVF        _SALEN+2, 0 
	MOVWF       FARG_write_long_four_byte+2 
	MOVF        _SALEN+3, 0 
	MOVWF       FARG_write_long_four_byte+3 
	CALL        _write_long+0, 0
;eeprom.c,6 :: 		write_long(88,BLOQUEOS);
	MOVLW       88
	MOVWF       FARG_write_long_addr+0 
	MOVLW       0
	MOVWF       FARG_write_long_addr+1 
	MOVF        _BLOQUEOS+0, 0 
	MOVWF       FARG_write_long_four_byte+0 
	MOVF        _BLOQUEOS+1, 0 
	MOVWF       FARG_write_long_four_byte+1 
	MOVF        _BLOQUEOS+2, 0 
	MOVWF       FARG_write_long_four_byte+2 
	MOVF        _BLOQUEOS+3, 0 
	MOVWF       FARG_write_long_four_byte+3 
	CALL        _write_long+0, 0
;eeprom.c,7 :: 		write_long(92,555);
	MOVLW       92
	MOVWF       FARG_write_long_addr+0 
	MOVLW       0
	MOVWF       FARG_write_long_addr+1 
	MOVLW       43
	MOVWF       FARG_write_long_four_byte+0 
	MOVLW       2
	MOVWF       FARG_write_long_four_byte+1 
	MOVLW       0
	MOVWF       FARG_write_long_four_byte+2 
	MOVWF       FARG_write_long_four_byte+3 
	CALL        _write_long+0, 0
;eeprom.c,8 :: 		Delay_ms(20);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_save_data0:
	DECFSZ      R13, 1, 1
	BRA         L_save_data0
	DECFSZ      R12, 1, 1
	BRA         L_save_data0
;eeprom.c,9 :: 		}
L_end_save_data:
	RETURN      0
; end of _save_data

_read_data:

;eeprom.c,11 :: 		void read_data(void){
;eeprom.c,12 :: 		ENTRAN=read_long(80);
	MOVLW       80
	MOVWF       FARG_read_long_addr+0 
	MOVLW       0
	MOVWF       FARG_read_long_addr+1 
	CALL        _read_long+0, 0
	MOVF        R0, 0 
	MOVWF       _ENTRAN+0 
	MOVF        R1, 0 
	MOVWF       _ENTRAN+1 
	MOVF        R2, 0 
	MOVWF       _ENTRAN+2 
	MOVF        R3, 0 
	MOVWF       _ENTRAN+3 
;eeprom.c,13 :: 		SALEN=read_long(84);
	MOVLW       84
	MOVWF       FARG_read_long_addr+0 
	MOVLW       0
	MOVWF       FARG_read_long_addr+1 
	CALL        _read_long+0, 0
	MOVF        R0, 0 
	MOVWF       _SALEN+0 
	MOVF        R1, 0 
	MOVWF       _SALEN+1 
	MOVF        R2, 0 
	MOVWF       _SALEN+2 
	MOVF        R3, 0 
	MOVWF       _SALEN+3 
;eeprom.c,14 :: 		BLOQUEOS=read_long(88);
	MOVLW       88
	MOVWF       FARG_read_long_addr+0 
	MOVLW       0
	MOVWF       FARG_read_long_addr+1 
	CALL        _read_long+0, 0
	MOVF        R0, 0 
	MOVWF       _BLOQUEOS+0 
	MOVF        R1, 0 
	MOVWF       _BLOQUEOS+1 
	MOVF        R2, 0 
	MOVWF       _BLOQUEOS+2 
	MOVF        R3, 0 
	MOVWF       _BLOQUEOS+3 
;eeprom.c,15 :: 		Delay_ms(20);
	MOVLW       7
	MOVWF       R12, 0
	MOVLW       125
	MOVWF       R13, 0
L_read_data1:
	DECFSZ      R13, 1, 1
	BRA         L_read_data1
	DECFSZ      R12, 1, 1
	BRA         L_read_data1
;eeprom.c,16 :: 		}
L_end_read_data:
	RETURN      0
; end of _read_data

_write_long:

;eeprom.c,18 :: 		void write_long(unsigned int addr, unsigned long int four_byte)
;eeprom.c,25 :: 		f_byte=four_byte&0xFF;
	MOVLW       255
	ANDWF       FARG_write_long_four_byte+0, 0 
	MOVWF       write_long_f_byte_L0+0 
;eeprom.c,26 :: 		s_byte=(four_byte&0xFF00)>>8;
	MOVLW       0
	ANDWF       FARG_write_long_four_byte+0, 0 
	MOVWF       R5 
	MOVLW       255
	ANDWF       FARG_write_long_four_byte+1, 0 
	MOVWF       R6 
	MOVF        FARG_write_long_four_byte+2, 0 
	MOVWF       R7 
	MOVF        FARG_write_long_four_byte+3, 0 
	MOVWF       R8 
	MOVLW       0
	ANDWF       R7, 1 
	ANDWF       R8, 1 
	MOVF        R6, 0 
	MOVWF       R0 
	MOVF        R7, 0 
	MOVWF       R1 
	MOVF        R8, 0 
	MOVWF       R2 
	CLRF        R3 
	MOVF        R0, 0 
	MOVWF       write_long_s_byte_L0+0 
;eeprom.c,27 :: 		t_byte=(four_byte&0xFF0000)>>16;
	MOVLW       0
	ANDWF       FARG_write_long_four_byte+0, 0 
	MOVWF       R5 
	MOVLW       0
	ANDWF       FARG_write_long_four_byte+1, 0 
	MOVWF       R6 
	MOVLW       255
	ANDWF       FARG_write_long_four_byte+2, 0 
	MOVWF       R7 
	MOVLW       0
	ANDWF       FARG_write_long_four_byte+3, 0 
	MOVWF       R8 
	MOVF        R7, 0 
	MOVWF       R0 
	MOVF        R8, 0 
	MOVWF       R1 
	CLRF        R2 
	CLRF        R3 
	MOVF        R0, 0 
	MOVWF       write_long_t_byte_L0+0 
;eeprom.c,28 :: 		fth_byte=(four_byte&0xFF000000)>>24;
	MOVLW       0
	ANDWF       FARG_write_long_four_byte+0, 0 
	MOVWF       R5 
	MOVLW       0
	ANDWF       FARG_write_long_four_byte+1, 0 
	MOVWF       R6 
	MOVLW       0
	ANDWF       FARG_write_long_four_byte+2, 0 
	MOVWF       R7 
	MOVLW       255
	ANDWF       FARG_write_long_four_byte+3, 0 
	MOVWF       R8 
	MOVF        R8, 0 
	MOVWF       R0 
	CLRF        R1 
	CLRF        R2 
	CLRF        R3 
;eeprom.c,30 :: 		EEPROM_Write (addr++,fth_byte);
	MOVF        FARG_write_long_addr+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        FARG_write_long_addr+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      FARG_write_long_addr+0, 1 
	INCF        FARG_write_long_addr+1, 1 
;eeprom.c,31 :: 		EEPROM_Write (addr++,t_byte);
	MOVF        FARG_write_long_addr+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        FARG_write_long_addr+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        write_long_t_byte_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      FARG_write_long_addr+0, 1 
	INCF        FARG_write_long_addr+1, 1 
;eeprom.c,32 :: 		EEPROM_Write (addr++,s_byte);
	MOVF        FARG_write_long_addr+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        FARG_write_long_addr+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        write_long_s_byte_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      FARG_write_long_addr+0, 1 
	INCF        FARG_write_long_addr+1, 1 
;eeprom.c,33 :: 		EEPROM_Write (addr,f_byte);
	MOVF        FARG_write_long_addr+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        FARG_write_long_addr+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        write_long_f_byte_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;eeprom.c,34 :: 		}
L_end_write_long:
	RETURN      0
; end of _write_long

_read_long:

;eeprom.c,36 :: 		unsigned long int read_long(unsigned int addr)
;eeprom.c,38 :: 		unsigned long int res=0;
	CLRF        read_long_res_L0+0 
	CLRF        read_long_res_L0+1 
	CLRF        read_long_res_L0+2 
	CLRF        read_long_res_L0+3 
;eeprom.c,39 :: 		res+=(((unsigned long int)EEPROM_Read(addr++))<<24);
	MOVF        FARG_read_long_addr+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        FARG_read_long_addr+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
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
	ADDWF       read_long_res_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      read_long_res_L0+1, 1 
	MOVF        R2, 0 
	ADDWFC      read_long_res_L0+2, 1 
	MOVF        R3, 0 
	ADDWFC      read_long_res_L0+3, 1 
	INFSNZ      FARG_read_long_addr+0, 1 
	INCF        FARG_read_long_addr+1, 1 
;eeprom.c,40 :: 		res+=(((unsigned long int)EEPROM_Read(addr++))<<16);
	MOVF        FARG_read_long_addr+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        FARG_read_long_addr+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
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
	ADDWF       read_long_res_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      read_long_res_L0+1, 1 
	MOVF        R2, 0 
	ADDWFC      read_long_res_L0+2, 1 
	MOVF        R3, 0 
	ADDWFC      read_long_res_L0+3, 1 
	INFSNZ      FARG_read_long_addr+0, 1 
	INCF        FARG_read_long_addr+1, 1 
;eeprom.c,41 :: 		res+=(((unsigned long int)EEPROM_Read(addr++))<<8);
	MOVF        FARG_read_long_addr+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        FARG_read_long_addr+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
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
	ADDWF       read_long_res_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      read_long_res_L0+1, 1 
	MOVF        R2, 0 
	ADDWFC      read_long_res_L0+2, 1 
	MOVF        R3, 0 
	ADDWFC      read_long_res_L0+3, 1 
	INFSNZ      FARG_read_long_addr+0, 1 
	INCF        FARG_read_long_addr+1, 1 
;eeprom.c,42 :: 		res+=(unsigned long int)EEPROM_Read(addr);
	MOVF        FARG_read_long_addr+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        FARG_read_long_addr+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVWF       R2 
	MOVWF       R3 
	MOVF        read_long_res_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        read_long_res_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        read_long_res_L0+2, 0 
	ADDWFC      R2, 1 
	MOVF        read_long_res_L0+3, 0 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       read_long_res_L0+0 
	MOVF        R1, 0 
	MOVWF       read_long_res_L0+1 
	MOVF        R2, 0 
	MOVWF       read_long_res_L0+2 
	MOVF        R3, 0 
	MOVWF       read_long_res_L0+3 
;eeprom.c,43 :: 		return res;
;eeprom.c,44 :: 		}
L_end_read_long:
	RETURN      0
; end of _read_long
