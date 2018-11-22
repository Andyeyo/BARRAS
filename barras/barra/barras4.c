//include
#include "var.h"  //declaración var globales
#include "extern.h" //llamar variables y pre-definicion de metodos

//pc
int cntax = 0;
char cadenaF[4];
unsigned long xx=0;
char DIN, i, j;

char datoRecibido[9];
void verificarPeticion(char dat[9]);
void indicadorOcupado(void);

// Interrupt routine RS485
void interrupt() 
{
    RS485Slave_Receive(datoRecibido);
}

void main() 
{
    init_setup();
    
    // inicio el 485 aparte
    UART1_Init(9600);                  // initialize UART1 module
    Delay_ms(100);
    //RS485Slave_Init(leerIdSlave()); //ORIGINAL PC obtiene la direccion seteada
    RS485Slave_Init(slave_id);

    slave_rx_dat[4] = 0;                        // ensure that message received flag is 0
    slave_rx_dat[5] = 0;                        // ensure that message received flag is 0
    slave_rx_dat[6] = 0;                        // ensure that error flag is 0

    RCIE_bit = 1;                      // enable interrupt on UART1 receive
    TXIE_bit = 0;                      // disable interrupt on UART1 transmit
    PEIE_bit = 1;                      // enable peripheral interrupts
    GIE_bit = 1;                       // enable all interrupts
    //fin de config de 485
    
    SUart0_Write('E');
    SUart0_Write('S');
    SUart0_Write((leerIdSlave()/10)+48);
    SUart0_Write('\r');
    SUart0_Write('\n');

    while(1)
    {
        detect();
        if(RJ45)
        {
            bloqueo();
            counter();
        }

        /*Verificar que no exista interrupciones en los sensores para atender
          a peticion del mestro*/
        if(!DET1 && !DET2 && !DET3 && !DET4 && !DET5)
            verificarPeticion(datoRecibido);          //leer bus 485
        else
            indicadorOcupado();

    }
}

void verificarPeticion(char dat[9])
{
    if (datoRecibido[5])  //msm error
    {
        datoRecibido[5] = 0;         //limpiar bandera
    }
    if (datoRecibido[4])  //msm OK
    {
        PORTB.B1 = 1; PORTB.B2 = 1; //indicador visual de peticion
        datoRecibido[4] = 0;        //limpiar bandera
        j = datoRecibido[0];        //obtengo dato entrante
        if(j = 0xFF) //comprueba que la peticion del maestro es correcta
        {
            rs485_slave_send();     //responde al maestro con in, out y blk
            PORTB.B1 = 0; PORTB.B2 = 0; //apaga indicadores visuales
        }
        else
        {
            SUart0_Write('N');
            SUart0_Write('P');
            SUart0_Write('I');
            SUart0_Write('\r');
            SUart0_Write('\n');
        }
    }
}

void indicadorOcupado()
{
/*
    SUart0_Write('O');
    SUart0_Write('C');
    SUart0_Write('U');
    SUart0_Write('\r');
    SUart0_Write('\n');
*/
    PORTB.B1 = ~PORTB.B1;
}