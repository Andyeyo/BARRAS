#include "extern.h"
#define limit 28000 //aprox. 1 seg

void bloqueo(void)
{
        contador++;
        if (contador>=limit)
        {
            contador=0;
            if(aa+bb+cc+dd+ee<=6 && bk==1)
            {
                SUart0_Write('B');
                SUart0_Write('\r');
                SUart0_Write('\n');
            
                contador_seg++;
                if(contador_seg==5)
                {
                    BLOQUEOS++;
                }
            }
        }

        if((contador==0 || contador==(limit*0.5)) && (contador_seg>=3))
        {
            BUZZER=1;
        }

        if((contador==(limit*0.17) || contador==(limit*0.67)) && (contador_seg>=3))
        {
            BUZZER=0;
        }
}