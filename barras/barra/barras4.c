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
int almacenarDatos(void);
int guardado_flag;

// Rutina de interrupcion del bus RS485
void interrupt() 
{
    RS485Slave_Receive(datoRecibido);
}

void main() 
{
    init_setup();
    
    // inicio el 485 aparte
    UART1_Init(9600);                  // Iniciar modulo UART
    Delay_ms(100);
    RS485Slave_Init(leerIdSlave());    // Inicia RS485 con la direccion seteada por Dipswitch
    //RS485Slave_Init(slave_id);       // Inicia RS485 con direccion seteada en extern

    slave_rx_dat[4] = 0;               // Limpiar banderas de comunicacion 485
    slave_rx_dat[5] = 0;
    slave_rx_dat[6] = 0;

    RCIE_bit = 1;                      // Habilitar interrupcion serial en RX
    TXIE_bit = 0;                      // Deshabilar interrupcion serial en TX
    PEIE_bit = 1;                      // Habilitar interrupciones en perifericos
    GIE_bit = 1;                       // Habilitar control de interrupcion global
    //fin de config de 485
    
    //comprobar direccion de esclavo a traves del puerto UART
    SUart0_Write('E');
    SUart0_Write('S');
    SUart0_Write((leerIdSlave()/10)+48);
    SUart0_Write('\r');
    SUart0_Write('\n');

    /*
        Leer valores almacenados en la eeprom para evitar perdida de informacion
        Funcion asigna a variables ENTRAN, SALEN y BLOQUEOS los valores almacenados
        en la EEPROM
    */
    read_data();

    while(1)
    {
        /*
            SUart0_Write('V');
            SUart0_Write('I');
            SUart0_Write(':');
            if(OPTO == 1)
                SUart0_Write('I');
            else
                SUart0_Write('0');
            SUart0_Write('\r');
            SUart0_Write('\n');
        */

        detect();
        if(RJ45)
        {
            bloqueo();
            counter();
        }

        /*
            Verificar que es suministro electrico de las barras, en caso de que 
            no exista suministro: almacenar el conteo y verificar que se haya 
            almacenado.
            NOTA: logica inversa actualmente cuando hay energía
            voltaje_in = 0
            cuando no hay energia
            voltaje_in = 1
        */
        while(OPTO == 1)
        {
        
            LED_A = ~LED_A;

            SUart0_Write('S');
            SUart0_Write('I');
            SUart0_Write('N');
            SUart0_Write('\r');
            SUart0_Write('\n');
            

            
            /*
                Se almacenan los datos de la memoria FLASH usando el metodo
                almacenar datos que retorna un 1 o 0 dependiendo de si fue 
                exitoso o no.
                Ademas, se agrego una bandera de guardado para que no reintente
                hacerlo nuevamente si la tarea fue exitosa.
            */
            almacenarDatos();  //redundancia para asegurar el almacenamiento de 
                               //los datos
            delay_ms(100);
            if(almacenarDatos() == 1 && guardado_flag == 0)
            {
                SUart0_Write('G');
                SUart0_Write('O');
                SUart0_Write('K');
                SUart0_Write('\r');
                SUart0_Write('\n');
                guardado_flag = 1;
                LED_V = ~LED_V;
            }
        }

        /*
            De comprobarse que el estado del suministro electrico a cambiado 
            reinicia la bandera de almacenamiento.
        */
        
        if(OPTO == 0)
        {
            read_data();
            guardado_flag = 0;
            PORTB.B1 = 0;
        }
        
        /*
            Verificar que no exista interrupciones en los sensores para atender
            a peticion del mestro
        */
        if(!DET1 && !DET2 && !DET3 && !DET4 && !DET5)
            verificarPeticion(datoRecibido);          //leer bus 485 en busca de dato entrante
        else
            indicadorOcupado();                       //indicar que esta ocupado

    }
}

/*
    Metodo obtiene la peticion de llegada del BUS 485 y verifica si la peticion
    es 0XFF(mensaje de peticion enviado por el master). De comprobarse envia una
    respuesta que contiene el numero de entradas, salidas y BLOQUEOS.
    Obtiene:    array de caracteres con el mensaje RS485
    Retorna:    nada
*/
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
        if(j = 0xFF)                //comprueba que la peticion del maestro es correcta
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

/*
    Almacena los datos almacenados en las variables ENTRAN, SALEN Y BLOQUEOS en
    la memoria EEPROM. En caso de ser exitoso retorna un valor de UNO y de
    presentarse un error, retorna un valor de CERO.
    Obtiene:    Nada
    Retorna:    Respuesta del almacenamiento Uno o Cero
*/
int almacenarDatos(void)
{
    unsigned long int V_in,V_sal,V_bloc;
    //guardar los datos de la flash en variables volatiles
    V_in   = ENTRAN;
    V_sal  = SALEN;
    V_bloc = BLOQUEOS;
    //almacenar los datos en memoria EEPROM
    save_data();
    //leer los datos almacenados a la EEPROM y se asignan en las variables
    //ENTRAN, SALEN, BLOQUEOS
    read_data();
    //comprobar si los datos almacenados son los mismos de la memoria flash
    if(ENTRAN == V_in && SALEN == V_sal && BLOQUEOS == V_bloc)
    {
        return 1; /*si es verdadero, retorna 1 correspondiente a existoso*/
    }
    else
    {
        ENTRAN   = V_in;
        SALEN    = V_sal;
        BLOQUEOS = V_bloc;
        return 0; /*Si es falso, reasigna los valores de la flash anteriormente
                    sobreescritos y retorna un 0 correspondiente a error*/
    }
}

/*
    Con fines de prueba, muestra un intercambio en el pin RB1 si se presentan
    problemas o el buffer 485 se encuentra ocupado.
*/
void indicadorOcupado()
{
    PORTB.B1 = ~PORTB.B1;
}