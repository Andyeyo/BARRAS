//include
#include "var.h"  //declaraci�n var globales
#include "extern.h" //llamar variables y pre-definicion de metodos


void main() {
    init_setup();
    SUart0_Init_T();
    while(1){
        detect();
        if(RJ45){
            bloqueo();
            counter();
        }

    }
}