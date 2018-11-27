
_detect:

;detect.c,3 :: 		void detect(void)
;detect.c,5 :: 		unsigned short int j1 = 0;
	CLRF        detect_j1_L0+0 
	CLRF        detect_j2_L0+0 
	CLRF        detect_j3_L0+0 
;detect.c,9 :: 		if (PORTD.B7)
	BTFSS       PORTD+0, 7 
	GOTO        L_detect0
;detect.c,24 :: 		}
L_detect0:
;detect.c,26 :: 		if(!OPTO)
	BTFSC       PORTE+0, 2 
	GOTO        L_detect1
;detect.c,31 :: 		}
L_detect1:
;detect.c,34 :: 		if(DET5){
	BTFSS       PORTB+0, 6 
	GOTO        L_detect2
;detect.c,35 :: 		if(ee>0){ //flanco descendente : empieza a estar interrumpido
	MOVF        _ee+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_detect3
;detect.c,37 :: 		if(Apy == -1){
	MOVF        _Apy+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_detect4
;detect.c,38 :: 		Apy=iyn;
	MOVF        _iyn+0, 0 
	MOVWF       _Apy+0 
;detect.c,39 :: 		iyn++;
	INCF        _iyn+0, 1 
;detect.c,40 :: 		}
L_detect4:
;detect.c,41 :: 		ee=0;
	CLRF        _ee+0 
;detect.c,42 :: 		SUart0_Write('A');
	MOVLW       65
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,43 :: 		SUart0_Write('Y');
	MOVLW       89
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,44 :: 		}
L_detect3:
;detect.c,45 :: 		}
	GOTO        L_detect5
L_detect2:
;detect.c,47 :: 		if(ee==0){ // flanco ascendente : empieza a recibir luz
	MOVF        _ee+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_detect6
;detect.c,49 :: 		Apx = ixm;
	MOVF        _ixm+0, 0 
	MOVWF       _Apx+0 
;detect.c,50 :: 		ixm++;
	MOVLW       1
	ADDWF       _ixm+0, 1 
	MOVLW       0
	ADDWFC      _ixm+1, 1 
	ADDWFC      _ixm+2, 1 
	ADDWFC      _ixm+3, 1 
;detect.c,53 :: 		if(ixm >= 4294967000)
	MOVLW       255
	SUBWF       _ixm+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__detect50
	MOVLW       255
	SUBWF       _ixm+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__detect50
	MOVLW       254
	SUBWF       _ixm+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__detect50
	MOVLW       216
	SUBWF       _ixm+0, 0 
L__detect50:
	BTFSS       STATUS+0, 0 
	GOTO        L_detect7
;detect.c,55 :: 		if(Apx > Apm)
	MOVLW       128
	XORWF       _Apm+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apx+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_detect8
;detect.c,57 :: 		Apx = 1;
	MOVLW       1
	MOVWF       _Apx+0 
;detect.c,58 :: 		Apm = 0;
	CLRF        _Apm+0 
;detect.c,59 :: 		}
	GOTO        L_detect9
L_detect8:
;detect.c,62 :: 		Apx = 0;
	CLRF        _Apx+0 
;detect.c,63 :: 		Apm = 1;
	MOVLW       1
	MOVWF       _Apm+0 
;detect.c,64 :: 		}
L_detect9:
;detect.c,65 :: 		ixm = 2;
	MOVLW       2
	MOVWF       _ixm+0 
	MOVLW       0
	MOVWF       _ixm+1 
	MOVWF       _ixm+2 
	MOVWF       _ixm+3 
;detect.c,66 :: 		}
L_detect7:
;detect.c,68 :: 		ee = 1;
	MOVLW       1
	MOVWF       _ee+0 
;detect.c,69 :: 		SUart0_Write('A');
	MOVLW       65
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,70 :: 		SUart0_Write('X');
	MOVLW       88
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,71 :: 		}
L_detect6:
;detect.c,72 :: 		}
L_detect5:
;detect.c,74 :: 		if(DET4){
	BTFSS       PORTB+0, 7 
	GOTO        L_detect10
;detect.c,75 :: 		if(dd>0){ //flanco descendente : empieza a estar bloqueado
	MOVF        _dd+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_detect11
;detect.c,77 :: 		if(Apn == -1){
	MOVF        _Apn+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_detect12
;detect.c,78 :: 		Apn = iyn;
	MOVF        _iyn+0, 0 
	MOVWF       _Apn+0 
;detect.c,79 :: 		iyn++;
	INCF        _iyn+0, 1 
;detect.c,80 :: 		}
L_detect12:
;detect.c,81 :: 		dd=0;
	CLRF        _dd+0 
;detect.c,82 :: 		SUart0_Write('A');
	MOVLW       65
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,83 :: 		SUart0_Write('N');
	MOVLW       78
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,84 :: 		}
L_detect11:
;detect.c,85 :: 		}
	GOTO        L_detect13
L_detect10:
;detect.c,87 :: 		if(dd==0){ // flanco ascendente : empieza a recibir luz
	MOVF        _dd+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_detect14
;detect.c,89 :: 		Apm = ixm * sumi;
	MOVF        _ixm+0, 0 
	MULWF       _sumi+0 
	MOVF        PRODL+0, 0 
	MOVWF       _Apm+0 
;detect.c,90 :: 		ixm++;
	MOVLW       1
	ADDWF       _ixm+0, 1 
	MOVLW       0
	ADDWFC      _ixm+1, 1 
	ADDWFC      _ixm+2, 1 
	ADDWFC      _ixm+3, 1 
;detect.c,93 :: 		if(ixm >= 4294967000)
	MOVLW       255
	SUBWF       _ixm+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__detect51
	MOVLW       255
	SUBWF       _ixm+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__detect51
	MOVLW       254
	SUBWF       _ixm+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__detect51
	MOVLW       216
	SUBWF       _ixm+0, 0 
L__detect51:
	BTFSS       STATUS+0, 0 
	GOTO        L_detect15
;detect.c,95 :: 		if(Apx > Apm)
	MOVLW       128
	XORWF       _Apm+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Apx+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_detect16
;detect.c,97 :: 		Apx = 1;
	MOVLW       1
	MOVWF       _Apx+0 
;detect.c,98 :: 		Apm = 0;
	CLRF        _Apm+0 
;detect.c,99 :: 		}
	GOTO        L_detect17
L_detect16:
;detect.c,102 :: 		Apx = 0;
	CLRF        _Apx+0 
;detect.c,103 :: 		Apm = 1;
	MOVLW       1
	MOVWF       _Apm+0 
;detect.c,104 :: 		}
L_detect17:
;detect.c,105 :: 		ixm = 2;
	MOVLW       2
	MOVWF       _ixm+0 
	MOVLW       0
	MOVWF       _ixm+1 
	MOVWF       _ixm+2 
	MOVWF       _ixm+3 
;detect.c,106 :: 		}
L_detect15:
;detect.c,107 :: 		dd = 1;
	MOVLW       1
	MOVWF       _dd+0 
;detect.c,108 :: 		SUart0_Write('A');
	MOVLW       65
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,109 :: 		SUart0_Write('M');
	MOVLW       77
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,110 :: 		}
L_detect14:
;detect.c,111 :: 		}
L_detect13:
;detect.c,113 :: 		if(DET3){
	BTFSS       PORTE+0, 1 
	GOTO        L_detect18
;detect.c,114 :: 		if(cc>0){ //flanco descendente : empieza a estar bloqueado
	MOVF        _cc+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_detect19
;detect.c,116 :: 		if(Bpy == -1){
	MOVF        _Bpy+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_detect20
;detect.c,117 :: 		Bpy=jyn;
	MOVF        _jyn+0, 0 
	MOVWF       _Bpy+0 
;detect.c,118 :: 		jyn++;
	INCF        _jyn+0, 1 
;detect.c,119 :: 		}
L_detect20:
;detect.c,120 :: 		cc=0;
	CLRF        _cc+0 
;detect.c,121 :: 		SUart0_Write('B');
	MOVLW       66
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,122 :: 		SUart0_Write('Y');
	MOVLW       89
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,123 :: 		}
L_detect19:
;detect.c,124 :: 		}
	GOTO        L_detect21
L_detect18:
;detect.c,126 :: 		if(cc==0){ // flanco ascendente : empieza a recibir luz
	MOVF        _cc+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_detect22
;detect.c,128 :: 		Bpx = jxm;
	MOVF        _jxm+0, 0 
	MOVWF       _Bpx+0 
;detect.c,129 :: 		jxm++;
	MOVLW       1
	ADDWF       _jxm+0, 1 
	MOVLW       0
	ADDWFC      _jxm+1, 1 
	ADDWFC      _jxm+2, 1 
	ADDWFC      _jxm+3, 1 
;detect.c,132 :: 		if(jxm > 4294967000)
	MOVF        _jxm+3, 0 
	SUBLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__detect52
	MOVF        _jxm+2, 0 
	SUBLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__detect52
	MOVF        _jxm+1, 0 
	SUBLW       254
	BTFSS       STATUS+0, 2 
	GOTO        L__detect52
	MOVF        _jxm+0, 0 
	SUBLW       216
L__detect52:
	BTFSC       STATUS+0, 0 
	GOTO        L_detect23
;detect.c,134 :: 		if(Bpx > Bpm)
	MOVLW       128
	XORWF       _Bpm+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpx+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_detect24
;detect.c,136 :: 		Bpx = 1;
	MOVLW       1
	MOVWF       _Bpx+0 
;detect.c,137 :: 		Bpm = 0;
	CLRF        _Bpm+0 
;detect.c,138 :: 		}
	GOTO        L_detect25
L_detect24:
;detect.c,141 :: 		Bpx = 0;
	CLRF        _Bpx+0 
;detect.c,142 :: 		Bpm = 1;
	MOVLW       1
	MOVWF       _Bpm+0 
;detect.c,143 :: 		}
L_detect25:
;detect.c,144 :: 		jxm = 2;
	MOVLW       2
	MOVWF       _jxm+0 
	MOVLW       0
	MOVWF       _jxm+1 
	MOVWF       _jxm+2 
	MOVWF       _jxm+3 
;detect.c,146 :: 		}
L_detect23:
;detect.c,147 :: 		cc = 1;
	MOVLW       1
	MOVWF       _cc+0 
;detect.c,148 :: 		SUart0_Write('B');
	MOVLW       66
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,149 :: 		SUart0_Write('X');
	MOVLW       88
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,150 :: 		}
L_detect22:
;detect.c,151 :: 		}
L_detect21:
;detect.c,153 :: 		if(DET2){
	BTFSS       PORTA+0, 3 
	GOTO        L_detect26
;detect.c,154 :: 		if(bb>0){ //flanco descendente : empieza a estar bloqueado
	MOVF        _bb+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_detect27
;detect.c,156 :: 		if(Bpn == -1){
	MOVF        _Bpn+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_detect28
;detect.c,157 :: 		Bpn = jyn;
	MOVF        _jyn+0, 0 
	MOVWF       _Bpn+0 
;detect.c,158 :: 		jyn++;
	INCF        _jyn+0, 1 
;detect.c,159 :: 		}
L_detect28:
;detect.c,160 :: 		bb=0;
	CLRF        _bb+0 
;detect.c,161 :: 		SUart0_Write('B');
	MOVLW       66
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,162 :: 		SUart0_Write('N');
	MOVLW       78
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,163 :: 		}
L_detect27:
;detect.c,164 :: 		}
	GOTO        L_detect29
L_detect26:
;detect.c,166 :: 		if(bb==0){ // flanco ascendente : empieza a recibir luz
	MOVF        _bb+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_detect30
;detect.c,168 :: 		Bpm = jxm * sumj;
	MOVF        _jxm+0, 0 
	MULWF       _sumj+0 
	MOVF        PRODL+0, 0 
	MOVWF       _Bpm+0 
;detect.c,169 :: 		jxm++;
	MOVLW       1
	ADDWF       _jxm+0, 1 
	MOVLW       0
	ADDWFC      _jxm+1, 1 
	ADDWFC      _jxm+2, 1 
	ADDWFC      _jxm+3, 1 
;detect.c,172 :: 		if(jxm > 4294967000)
	MOVF        _jxm+3, 0 
	SUBLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__detect53
	MOVF        _jxm+2, 0 
	SUBLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L__detect53
	MOVF        _jxm+1, 0 
	SUBLW       254
	BTFSS       STATUS+0, 2 
	GOTO        L__detect53
	MOVF        _jxm+0, 0 
	SUBLW       216
L__detect53:
	BTFSC       STATUS+0, 0 
	GOTO        L_detect31
;detect.c,174 :: 		if(Bpx > Bpm)
	MOVLW       128
	XORWF       _Bpm+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _Bpx+0, 0 
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_detect32
;detect.c,176 :: 		Bpx = 1;
	MOVLW       1
	MOVWF       _Bpx+0 
;detect.c,177 :: 		Bpm = 0;
	CLRF        _Bpm+0 
;detect.c,178 :: 		}
	GOTO        L_detect33
L_detect32:
;detect.c,181 :: 		Bpx = 0;
	CLRF        _Bpx+0 
;detect.c,182 :: 		Bpm = 1;
	MOVLW       1
	MOVWF       _Bpm+0 
;detect.c,183 :: 		}
L_detect33:
;detect.c,184 :: 		jxm = 2;
	MOVLW       2
	MOVWF       _jxm+0 
	MOVLW       0
	MOVWF       _jxm+1 
	MOVWF       _jxm+2 
	MOVWF       _jxm+3 
;detect.c,185 :: 		}
L_detect31:
;detect.c,187 :: 		bb = 1;
	MOVLW       1
	MOVWF       _bb+0 
;detect.c,188 :: 		SUart0_Write('B');
	MOVLW       66
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,189 :: 		SUart0_Write('M');
	MOVLW       77
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,190 :: 		}
L_detect30:
;detect.c,191 :: 		}
L_detect29:
;detect.c,193 :: 		if(DET1){
	BTFSS       PORTA+0, 4 
	GOTO        L_detect34
;detect.c,194 :: 		if(aa>0){ //flanco descendente : empieza a estar bloqueado
	MOVF        _aa+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_detect35
;detect.c,195 :: 		logC++;
	INCF        _logC+0, 1 
;detect.c,196 :: 		aa=0;
	CLRF        _aa+0 
;detect.c,197 :: 		SUart0_Write('C');
	MOVLW       67
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,198 :: 		}
L_detect35:
;detect.c,199 :: 		}
	GOTO        L_detect36
L_detect34:
;detect.c,201 :: 		if(aa==0){ // flanco ascendente : empieza a recibir luz
	MOVF        _aa+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_detect37
;detect.c,202 :: 		logC++;
	INCF        _logC+0, 1 
;detect.c,203 :: 		aa = 1;
	MOVLW       1
	MOVWF       _aa+0 
;detect.c,204 :: 		SUart0_Write('C');
	MOVLW       67
	MOVWF       FARG_SUart0_Write_tch+0 
	CALL        _SUart0_Write+0, 0
;detect.c,205 :: 		}
L_detect37:
;detect.c,206 :: 		}
L_detect36:
;detect.c,209 :: 		if(aa==0 || bb==0 || cc==0 || dd==0 || ee==0){
	MOVF        _aa+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__detect48
	MOVF        _bb+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__detect48
	MOVF        _cc+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__detect48
	MOVF        _dd+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__detect48
	MOVF        _ee+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__detect48
	GOTO        L_detect40
L__detect48:
;detect.c,210 :: 		LED_V=0;
	BCF         PORTE+0, 0 
;detect.c,211 :: 		LED_A=0;
	BCF         PORTC+0, 5 
;detect.c,212 :: 		LED_R=1;
	BSF         PORTA+0, 5 
;detect.c,213 :: 		}
	GOTO        L_detect41
L_detect40:
;detect.c,215 :: 		LED_V=1;
	BSF         PORTE+0, 0 
;detect.c,216 :: 		LED_A=1;
	BSF         PORTC+0, 5 
;detect.c,217 :: 		LED_R=0;
	BCF         PORTA+0, 5 
;detect.c,218 :: 		}
L_detect41:
;detect.c,220 :: 		if(jumper1){ j1 = 100;}else{ j1 = 0; }
	BTFSS       PORTD+0, 3 
	GOTO        L_detect42
	MOVLW       100
	MOVWF       detect_j1_L0+0 
	GOTO        L_detect43
L_detect42:
	CLRF        detect_j1_L0+0 
L_detect43:
;detect.c,222 :: 		if(jumper2){ j2 = 10; }else{ j2 = 0; }
	BTFSS       PORTC+0, 4 
	GOTO        L_detect44
	MOVLW       10
	MOVWF       detect_j2_L0+0 
	GOTO        L_detect45
L_detect44:
	CLRF        detect_j2_L0+0 
L_detect45:
;detect.c,224 :: 		if(jumper3){ j3 = 1;  }else{ j3 = 0; }
	BTFSS       PORTD+0, 4 
	GOTO        L_detect46
	MOVLW       1
	MOVWF       detect_j3_L0+0 
	GOTO        L_detect47
L_detect46:
	CLRF        detect_j3_L0+0 
L_detect47:
;detect.c,226 :: 		pos = j1 + j2 + j3;
	MOVF        detect_j2_L0+0, 0 
	ADDWF       detect_j1_L0+0, 0 
	MOVWF       _pos+0 
	MOVF        detect_j3_L0+0, 0 
	ADDWF       _pos+0, 1 
;detect.c,227 :: 		}
L_end_detect:
	RETURN      0
; end of _detect
