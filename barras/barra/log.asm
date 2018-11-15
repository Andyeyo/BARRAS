
_logA_append:

;log.c,3 :: 		void logA_append(unsigned short num){
;log.c,6 :: 		logA[logAindex]=num;
	MOVLW       _logA+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_logA+0)
	MOVWF       FSR1H 
	MOVF        _logAindex+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        FARG_logA_append_num+0, 0 
	MOVWF       POSTINC1+0 
;log.c,7 :: 		logAindex++;
	INCF        _logAindex+0, 1 
;log.c,10 :: 		if(logAindex > 99)//controlar desbordamiento en el array
	MOVF        _logAindex+0, 0 
	SUBLW       99
	BTFSC       STATUS+0, 0 
	GOTO        L_logA_append0
;log.c,12 :: 		logAindex = 0;
	CLRF        _logAindex+0 
;log.c,13 :: 		}
L_logA_append0:
;log.c,14 :: 		}
L_end_logA_append:
	RETURN      0
; end of _logA_append

_logA_reset:

;log.c,16 :: 		void logA_reset(){
;log.c,18 :: 		for(jj=0; jj<logAindex;jj++){
	CLRF        R1 
L_logA_reset1:
	MOVLW       128
	BTFSC       R1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__logA_reset54
	MOVF        _logAindex+0, 0 
	SUBWF       R1, 0 
L__logA_reset54:
	BTFSC       STATUS+0, 0 
	GOTO        L_logA_reset2
;log.c,19 :: 		logA[jj]=0;
	MOVLW       _logA+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_logA+0)
	MOVWF       FSR1H 
	MOVF        R1, 0 
	ADDWF       FSR1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	CLRF        POSTINC1+0 
;log.c,18 :: 		for(jj=0; jj<logAindex;jj++){
	INCF        R1, 1 
;log.c,20 :: 		}
	GOTO        L_logA_reset1
L_logA_reset2:
;log.c,21 :: 		logAindex=0;
	CLRF        _logAindex+0 
;log.c,22 :: 		Apm=-1; Apn=-1; Apx=-1; Apy=-1;
	MOVLW       255
	MOVWF       _Apm+0 
	MOVLW       255
	MOVWF       _Apn+0 
	MOVLW       255
	MOVWF       _Apx+0 
	MOVLW       255
	MOVWF       _Apy+0 
;log.c,23 :: 		}
L_end_logA_reset:
	RETURN      0
; end of _logA_reset

_logA_dir:

;log.c,25 :: 		void logA_dir(){ // 1=M 2=N 3=X 4=Y
;log.c,26 :: 		short ii=0, aux1 = 0, aux2=0;
	CLRF        logA_dir_ii_L0+0 
	CLRF        logA_dir_aux1_L0+0 
	CLRF        logA_dir_aux2_L0+0 
;log.c,27 :: 		for(ii=0; ii<logAindex;ii++){
	CLRF        logA_dir_ii_L0+0 
L_logA_dir4:
	MOVLW       128
	BTFSC       logA_dir_ii_L0+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__logA_dir56
	MOVF        _logAindex+0, 0 
	SUBWF       logA_dir_ii_L0+0, 0 
L__logA_dir56:
	BTFSC       STATUS+0, 0 
	GOTO        L_logA_dir5
;log.c,28 :: 		if(logA[ii]==4 && aux1==0){
	MOVLW       _logA+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_logA+0)
	MOVWF       FSR0H 
	MOVF        logA_dir_ii_L0+0, 0 
	ADDWF       FSR0, 1 
	MOVLW       0
	BTFSC       logA_dir_ii_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_logA_dir9
	MOVF        logA_dir_aux1_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logA_dir9
L__logA_dir47:
;log.c,29 :: 		Apy=ii;
	MOVF        logA_dir_ii_L0+0, 0 
	MOVWF       _Apy+0 
;log.c,30 :: 		aux1=1;
	MOVLW       1
	MOVWF       logA_dir_aux1_L0+0 
;log.c,31 :: 		}
L_logA_dir9:
;log.c,32 :: 		if(logA[ii]==2 && aux2==0){
	MOVLW       _logA+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_logA+0)
	MOVWF       FSR0H 
	MOVF        logA_dir_ii_L0+0, 0 
	ADDWF       FSR0, 1 
	MOVLW       0
	BTFSC       logA_dir_ii_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_logA_dir12
	MOVF        logA_dir_aux2_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logA_dir12
L__logA_dir46:
;log.c,33 :: 		Apn=ii;
	MOVF        logA_dir_ii_L0+0, 0 
	MOVWF       _Apn+0 
;log.c,34 :: 		aux2=1;
	MOVLW       1
	MOVWF       logA_dir_aux2_L0+0 
;log.c,35 :: 		}
L_logA_dir12:
;log.c,27 :: 		for(ii=0; ii<logAindex;ii++){
	INCF        logA_dir_ii_L0+0, 1 
;log.c,36 :: 		}
	GOTO        L_logA_dir4
L_logA_dir5:
;log.c,37 :: 		aux1=0;
	CLRF        logA_dir_aux1_L0+0 
;log.c,38 :: 		aux2=0;
	CLRF        logA_dir_aux2_L0+0 
;log.c,39 :: 		for(ii=1;ii<=logAindex;ii++){
	MOVLW       1
	MOVWF       logA_dir_ii_L0+0 
L_logA_dir13:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	BTFSC       logA_dir_ii_L0+0, 7 
	MOVLW       127
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__logA_dir57
	MOVF        logA_dir_ii_L0+0, 0 
	SUBWF       _logAindex+0, 0 
L__logA_dir57:
	BTFSS       STATUS+0, 0 
	GOTO        L_logA_dir14
;log.c,40 :: 		if(logA[logAindex-ii]==1 && aux1==0){
	MOVF        logA_dir_ii_L0+0, 0 
	SUBWF       _logAindex+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	BTFSC       logA_dir_ii_L0+0, 7 
	MOVLW       255
	SUBWFB      R1, 1 
	MOVLW       _logA+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_logA+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_logA_dir18
	MOVF        logA_dir_aux1_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logA_dir18
L__logA_dir45:
;log.c,41 :: 		Apm=logAindex-ii;
	MOVF        logA_dir_ii_L0+0, 0 
	SUBWF       _logAindex+0, 0 
	MOVWF       _Apm+0 
;log.c,42 :: 		aux1=1;
	MOVLW       1
	MOVWF       logA_dir_aux1_L0+0 
;log.c,43 :: 		}
L_logA_dir18:
;log.c,44 :: 		if(logA[logAindex-ii]==3 && aux2==0){
	MOVF        logA_dir_ii_L0+0, 0 
	SUBWF       _logAindex+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	BTFSC       logA_dir_ii_L0+0, 7 
	MOVLW       255
	SUBWFB      R1, 1 
	MOVLW       _logA+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_logA+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_logA_dir21
	MOVF        logA_dir_aux2_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logA_dir21
L__logA_dir44:
;log.c,45 :: 		Apx=logAindex-ii;
	MOVF        logA_dir_ii_L0+0, 0 
	SUBWF       _logAindex+0, 0 
	MOVWF       _Apx+0 
;log.c,46 :: 		aux2=1;
	MOVLW       1
	MOVWF       logA_dir_aux2_L0+0 
;log.c,47 :: 		}
L_logA_dir21:
;log.c,39 :: 		for(ii=1;ii<=logAindex;ii++){
	INCF        logA_dir_ii_L0+0, 1 
;log.c,48 :: 		}
	GOTO        L_logA_dir13
L_logA_dir14:
;log.c,49 :: 		}
L_end_logA_dir:
	RETURN      0
; end of _logA_dir

_logB_append:

;log.c,51 :: 		void logB_append(unsigned short num){ // 1=M 2=N 3=X 4=Y
;log.c,54 :: 		logB[logBindex]=num;
	MOVLW       _logB+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_logB+0)
	MOVWF       FSR1H 
	MOVF        _logBindex+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        FARG_logB_append_num+0, 0 
	MOVWF       POSTINC1+0 
;log.c,55 :: 		logBindex++;
	INCF        _logBindex+0, 1 
;log.c,58 :: 		if(logBindex > 99) //contolar desbordamiento en el array
	MOVF        _logBindex+0, 0 
	SUBLW       99
	BTFSC       STATUS+0, 0 
	GOTO        L_logB_append22
;log.c,60 :: 		logBindex = 0;
	CLRF        _logBindex+0 
;log.c,61 :: 		}
L_logB_append22:
;log.c,62 :: 		}
L_end_logB_append:
	RETURN      0
; end of _logB_append

_logB_reset:

;log.c,64 :: 		void logB_reset(){
;log.c,66 :: 		for(jj=0; jj<logBindex;jj++){
	CLRF        R1 
L_logB_reset23:
	MOVLW       128
	BTFSC       R1, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__logB_reset60
	MOVF        _logBindex+0, 0 
	SUBWF       R1, 0 
L__logB_reset60:
	BTFSC       STATUS+0, 0 
	GOTO        L_logB_reset24
;log.c,67 :: 		logB[jj]=0;
	MOVLW       _logB+0
	MOVWF       FSR1 
	MOVLW       hi_addr(_logB+0)
	MOVWF       FSR1H 
	MOVF        R1, 0 
	ADDWF       FSR1, 1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	CLRF        POSTINC1+0 
;log.c,66 :: 		for(jj=0; jj<logBindex;jj++){
	INCF        R1, 1 
;log.c,68 :: 		}
	GOTO        L_logB_reset23
L_logB_reset24:
;log.c,69 :: 		logBindex=0;
	CLRF        _logBindex+0 
;log.c,70 :: 		Bpm=-1; Bpn=-1; Bpx=-1; Bpy=-1;
	MOVLW       255
	MOVWF       _Bpm+0 
	MOVLW       255
	MOVWF       _Bpn+0 
	MOVLW       255
	MOVWF       _Bpx+0 
	MOVLW       255
	MOVWF       _Bpy+0 
;log.c,71 :: 		}
L_end_logB_reset:
	RETURN      0
; end of _logB_reset

_logB_dir:

;log.c,73 :: 		void logB_dir(){ // 1=M 2=N 3=X 4=Y
;log.c,74 :: 		short ii=0, aux1 = 0, aux2=0;
	CLRF        logB_dir_ii_L0+0 
	CLRF        logB_dir_aux1_L0+0 
	CLRF        logB_dir_aux2_L0+0 
;log.c,75 :: 		for(ii=0; ii<logBindex;ii++){
	CLRF        logB_dir_ii_L0+0 
L_logB_dir26:
	MOVLW       128
	BTFSC       logB_dir_ii_L0+0, 7 
	MOVLW       127
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__logB_dir62
	MOVF        _logBindex+0, 0 
	SUBWF       logB_dir_ii_L0+0, 0 
L__logB_dir62:
	BTFSC       STATUS+0, 0 
	GOTO        L_logB_dir27
;log.c,76 :: 		if(logB[ii]==4 && aux1==0){
	MOVLW       _logB+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_logB+0)
	MOVWF       FSR0H 
	MOVF        logB_dir_ii_L0+0, 0 
	ADDWF       FSR0, 1 
	MOVLW       0
	BTFSC       logB_dir_ii_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_logB_dir31
	MOVF        logB_dir_aux1_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logB_dir31
L__logB_dir51:
;log.c,77 :: 		Bpy=ii;
	MOVF        logB_dir_ii_L0+0, 0 
	MOVWF       _Bpy+0 
;log.c,78 :: 		aux1=1;
	MOVLW       1
	MOVWF       logB_dir_aux1_L0+0 
;log.c,79 :: 		}
L_logB_dir31:
;log.c,80 :: 		if(logB[ii]==2 && aux2==0){
	MOVLW       _logB+0
	MOVWF       FSR0 
	MOVLW       hi_addr(_logB+0)
	MOVWF       FSR0H 
	MOVF        logB_dir_ii_L0+0, 0 
	ADDWF       FSR0, 1 
	MOVLW       0
	BTFSC       logB_dir_ii_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_logB_dir34
	MOVF        logB_dir_aux2_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logB_dir34
L__logB_dir50:
;log.c,81 :: 		Bpn=ii;
	MOVF        logB_dir_ii_L0+0, 0 
	MOVWF       _Bpn+0 
;log.c,82 :: 		aux2=1;
	MOVLW       1
	MOVWF       logB_dir_aux2_L0+0 
;log.c,83 :: 		}
L_logB_dir34:
;log.c,75 :: 		for(ii=0; ii<logBindex;ii++){
	INCF        logB_dir_ii_L0+0, 1 
;log.c,84 :: 		}
	GOTO        L_logB_dir26
L_logB_dir27:
;log.c,85 :: 		aux1=0;
	CLRF        logB_dir_aux1_L0+0 
;log.c,86 :: 		aux2=0;
	CLRF        logB_dir_aux2_L0+0 
;log.c,87 :: 		for(ii=1;ii<=logBindex;ii++){
	MOVLW       1
	MOVWF       logB_dir_ii_L0+0 
L_logB_dir35:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	BTFSC       logB_dir_ii_L0+0, 7 
	MOVLW       127
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__logB_dir63
	MOVF        logB_dir_ii_L0+0, 0 
	SUBWF       _logBindex+0, 0 
L__logB_dir63:
	BTFSS       STATUS+0, 0 
	GOTO        L_logB_dir36
;log.c,88 :: 		if(logB[logBindex-ii]==1 && aux1==0){
	MOVF        logB_dir_ii_L0+0, 0 
	SUBWF       _logBindex+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	BTFSC       logB_dir_ii_L0+0, 7 
	MOVLW       255
	SUBWFB      R1, 1 
	MOVLW       _logB+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_logB+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_logB_dir40
	MOVF        logB_dir_aux1_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logB_dir40
L__logB_dir49:
;log.c,89 :: 		Bpm=logBindex-ii;
	MOVF        logB_dir_ii_L0+0, 0 
	SUBWF       _logBindex+0, 0 
	MOVWF       _Bpm+0 
;log.c,90 :: 		aux1=1;
	MOVLW       1
	MOVWF       logB_dir_aux1_L0+0 
;log.c,91 :: 		}
L_logB_dir40:
;log.c,92 :: 		if(logB[logBindex-ii]==3 && aux2==0){
	MOVF        logB_dir_ii_L0+0, 0 
	SUBWF       _logBindex+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	BTFSC       logB_dir_ii_L0+0, 7 
	MOVLW       255
	SUBWFB      R1, 1 
	MOVLW       _logB+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_logB+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_logB_dir43
	MOVF        logB_dir_aux2_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_logB_dir43
L__logB_dir48:
;log.c,93 :: 		Bpx=logBindex-ii;
	MOVF        logB_dir_ii_L0+0, 0 
	SUBWF       _logBindex+0, 0 
	MOVWF       _Bpx+0 
;log.c,94 :: 		aux2=1;
	MOVLW       1
	MOVWF       logB_dir_aux2_L0+0 
;log.c,95 :: 		}
L_logB_dir43:
;log.c,87 :: 		for(ii=1;ii<=logBindex;ii++){
	INCF        logB_dir_ii_L0+0, 1 
;log.c,96 :: 		}
	GOTO        L_logB_dir35
L_logB_dir36:
;log.c,97 :: 		}
L_end_logB_dir:
	RETURN      0
; end of _logB_dir
