#include "extern.h"
#define limit 14000 //aprox. 1 seg

void bloqueo(void){
        contador++;
        if (contador>=limit){
            contador=0;
            if(aa+bb+cc+dd+ee<=6 && bk==1){
                contador_seg++;
                if(contador_seg==5){
                    BLOQUEOS++;
                }
            }
        }

        if((contador==0 || contador==(limit*0.5)) && (contador_seg>=5)){
            BUZZER=0;
        }

        if((contador==(limit*0.17) || contador==(limit*0.67)) && (contador_seg>=5)){
            BUZZER=1;
        }
}