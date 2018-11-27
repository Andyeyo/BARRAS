
_rs485_slave_send:

;rs485.c,7 :: 		void rs485_slave_send(void)
;rs485.c,18 :: 		e0=ENTRAN&0xFF;
	MOVLW       255
	ANDWF       _ENTRAN+0, 0 
	MOVWF       FARG_tx_prepare_p0+0 
;rs485.c,19 :: 		e1=(ENTRAN&0xFF00)>>8;
	MOVLW       0
	ANDWF       _ENTRAN+0, 0 
	MOVWF       R1 
	MOVLW       255
	ANDWF       _ENTRAN+1, 0 
	MOVWF       R2 
	MOVF        _ENTRAN+2, 0 
	MOVWF       R3 
	MOVF        _ENTRAN+3, 0 
	MOVWF       R4 
	MOVLW       0
	ANDWF       R3, 1 
	ANDWF       R4, 1 
	MOVF        R2, 0 
	MOVWF       R13 
	MOVF        R3, 0 
	MOVWF       R14 
	MOVF        R4, 0 
	MOVWF       R15 
	CLRF        R16 
;rs485.c,20 :: 		e2=(ENTRAN&0xFF0000)>>16;
	MOVLW       0
	ANDWF       _ENTRAN+0, 0 
	MOVWF       R1 
	MOVLW       0
	ANDWF       _ENTRAN+1, 0 
	MOVWF       R2 
	MOVLW       255
	ANDWF       _ENTRAN+2, 0 
	MOVWF       R3 
	MOVLW       0
	ANDWF       _ENTRAN+3, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R9 
	MOVF        R4, 0 
	MOVWF       R10 
	CLRF        R11 
	CLRF        R12 
;rs485.c,21 :: 		e3=(ENTRAN&0xFF000000)>>24;
	MOVLW       0
	ANDWF       _ENTRAN+0, 0 
	MOVWF       R5 
	MOVLW       0
	ANDWF       _ENTRAN+1, 0 
	MOVWF       R6 
	MOVLW       0
	ANDWF       _ENTRAN+2, 0 
	MOVWF       R7 
	MOVLW       255
	ANDWF       _ENTRAN+3, 0 
	MOVWF       R8 
	MOVF        R8, 0 
	MOVWF       R0 
	CLRF        R1 
	CLRF        R2 
	CLRF        R3 
	MOVF        R0, 0 
	MOVWF       rs485_slave_send_e3_L0+0 
;rs485.c,23 :: 		s0=SALEN&0xFF;
	MOVLW       255
	ANDWF       _SALEN+0, 0 
	MOVWF       rs485_slave_send_s0_L0+0 
;rs485.c,24 :: 		s1=(SALEN&0xFF00)>>8;
	MOVLW       0
	ANDWF       _SALEN+0, 0 
	MOVWF       R5 
	MOVLW       255
	ANDWF       _SALEN+1, 0 
	MOVWF       R6 
	MOVF        _SALEN+2, 0 
	MOVWF       R7 
	MOVF        _SALEN+3, 0 
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
	MOVWF       rs485_slave_send_s1_L0+0 
;rs485.c,25 :: 		s2=(SALEN&0xFF0000)>>16;
	MOVLW       0
	ANDWF       _SALEN+0, 0 
	MOVWF       R5 
	MOVLW       0
	ANDWF       _SALEN+1, 0 
	MOVWF       R6 
	MOVLW       255
	ANDWF       _SALEN+2, 0 
	MOVWF       R7 
	MOVLW       0
	ANDWF       _SALEN+3, 0 
	MOVWF       R8 
	MOVF        R7, 0 
	MOVWF       R0 
	MOVF        R8, 0 
	MOVWF       R1 
	CLRF        R2 
	CLRF        R3 
	MOVF        R0, 0 
	MOVWF       rs485_slave_send_s2_L0+0 
;rs485.c,26 :: 		s3=(SALEN&0xFF000000)>>24;
	MOVLW       0
	ANDWF       _SALEN+0, 0 
	MOVWF       R5 
	MOVLW       0
	ANDWF       _SALEN+1, 0 
	MOVWF       R6 
	MOVLW       0
	ANDWF       _SALEN+2, 0 
	MOVWF       R7 
	MOVLW       255
	ANDWF       _SALEN+3, 0 
	MOVWF       R8 
	MOVF        R8, 0 
	MOVWF       R0 
	CLRF        R1 
	CLRF        R2 
	CLRF        R3 
	MOVF        R0, 0 
	MOVWF       rs485_slave_send_s3_L0+0 
;rs485.c,28 :: 		b0=BLOQUEOS&0xFF;
	MOVLW       255
	ANDWF       _BLOQUEOS+0, 0 
	MOVWF       rs485_slave_send_b0_L0+0 
;rs485.c,29 :: 		b1=(BLOQUEOS&0xFF00)>>8;
	MOVLW       0
	ANDWF       _BLOQUEOS+0, 0 
	MOVWF       R5 
	MOVLW       255
	ANDWF       _BLOQUEOS+1, 0 
	MOVWF       R6 
	MOVF        _BLOQUEOS+2, 0 
	MOVWF       R7 
	MOVF        _BLOQUEOS+3, 0 
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
	MOVWF       rs485_slave_send_b1_L0+0 
;rs485.c,30 :: 		b2=(BLOQUEOS&0xFF0000)>>16;
	MOVLW       0
	ANDWF       _BLOQUEOS+0, 0 
	MOVWF       R5 
	MOVLW       0
	ANDWF       _BLOQUEOS+1, 0 
	MOVWF       R6 
	MOVLW       255
	ANDWF       _BLOQUEOS+2, 0 
	MOVWF       R7 
	MOVLW       0
	ANDWF       _BLOQUEOS+3, 0 
	MOVWF       R8 
	MOVF        R7, 0 
	MOVWF       R0 
	MOVF        R8, 0 
	MOVWF       R1 
	CLRF        R2 
	CLRF        R3 
	MOVF        R0, 0 
	MOVWF       rs485_slave_send_b2_L0+0 
;rs485.c,31 :: 		b3=(BLOQUEOS&0xFF000000)>>24;
	MOVLW       0
	ANDWF       _BLOQUEOS+0, 0 
	MOVWF       R5 
	MOVLW       0
	ANDWF       _BLOQUEOS+1, 0 
	MOVWF       R6 
	MOVLW       0
	ANDWF       _BLOQUEOS+2, 0 
	MOVWF       R7 
	MOVLW       255
	ANDWF       _BLOQUEOS+3, 0 
	MOVWF       R8 
	MOVF        R8, 0 
	MOVWF       R0 
	CLRF        R1 
	CLRF        R2 
	CLRF        R3 
	MOVF        R0, 0 
	MOVWF       rs485_slave_send_b3_L0+0 
;rs485.c,33 :: 		tx_prepare(e0,e1,e2);
	MOVF        R13, 0 
	MOVWF       FARG_tx_prepare_p1+0 
	MOVF        R9, 0 
	MOVWF       FARG_tx_prepare_p2+0 
	CALL        _tx_prepare+0, 0
;rs485.c,34 :: 		RS485Slave_Send(slave_tx_dat,3); Delay_ms(20);     //tiempo de retardo para evitar sobre carga en bus
	MOVLW       _slave_tx_dat+0
	MOVWF       FARG_RS485Slave_Send_data_buffer+0 
	MOVLW       hi_addr(_slave_tx_dat+0)
	MOVWF       FARG_RS485Slave_Send_data_buffer+1 
	MOVLW       3
	MOVWF       FARG_RS485Slave_Send_datalen+0 
	CALL        _RS485Slave_Send+0, 0
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_rs485_slave_send0:
	DECFSZ      R13, 1, 1
	BRA         L_rs485_slave_send0
	DECFSZ      R12, 1, 1
	BRA         L_rs485_slave_send0
	DECFSZ      R11, 1, 1
	BRA         L_rs485_slave_send0
	NOP
;rs485.c,35 :: 		tx_prepare(e3,s0,s1);
	MOVF        rs485_slave_send_e3_L0+0, 0 
	MOVWF       FARG_tx_prepare_p0+0 
	MOVF        rs485_slave_send_s0_L0+0, 0 
	MOVWF       FARG_tx_prepare_p1+0 
	MOVF        rs485_slave_send_s1_L0+0, 0 
	MOVWF       FARG_tx_prepare_p2+0 
	CALL        _tx_prepare+0, 0
;rs485.c,36 :: 		RS485Slave_Send(slave_tx_dat,3); Delay_ms(20);
	MOVLW       _slave_tx_dat+0
	MOVWF       FARG_RS485Slave_Send_data_buffer+0 
	MOVLW       hi_addr(_slave_tx_dat+0)
	MOVWF       FARG_RS485Slave_Send_data_buffer+1 
	MOVLW       3
	MOVWF       FARG_RS485Slave_Send_datalen+0 
	CALL        _RS485Slave_Send+0, 0
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_rs485_slave_send1:
	DECFSZ      R13, 1, 1
	BRA         L_rs485_slave_send1
	DECFSZ      R12, 1, 1
	BRA         L_rs485_slave_send1
	DECFSZ      R11, 1, 1
	BRA         L_rs485_slave_send1
	NOP
;rs485.c,37 :: 		tx_prepare(s2,s3,b0);
	MOVF        rs485_slave_send_s2_L0+0, 0 
	MOVWF       FARG_tx_prepare_p0+0 
	MOVF        rs485_slave_send_s3_L0+0, 0 
	MOVWF       FARG_tx_prepare_p1+0 
	MOVF        rs485_slave_send_b0_L0+0, 0 
	MOVWF       FARG_tx_prepare_p2+0 
	CALL        _tx_prepare+0, 0
;rs485.c,38 :: 		RS485Slave_Send(slave_tx_dat,3); Delay_ms(20);
	MOVLW       _slave_tx_dat+0
	MOVWF       FARG_RS485Slave_Send_data_buffer+0 
	MOVLW       hi_addr(_slave_tx_dat+0)
	MOVWF       FARG_RS485Slave_Send_data_buffer+1 
	MOVLW       3
	MOVWF       FARG_RS485Slave_Send_datalen+0 
	CALL        _RS485Slave_Send+0, 0
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_rs485_slave_send2:
	DECFSZ      R13, 1, 1
	BRA         L_rs485_slave_send2
	DECFSZ      R12, 1, 1
	BRA         L_rs485_slave_send2
	DECFSZ      R11, 1, 1
	BRA         L_rs485_slave_send2
	NOP
;rs485.c,39 :: 		tx_prepare(b1,b2,b3);
	MOVF        rs485_slave_send_b1_L0+0, 0 
	MOVWF       FARG_tx_prepare_p0+0 
	MOVF        rs485_slave_send_b2_L0+0, 0 
	MOVWF       FARG_tx_prepare_p1+0 
	MOVF        rs485_slave_send_b3_L0+0, 0 
	MOVWF       FARG_tx_prepare_p2+0 
	CALL        _tx_prepare+0, 0
;rs485.c,40 :: 		RS485Slave_Send(slave_tx_dat,3); Delay_ms(20);
	MOVLW       _slave_tx_dat+0
	MOVWF       FARG_RS485Slave_Send_data_buffer+0 
	MOVLW       hi_addr(_slave_tx_dat+0)
	MOVWF       FARG_RS485Slave_Send_data_buffer+1 
	MOVLW       3
	MOVWF       FARG_RS485Slave_Send_datalen+0 
	CALL        _RS485Slave_Send+0, 0
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_rs485_slave_send3:
	DECFSZ      R13, 1, 1
	BRA         L_rs485_slave_send3
	DECFSZ      R12, 1, 1
	BRA         L_rs485_slave_send3
	DECFSZ      R11, 1, 1
	BRA         L_rs485_slave_send3
	NOP
;rs485.c,41 :: 		}
L_end_rs485_slave_send:
	RETURN      0
; end of _rs485_slave_send

_byte_send:

;rs485.c,43 :: 		void byte_send(char pkg){
;rs485.c,46 :: 		char x, f=0;
;rs485.c,59 :: 		}
L_end_byte_send:
	RETURN      0
; end of _byte_send

_tx_prepare:

;rs485.c,61 :: 		void tx_prepare(char p0, char p1, char p2)
;rs485.c,63 :: 		slave_tx_dat[0]=p0; //msg 0
	MOVF        FARG_tx_prepare_p0+0, 0 
	MOVWF       _slave_tx_dat+0 
;rs485.c,64 :: 		slave_tx_dat[1]=p1; //msg 1
	MOVF        FARG_tx_prepare_p1+0, 0 
	MOVWF       _slave_tx_dat+1 
;rs485.c,65 :: 		slave_tx_dat[2]=p2; //msg 2
	MOVF        FARG_tx_prepare_p2+0, 0 
	MOVWF       _slave_tx_dat+2 
;rs485.c,66 :: 		slave_tx_dat[3]=0; //datalen
	CLRF        _slave_tx_dat+3 
;rs485.c,67 :: 		slave_tx_dat[4]=0; //255 when message is received
	CLRF        _slave_tx_dat+4 
;rs485.c,68 :: 		slave_tx_dat[5]=0; //255 if error has occurred
	CLRF        _slave_tx_dat+5 
;rs485.c,69 :: 		slave_tx_dat[6]=0; //address of the Slave which sent the message
	CLRF        _slave_tx_dat+6 
;rs485.c,70 :: 		}
L_end_tx_prepare:
	RETURN      0
; end of _tx_prepare
