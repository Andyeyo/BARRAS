#include "extern.h"

void detect(void)
{
    unsigned short int j1 = 0;
    unsigned short int j2 = 0;
    unsigned short int j3 = 0;

    if (PORTD.B7)
    {
        //ENVIAR 485

        /*output_LOW(PIN_D0);
      conversion_trama();
      FPRINTF(PORT1, "\n\rEnviando al ID %d:>  ", send_addr);
      FPRINTF(PORT1, "\n\r");
      for (i = 0; i < RS485_RX_BUFFER_SIZE; i++)
      {
        FPRINTF(PORT1, "%d:  %d", i,trama_send[i] - 10);
      }
      FPRINTF(PORT1, "\n\r");
      RS485send(trama_send, send_addr);
      RCV_OFF();*/
    }

    if(!OPTO)
    {
        //guardar en la eeprom
        /*dato_eeprom = 1;
        guardar_eeprom();*/
    }

   //LEDS INFRARROJOS
    if(DET5){
        if(ee>0){ //flanco descendente : empieza a estar interrumpido
            //Y
            if(Apy == -1){
                Apy=iyn;
                iyn++;
            }
            ee=0;
            SUart0_Write('A');
            SUart0_Write('Y');  
        }
    }
    else{
        if(ee==0){ // flanco ascendente : empieza a recibir luz
            //X
            Apx = ixm;
            ixm++;
            /* verificar desbordamiento de ixm*/
            /* "IXM" es un Unsigned Short y va de 0 .. 4294967295 */
            if(ixm >= 4294967000)
            {
                if(Apx > Apm)
                {
                    Apx = 1;
                    Apm = 0;
                }
                else
                {
                    Apx = 0;
                    Apm = 1;
                }
                ixm = 2;
            }

            ee = 1;
            SUart0_Write('A');
            SUart0_Write('X');
        }
    }

    if(DET4){
        if(dd>0){ //flanco descendente : empieza a estar bloqueado
            //N
            if(Apn == -1){
                Apn = iyn;
                iyn++;
            }
            dd=0;
            SUart0_Write('A');
            SUart0_Write('N');
        }
    }
    else{
        if(dd==0){ // flanco ascendente : empieza a recibir luz
            //M
            Apm = ixm * sumi;
            ixm++;
            /*Verificar e desbordamiento de ixm*/
            /* "IXM" es un Unsigned Short y va de 0 .. 4294967295 */
            if(ixm >= 4294967000)
            {
                if(Apx > Apm)
                {
                    Apx = 1;
                    Apm = 0;
                }
                else
                {
                    Apx = 0;
                    Apm = 1;
                }
                ixm = 2;
            }
            dd = 1;
            SUart0_Write('A');
            SUart0_Write('M');
        }
    }

    if(DET3){
        if(cc>0){ //flanco descendente : empieza a estar bloqueado
            //Y
            if(Bpy == -1){
                Bpy=jyn;
                jyn++;
            }
            cc=0;
            SUart0_Write('B');
            SUart0_Write('Y');
        }
    }
    else{
        if(cc==0){ // flanco ascendente : empieza a recibir luz
            //X
            Bpx = jxm;
            jxm++;
            /* verificar desbordamiento de jxm*/
            /* "JXM" es un Unsigned Short y va de 0 .. 4294967295 */
            if(jxm > 4294967000)
            {
                if(Bpx > Bpm)
                {
                    Bpx = 1;
                    Bpm = 0;
                }
                else
                {
                    Bpx = 0;
                    Bpm = 1;
                }
                jxm = 2;

            }
            cc = 1;
            SUart0_Write('B');
            SUart0_Write('X');
        }
    }

    if(DET2){
        if(bb>0){ //flanco descendente : empieza a estar bloqueado
            //N
            if(Bpn == -1){
                Bpn = jyn;
                jyn++;
            }
            bb=0;
            SUart0_Write('B');
            SUart0_Write('N');
        }
    }
    else{
        if(bb==0){ // flanco ascendente : empieza a recibir luz
            //M
            Bpm = jxm * sumj;
            jxm++;
            /*Verificar e desbordamiento de ixm*/
            /* "JXM" es un Unsigned Short y va de 0 .. 4294967295 */
            if(jxm > 4294967000)
            {
                if(Bpx > Bpm)
                {
                    Bpx = 1;
                    Bpm = 0;
                }
                else
                {
                    Bpx = 0;
                    Bpm = 1;
                }
                jxm = 2;
            }
            
            bb = 1;
            SUart0_Write('B');
            SUart0_Write('M');
        }
    }

    if(DET1){
        if(aa>0){ //flanco descendente : empieza a estar bloqueado
            logC++;
            aa=0;
            SUart0_Write('C');
        }
    }
    else{
        if(aa==0){ // flanco ascendente : empieza a recibir luz
            logC++;
            aa = 1;
            SUart0_Write('C');
        }
    }

    //LED RGB
    if(aa==0 || bb==0 || cc==0 || dd==0 || ee==0){
        LED_V=0;
        LED_A=0;
        LED_R=1;
    }
    else{
        LED_V=1;
        LED_A=1;
        LED_R=0;
    }

    if(jumper1){ j1 = 100;}else{ j1 = 0; }

    if(jumper2){ j2 = 10; }else{ j2 = 0; }

    if(jumper3){ j3 = 1;  }else{ j3 = 0; }

    pos = j1 + j2 + j3;
}