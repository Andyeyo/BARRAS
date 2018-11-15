#include "extern.h"

void counter(void){

    if(aa!=0 && bb!=0 && cc!=0 && dd!=0 && ee!=0){ //cuando todo estan recibiendo luz
        if(bk==1){
            contador_seg=0;
            BUZZER = 1;
            bk=0;
        }
        if(pp==1){ //flanco descendente

            if(logC>=2){ //piso plano
            //if(logC>0){ //gradas
                //analizar log A

                if(Apm!=-1 && Apn!=-1 && Apx!=-1 && Apy!=-1){
                    if(Apm>Apx){
                        //XM
                        if(Apn>Apy){ // entra-entra
                            //YNXM
                            resultadoA='E';
                        }
                        else{ //sale-entra
                            //NYXM
                            resultadoA='Q';
                        }
                    }
                    else{
                        //MX
                        if(Apn>Apy){ //entra-sale
                            //YNMX
                            resultadoA='P';
                        }
                        else{ //sale-sale
                            //NYMX
                            resultadoA='S';
                        }
                    }
                }

                //analizar log B

                if(Bpm!=-1 && Bpn!=-1 && Bpx!=-1 && Bpy!=-1){
                    if(Bpm>Bpx){
                        //XM
                        if(Bpn>Bpy){ // entra-entra
                            //YNXM
                            resultadoB='E';
                        }
                        else{ // sale-entra
                            //NYXM
                            resultadoB='Q';
                        }
                    }
                    else{
                        //MX
                        if(Bpn>Bpy){ //entro-sale
                            //YNMX
                            resultadoB='P';
                        }
                        else{ //sale-sale
                            //NYMX
                            resultadoB='S';
                        }
                    }
                }
                //tomar decisión
                if(resultadoA!='X' && resultadoB!='X'){
                    if(resultadoB=='S' || (resultadoA=='S' && resultadoB=='P')){
                        resultadoT='S';
                    }
                    if(resultadoB=='E' || (resultadoA=='E' && resultadoB=='Q')){
                        resultadoT='E';
                    }
                }

                if(pos==1){
                    if(resultadoT=='E'){ resultadoT='X'; }
                }
                else if(pos==11){
                    if(resultadoT=='S'){ resultadoT='X'; }
                }
                else if(pos==111){
                    if(resultadoT=='E'){ resultadoT='S'; }
                    else if(resultadoT=='S'){ resultadoT='E'; }
                }
                else if(pos==110){
                    if(resultadoT=='E'){ resultadoT='S'; }
                    else if(resultadoT=='S'){ resultadoT='X'; }
                }
                else if(pos==100){
                    if(resultadoT=='E'){ resultadoT='X'; }
                    else if(resultadoT=='S'){ resultadoT='E'; }
                }


                if(resultadoT=='E'){
                    ENTRAN++;
                    NUMPER=ENTRAN+SALEN;
                    resultadoT='X';
                    //BUZZER=0; Delay_ms(100); BUZZER=1;
                    rs485_slave_send();
                    save_data();
                }
                if(resultadoT=='S'){
                    SALEN++;
                    NUMPER=ENTRAN+SALEN;
                    resultadoT='X';
                    /*
                    BUZZER=0; Delay_ms(50);
                    BUZZER=1; Delay_ms(50);
                    BUZZER=0; Delay_ms(50); 
                    BUZZER=1;
                    */
                    rs485_slave_send();
                    save_data();
                }

            }

            logC=0;
            Bpm=-1; Bpn=-1; Bpx=-1; Bpy=-1;
            Apm=-1; Apn=-1; Apx=-1; Apy=-1;
            iyn=0; ixm = 0; jyn=0; jxm=0;
            aa=2; bb=2; cc=2; dd=2; ee=2;
            pp=0; //flag de presencia
        }
    }

    if(aa==0 || bb==0 || cc==0 || dd==0 || ee==0){ //cuando alguno esta bloqueado
        if(pp==0){ //flanco ascendete
            pp=1;
            resultadoA='X';
            resultadoB='X';
            resultadoT='X';
        }
        if (bk==0){ bk=1; }
    }
}